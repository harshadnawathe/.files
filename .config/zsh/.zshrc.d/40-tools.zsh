# Tool activations. Every one goes through zsh_cached_eval (~/.zshenv:11-22),
# which sources a cached copy and only regenerates it when the generating
# binary is newer -- the same thing functions/cached_eval.fish did for fish.
#
# Order matters at the bottom of this file: whatever binds a key last wins.

# television owns the interactive pickers. It replaces all three of
# patrickf1/fzf.fish's widgets at once:
#
#   ctrl-f  search directory      -> the files / dirs channels
#   ctrl-s  search git status     -> git-diff, already triggered by `git add`
#   ctrl-v  search variables      -> env, already triggered by `export`
#
# and does it from .config/television/config.toml, which already lists 90
# channels and a [shell_integration.channel_triggers] table -- so `git checkout
# <C-T>` offers branches and `nvim <C-T>` offers repos, which three hardcoded
# keys never did.
#
# The zsh integration is the better one: it ships __tv_path_completion on top
# of the two widgets the fish version defines, and registers `compdef _tv tv`
# itself. ez-compinit queues that until after compinit, so it works despite
# compinit being deferred to the end of .zshrc.
# An absolute path, not a bare `tv`: zsh_cached_eval's second argument is the
# binary whose mtime invalidates the cache, and `[[ $cache -nt tv ]]` is false
# whenever `tv` is not also a file in $PWD -- so a bare name silently disables
# the cache and re-forks `tv init zsh` on every prompt. ~/.zshenv passes
# absolute paths for brew and mise for the same reason.
() {
  local bin=${HOMEBREW_PREFIX:-/opt/homebrew}/bin/tv
  [[ -x $bin ]] || return
  zsh_cached_eval tv_init $bin "$bin init zsh"
}

# tv binds ^T and ^R into the current keymap only, which after `bindkey -v` is
# viins. `tv init fish` loops over `default insert` and binds both, so this is
# the missing half rather than an addition.
bindkey -M vicmd '^T' tv-smart-autocomplete
bindkey -M vicmd '^R' tv-shell-history

# fzf keeps no keybindings of its own. It is still load-bearing -- fzf-tab is
# the completion menu, and ~/bin/obsidian_* and ~/bin/fzf_select_file shell out
# to it -- but `fzf --zsh` binds ^T, ^R and \ec and rebinds Tab, which would
# collide with television, atuin and fzf-tab respectively. Deliberately not
# sourced.
