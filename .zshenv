#
# Variables
#

export EDITOR=nvim
export HOMEBREW_BREWFILE_ON_REQUEST=1
export ZPFX=${ZPFX:-${XDG_DATA_HOME:-$HOME/.local/share}/zinit/polaris}
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

# Caches `brew shellenv`. 
# Its output is prefix-derived, so only brew moving or upgrading can change it.
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

zsh_set_path() {
  zsh_brew_env set

  # local binary paths.
  # $ZPFX/bin is listed here rather than left to zinit: zinit prepends it only
  # when absent, so an inherited PATH leaves it stranded behind brew.
  local dir
  local -a dirs
  for dir in \
    $HOME/bin \
    $HOME/go/bin \
    $HOME/.local/bin \
    $ZPFX/bin \
    "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
  do
    [[ -d $dir ]] && dirs+=($dir)
  done

  # add mise shims for non-interactive
  if [[ ! -o interactive ]]; then
    local shims=$HOME/.local/share/mise/shims
    [[ -d $shims ]] && dirs=($shims $dirs)
  fi

  path=($dirs $path)
}

#
# Settings
#

# Avoid duplicate entries in PATH
typeset -U path PATH fpath FPATH

zsh_set_path
