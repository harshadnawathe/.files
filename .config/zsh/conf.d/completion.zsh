# fzf-tab builds its groups from completion descriptions; with no format set
# there are no groups, and switch-group's < > have nothing to cycle.
zstyle ':completion:*:descriptions' format '[%d]'

# Case-insensitive first, then complete from a partial word, then from a substring.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

# Caches the slower generators; carapace shells out per command.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache
