# Read by EVERY zsh: scripts, `zsh -c`, login shells, interactive shells.
# fish is the user shell; zsh only runs scripts and wraps GUI-launched programs,
# so PATH is the only thing this setup needs from zsh.
#
# Why this exists: macOS GUI apps inherit launchd's PATH
# (/usr/bin:/bin:/usr/sbin:/sbin), not a shell's. A terminal that execs a program
# directly hands that stunted PATH straight to it — which is how herdr ended up
# unable to find claude under kitty. Routing through zsh gets this file run.
#
# Keep it fast: this runs on every script invocation. Builtins only, no forks.

typeset -U path PATH   # dedupe, keeping the leftmost entry

zsh_set_path() {
  # Hardcoded rather than `eval "$(brew shellenv)"`, which costs ~12ms: it forks
  # brew (a bash script), which in turn forks env and path_helper, all to set
  # four static strings. The loop keeps this portable to Intel at no runtime cost.
  local prefix
  for prefix in /opt/homebrew /usr/local; do
    if [[ -x $prefix/bin/brew ]]; then
      export HOMEBREW_PREFIX=$prefix
      export HOMEBREW_CELLAR=$prefix/Cellar
      export HOMEBREW_REPOSITORY=$prefix
      path=($prefix/bin $prefix/sbin $path)
      break
    fi
  done

  # mise shims, not `mise activate`: activate costs ~25ms and installs a precmd
  # hook that only pays off in an interactive shell. Shims resolve node, python,
  # go, java and ruby on their own.
  #
  # ~/bin is required, not optional: .config/television/cable/herdr.toml calls
  # herdr-pick by bare name, and that channel runs as a herdr popup on alt+space.
  #
  # Skip directories that don't exist, matching what fish_add_path does in
  # config.fish, so the two shells agree and dead entries stay out of PATH. A
  # directory created later (~/.local/bin from a uv or pipx install, say) starts
  # being picked up on its own. Listed back to front because each one prepends.
  #
  # Not ~/.cargo/bin: it holds only rustup toolchain binaries that the mise
  # shims already resolve, and putting it here would shadow the pinned rust.
  local dir
  for dir in \
    $HOME/bin \
    $HOME/.local/bin \
    $HOME/.local/share/mise/bin \
    $HOME/.local/share/mise/shims
  do
    [[ -d $dir ]] && path=($dir $path)
  done
}

zsh_set_path