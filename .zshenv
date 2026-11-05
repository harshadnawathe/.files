# No $ZDOTDIR: stow folds a whole directory into one symlink, so state zsh wrote
# into ~/.config/zsh landed in the repo. Linked file by file, it stays in $HOME.

#
# Variables
#

export EDITOR=nvim

# Here rather than .zshrc because non-interactive shells never read that; zinit
# honours an already-set ZPFX.
export ZPFX=${ZPFX:-${XDG_DATA_HOME:-$HOME/.local/share}/zinit/polaris}

# TokyoNight Night. Here because most fzf calls come from non-interactive shells.
# No --tmux flag: obsidian_notes already runs inside a display-popup.
export FZF_DEFAULT_OPTS="
  --highlight-line
  --info=inline-right
  --ansi
  --layout=reverse
  --border=none
  --color=bg+:#283457
  --color=border:#27a1b9
  --color=fg:#c0caf5
  --color=gutter:#16161e
  --color=header:#ff9e64
  --color=hl:#2ac3de
  --color=hl+:#2ac3de
  --color=info:#545c7e
  --color=marker:#ff007c
  --color=pointer:#ff007c
  --color=prompt:#2ac3de
  --color=query:#c0caf5:regular
  --color=scrollbar:#27a1b9
  --color=separator:#ff9e64
  --color=spinner:#ff007c
"

#
# Functions
#

# Caches `brew shellenv`, which costs 26ms per shell to run live. Its output is
# prefix-derived, so only brew moving or upgrading can change it.
#
#   set      source the cache, creating it first if absent
#   update   regenerate it
zsh_brew_env() {
  local cache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/brewenv.zsh

  case $1 in
    set)
      [[ -s $cache ]] || zsh_brew_env update
      [[ -r $cache ]] && source $cache
      ;;

    update)
      # Absolute path: `brew` is a function once conf.d has run, and the prefix
      # may not be on $PATH yet on a first run.
      local brew out
      for brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        [[ -x $brew ]] || continue
        # Never leave an empty file: `set` sources it unchecked, so a truncated
        # cache would quietly drop brew's environment everywhere.
        out=$($brew shellenv zsh) && [[ -n $out ]] || return
        command mkdir -p ${cache:h}
        print -r -- "$out" > $cache
        return
      done
      ;;

    *)
      print -ru2 -- "zsh_brew_env: expected 'set' or 'update', got '${1:-}'"
      return 2
      ;;
  esac
}

# Mirrors config.fish's PATH setup. Missing directories are skipped, so one
# created later is picked up on its own. .zprofile calls this again.
zsh_set_path() {
  # Here, not conf.d, so a non-interactive shell can create the cache too.
  zsh_brew_env set

  local dir
  local -a dirs
  for dir in \
    $HOME/bin \
    $HOME/go/bin \
    $HOME/.local/bin \
    "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
  do
    [[ -d $dir ]] && dirs+=($dir)
  done

  # .zshrc provides both for interactive shells: zinit prepends $ZPFX/bin, and
  # `mise activate` supersedes the shims. Shims go first, as in config.fish.
  if [[ ! -o interactive ]]; then
    local shims=$HOME/.local/share/mise/shims
    [[ -d $ZPFX/bin ]] && dirs+=($ZPFX/bin)
    [[ -d $shims ]] && dirs=($shims $dirs)
  fi

  path=($dirs $path)
}

#
# Settings
#

# Before zsh_set_path: it prepends to $path and relies on duplicates being
# dropped, which is what makes .zprofile's second call idempotent.
typeset -U path PATH fpath FPATH

zsh_set_path
