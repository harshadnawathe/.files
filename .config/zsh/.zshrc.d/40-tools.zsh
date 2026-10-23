# Tool activations. Every one goes through zsh_cached_eval (~/.zshenv:11-22),
# which sources a cached copy and regenerates it only when the generating
# binary is newer -- the same thing functions/cached_eval.fish did for fish.
#
# The second argument must be an ABSOLUTE path: it is the file whose mtime
# invalidates the cache, and `[[ $cache -nt tv ]]` is false whenever `tv` is
# not also a file in $PWD, so a bare name silently disables caching and
# re-forks the tool on every prompt.
#
# Order is load-bearing at the end: atuin has to come after television so that
# its ^R binding is the one that survives.

() {
  local brew_prefix=${HOMEBREW_PREFIX:-/opt/homebrew}

  # brew-file's wrapper. The non-.fish one; it guards itself with
  # `emulate -L ksh` for zsh and works unchanged.
  [[ -r $brew_prefix/etc/brew-wrap ]] && source $brew_prefix/etc/brew-wrap

  local bin
  for bin in starship zoxide tv workmux carapace; do
    [[ -x $brew_prefix/bin/$bin ]] || continue
    case $bin in
      # carapace's first line is `export PATH=".../carapace/bin:$PATH"` with
      # $PATH left unexpanded, so unlike mise's preamble it re-expands at
      # source time and is safe to cache.
      carapace) zsh_cached_eval carapace_init $brew_prefix/bin/$bin "$brew_prefix/bin/$bin _carapace zsh" ;;
      workmux)  zsh_cached_eval workmux_comp  $brew_prefix/bin/$bin "$brew_prefix/bin/$bin completions zsh" ;;
      *)        zsh_cached_eval ${bin}_init   $brew_prefix/bin/$bin "$brew_prefix/bin/$bin init zsh" ;;
    esac
  done
}

# --- carapace ---------------------------------------------------------------
# Completions for 500+ commands from one binary. The bridge list deliberately
# omits `fish`, which carapace also supports: step 9 removes fish, and a
# completion source that disappears later is worse than not having it now.
#
# carapace's install docs also set `zstyle ':completion:*' format` for its group
# headers. That is not carried here: .zstyles already sets format on
# ':completion:*:descriptions', which is the more specific pattern for the tag
# that actually draws group headers, so it wins -- the generic one only ever
# reached messages and warnings. One format style, in one file.
export CARAPACE_BRIDGES='zsh,bash'

# --- television -------------------------------------------------------------
# tv binds ^T and ^R into the current keymap only, which after `bindkey -v` is
# viins. `tv init fish` loops over `default insert` and binds both, so this is
# the missing half rather than an addition. ^R is handed to atuin below.
bindkey -M vicmd '^T' tv-smart-autocomplete

# --- starship: transient prompt ---------------------------------------------
# starship has no transience in zsh -- `enable_transience` is fish/bash/nu
# only, and `starship init zsh` emits nothing for it. .config/starship.toml
# gains a [profiles] transient = "$character", and this redraws the finished
# line with it.
#
# .config/starship.toml:12-17 justifies the full-width $fill line on the
# grounds that transience keeps it out of scrollback, so this is load-bearing
# rather than decoration.
# Everything below is guarded on starship actually being present. The init
# above already is; registering the hooks unconditionally meant that a missing
# starship -- an uninstall, a Homebrew prefix move, a machine stowed before
# `brew bundle` -- produced `command not found: starship` on every Enter, from
# inside a ZLE widget, and set PROMPT to the empty capture.
if [[ -x ${HOMEBREW_PREFIX:-/opt/homebrew}/bin/starship ]]; then

# starship sets PROMPT once, to a literal string containing a command
# substitution that prompt_subst re-evaluates on every draw -- it does not
# rebuild it in precmd. So overwriting PROMPT with rendered text destroys the
# template permanently, and every later prompt stays collapsed. Keep the
# template and put it back before the next prompt is drawn.
typeset -g _STARSHIP_PROMPT=$PROMPT
typeset -g _STARSHIP_RPROMPT=$RPROMPT

autoload -Uz add-zsh-hook
_starship_restore_prompt() {
  PROMPT=$_STARSHIP_PROMPT
  RPROMPT=$_STARSHIP_RPROMPT
}
add-zsh-hook precmd _starship_restore_prompt

# Memoised, because this runs on every accepted line and a `starship prompt`
# fork there is ~40ms of command lag. The transient format is $character
# alone, which only varies by success-vs-failure and by keymap, so there are
# four possible renders; they are computed on first use and reused after.
typeset -gA _STARSHIP_TRANSIENT_CACHE

autoload -Uz add-zle-hook-widget
_starship_transient_prompt() {
  # NOT `local prompt`: zsh ties `prompt` and `PROMPT` to the same parameter,
  # so declaring the lowercase one makes PROMPT function-local and the
  # assignment below never reaches the global the line editor reads. The
  # symptom is a transient prompt that computes correctly and changes nothing.
  local _status _keymap _key _transient

  # --status, not $?: inside a zle widget $? is whatever the widget last ran.
  # starship stashes the real one in precmd (starship init zsh:33) and unsets
  # it when no command ran, hence the default. Collapsed to 0/1 because
  # $character only distinguishes success from failure, and leaving the real
  # code in would make the cache miss on every distinct exit status.
  _status=$(( ${STARSHIP_CMD_STATUS:-0} != 0 ))
  # KEYMAP is `main` rather than `viins` in insert mode; starship only knows
  # the latter. STARSHIP_SHELL is exported by starship's own init and is what
  # makes vimcmd_symbol apply and the %{%} width markers appear.
  _keymap=${${KEYMAP:-viins}/main/viins}
  _key=$_status:$_keymap

  _transient=$_STARSHIP_TRANSIENT_CACHE[$_key]
  if [[ -z $_transient ]]; then
    _transient=$(starship prompt --profile transient \
                   --status=$_status --keymap=$_keymap)
    # add_newline is unset in starship.toml and so defaults to true, putting a
    # blank line in front of every prompt. Fine for the live one; in scrollback
    # it would cost a blank line per command, which is what transience is for.
    _transient=${_transient#$'\n'}
    _STARSHIP_TRANSIENT_CACHE[$_key]=$_transient
  fi

  PROMPT=$_transient
  RPROMPT=''
  zle .reset-prompt
}
add-zle-hook-widget zle-line-finish _starship_transient_prompt

fi

# --- atuin ------------------------------------------------------------------
# Last, so its ^R wins over television's.
#
# Both disables matter. Without them atuin takes the up arrow in viins AND
# vicmd, takes vicmd `k`, and takes vicmd `?` for its AI prompt -- so vi's
# up-motion and forward-search both stop working, and the fish-parity prefix
# search from 20-keybindings.zsh is replaced by a fuzzy popup. fish's up is a
# prefix search, not a history UI, so keeping ours is the parity choice.
#
# What it does take is ^r in viins and `/` in vicmd. `/` was
# vi-history-search-backward, so that is a history search becoming a better
# history search.
() {
  local bin=${HOMEBREW_PREFIX:-/opt/homebrew}/bin/atuin
  [[ -x $bin ]] || return
  zsh_cached_eval atuin_init $bin "$bin init zsh --disable-up-arrow --disable-ai"
}
# atuin binds ^r in viins but not vicmd; television had both, so match it.
bindkey -M vicmd '^R' atuin-search

# fzf keeps no keybindings of its own. It is still load-bearing -- fzf-tab is
# the completion menu, and ~/bin/obsidian_* and ~/bin/fzf_select_file shell out
# to it -- but `fzf --zsh` binds ^T, ^R and \ec and rebinds Tab, which would
# collide with television, atuin and fzf-tab respectively. Deliberately not
# sourced.
