# The rest of the aliases land here in step 4. This one belongs to the
# environment-parity pass: fish rendered `ls` through lsd via the
# __fish_ls_command universal variable rather than an alias, so there is
# nothing in the fish config to port -- only the behaviour.
#
# Interactive-only in both shells: fish's variable was read by its own `ls`
# wrapper, and a zsh alias is not expanded in scripts.
alias ls=lsd
