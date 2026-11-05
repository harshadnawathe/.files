# Overrides /etc/zshrc, which sets HISTSIZE=2000 and SAVEHIST=1000 before this runs.

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt extended_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_find_no_dups
setopt hist_save_no_dups