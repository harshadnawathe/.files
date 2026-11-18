# OMZL::history.zsh (loaded earlier) covers the common options; this adds the rest.
# /etc/zshrc sets SAVEHIST=1000 and OMZL only raises it to 10000.

SAVEHIST=50000

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_find_no_dups
setopt hist_save_no_dups
