# Read by EVERY zsh: scripts, `zsh -c`, login shells, and -- since the cutover
# -- the interactive one too. It still has to do the PATH work on its own,
# because GUI-launched programs inherit launchd's stunted PATH
# (/usr/bin:/bin:/usr/sbin:/sbin) rather than a shell's, and Ghostty routes
# through `/bin/zsh -l -c` (.config/ghostty/config.ghostty) to get this.
#
# Keep this file free of anything interactive: it is read by every `zsh -c` on
# the machine. Interactive setup lives in $ZDOTDIR/.zshrc.

typeset -U path PATH fpath FPATH   # dedupe, keeping the leftmost entry

# Setting ZDOTDIR moves every OTHER startup file: zsh reads $ZDOTDIR/.zprofile,
# .zshrc and .zlogin, and stops looking in $HOME for them. That is why
# .zprofile sits in .config/zsh/ rather than beside this file. This one has to
# stay at ~/.zshenv -- it is the only file read before ZDOTDIR exists.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# NOT exported, and that is the whole point. zsh resolves its startup files
# from $ZDOTDIR/.zshenv *first*, falling back to ~/.zshenv only when ZDOTDIR is
# unset in the environment. Export it and every nested zsh -- `zsh` from a zsh,
# nvim's `:!`, and after the cutover every tmux pane, since tmux inherits the
# environment of the `zsh -l -c` that started it -- looks for a
# .config/zsh/.zshenv that does not exist, skips this file, and comes up with
# no PATH, no mise and no zsh_cached_eval. The shell variable is all zsh needs
# to find .zprofile and .zshrc below.
ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Here rather than in .zshrc: git, mise and nvim's `:!` are all non-interactive
# and would never read an interactive-only file. It lived in fish's universal
# variable store, which nothing outside fish can see.
export EDITOR=nvim

# Apple's per-session history, off. It has to be set here rather than in
# .zshrc because /etc/zshrc runs first, and under Terminal.app it does three
# things that together defeat .zshrc.d/00-history.zsh:
#
#   /etc/zshrc:16                 HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
#   /etc/zshrc_Apple_Terminal:146 captures that as the "shared" history file
#   /etc/zshrc_Apple_Terminal:150 repoints HISTFILE at a per-session file,
#                                 re-applied from a precmd hook (:178)
#   /etc/zshrc_Apple_Terminal:196 appends the session back to the shared file
#
# With ZDOTDIR pointing into this repo, "shared" is .config/zsh/.zsh_history --
# so history both lands in git and stops honouring $HISTFILE. The opt-out is
# Apple's own, documented at /etc/zshrc_Apple_Terminal:94.
export SHELL_SESSIONS_DISABLE=1

# Source $3's output, cached under ~/.cache/zsh and regenerated whenever $2 --
# the binary that generates it -- is newer. `-nt` is a builtin, so the steady
# state costs one source and no fork. Empty or failed output is never cached.
zsh_cached_eval() {
  local cache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/activation_scripts/$1.zsh
  if [[ -s $cache && $cache -nt $2 ]]; then
    source $cache
    return
  fi
  local out
  out=$(eval "$3") && [[ -n $out ]] || return
  mkdir -p ${cache:h}
  print -r -- "$out" > $cache
  eval "$out"
}

zsh_set_path() {
  local brew
  for brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x $brew ]]; then
      zsh_cached_eval brew_shellenv $brew "$brew shellenv zsh"
      break
    fi
  done

  # ~/bin holds the obsidian_* scripts invoked by bare name from fish abbrevs
  # and nvim's `:!obsidian_ok`. Skipping missing dirs matches config.fish, so one
  # created later is picked up on its own. Not ~/.cargo/bin: mise already
  # resolves those, and it would shadow the pinned rust.
  #
  # Listed back to front, because each iteration prepends: the resulting PATH
  # order is ~/bin, ~/go/bin, ~/.local/bin, Toolbox -- the order config.fish:21
  # passes to `fish_add_path -gm`. The Toolbox path is quoted there and so never
  # expands its tilde; fish has never actually had it.
  local dir
  for dir in \
    "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" \
    $HOME/.local/bin \
    $HOME/go/bin \
    $HOME/bin
  do
    [[ -d $dir ]] && path=($dir $path)
  done
}

# Full activation, not shims: shims resolve binaries but export nothing, so
# `_.python.venv` and mise.toml `[env]` keys would silently never apply. nvim's
# `:!`, Claude Code's shell and the television $SHELL channels all land here.
#
# The sed drops mise's preamble, which -- unlike `brew shellenv` -- is a literal
# snapshot of PATH at generation time and so must not be cached.
zsh_activate_mise() {
  local bin=${HOMEBREW_PREFIX:-/opt/homebrew}/bin/mise
  [[ -x $bin ]] || return
  zsh_cached_eval mise_activate $bin \
    "$bin activate zsh | sed -n '/^export MISE_SHELL=zsh\$/,\$p'"
}

zsh_set_path
zsh_activate_mise
