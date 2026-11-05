# /etc/zprofile's path_helper rebuilds the path hence set the path again
(( $+functions[zsh_set_path] )) && zsh_set_path
