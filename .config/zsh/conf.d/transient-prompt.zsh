# Collapse the prompt to a bare glyph on accept, so scrollback holds commands
# and output rather than a repeated line 1 and the spaces $fill pads it with.

zmodload -i zsh/parameter
autoload -Uz add-zsh-hook

# Starship sets RPROMPT even with no right_format: a second starship process
# (~18ms) per prompt to render nothing. Drop this if right_format is ever set.
RPROMPT=''

# starship assigns PROMPT/RPROMPT once at init, not per-precmd, so nothing
# restores them after the widget rewrites them.
typeset -g _TP_FULL=$PROMPT _TP_FULL_R=$RPROMPT
typeset -g _TP_SHORT='%F{8}❯%f '

_tp_restore() { PROMPT=$_TP_FULL RPROMPT=$_TP_FULL_R }
add-zsh-hook precmd _tp_restore

# zsh-autosuggestions already wraps accept-line: chain to it, do not replace.
if (( ! ${+_TP_NEXT} )); then
  if [[ ${widgets[accept-line]} == user:* ]]; then
    zle -A accept-line _tp_wrapped_accept_line
    typeset -g _TP_NEXT=_tp_wrapped_accept_line
  else
    typeset -g _TP_NEXT=.accept-line
  fi
fi

_tp_accept_line() {
  PROMPT=$_TP_SHORT RPROMPT=''
  zle .reset-prompt
  zle $_TP_NEXT
}
zle -N accept-line _tp_accept_line