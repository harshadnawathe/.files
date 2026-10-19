# Login shells only. ~/.zshenv already ran, but /etc/zprofile's path_helper has
# since rebuilt PATH with /etc/paths first, pushing everything we set behind
# /usr/bin -- which is how a login shell ends up with /usr/bin/ruby and the
# /usr/bin/java stub. Just redo it, now that nothing else will reorder us.

(( $+functions[zsh_set_path] )) && zsh_set_path
(( $+functions[zsh_activate_mise] )) && zsh_activate_mise
