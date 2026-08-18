# Login shells only. The PATH itself is built in ~/.zshenv.
#
# /etc/zprofile runs path_helper *after* ~/.zshenv, rebuilding PATH with
# /etc/paths first and appending ours after — which pushes the mise shims behind
# /usr/bin, letting /usr/bin/ruby and the java stub win. Re-assert to undo that.

(( $+functions[zsh_set_path] )) && zsh_set_path