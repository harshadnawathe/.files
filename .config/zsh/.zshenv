# A shim, not the real .zshenv -- that one is at ~/.zshenv.
#
# zsh picks its startup directory before it runs anything: if ZDOTDIR is
# already set in the *environment* it reads $ZDOTDIR/.zshenv and never looks at
# ~/.zshenv. ~/.zshenv deliberately does not export ZDOTDIR, so that normally
# cannot happen -- but it only takes one process in the chain exporting it for
# every zsh below to start with no PATH, no mise and no zsh_cached_eval.
#
# That is not hypothetical: shells launched before ZDOTDIR stopped being
# exported still carry it, and so does anything they spawn. This file makes
# both paths lead to the same place.
#
# No risk of double-sourcing: when ZDOTDIR is unset zsh reads ~/.zshenv
# directly and never opens this file.

[[ -r ${HOME}/.zshenv ]] && source ${HOME}/.zshenv
