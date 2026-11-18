# auto_cd, auto_pushd and pushd_ignore_dups come from OMZL::directories.zsh.
setopt pushd_silent
setopt interactive_comments
setopt extended_glob

# /etc/zshrc turns BEEP on; flow_control is what swallows ctrl-s before zsh sees it.
unsetopt beep
unsetopt flow_control