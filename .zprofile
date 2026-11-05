# /etc/zprofile's path_helper has rebuilt PATH since .zshenv ran, pushing the
# shims behind /usr/bin -- which is how a login shell gets /usr/bin/java.
(( $+functions[zsh_set_path] )) && zsh_set_path
