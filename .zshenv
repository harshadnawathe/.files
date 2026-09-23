# Read by EVERY zsh: scripts, `zsh -c`, login shells. fish is the user shell;
# zsh runs scripts and wraps GUI-launched programs, which inherit launchd's
# stunted PATH (/usr/bin:/bin:/usr/sbin:/sbin) rather than a shell's. Ghostty
# routes through `/bin/zsh -l -c` (.config/ghostty/config.ghostty) to get this.

typeset -U path PATH fpath FPATH   # dedupe, keeping the leftmost entry

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
  local dir
  for dir in $HOME/bin $HOME/.local/bin; do
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
