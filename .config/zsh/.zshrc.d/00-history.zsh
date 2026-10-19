# Out of $ZDOTDIR on purpose: Apple's /etc/zshrc:16 defaults HISTFILE to
# ${ZDOTDIR:-$HOME}/.zsh_history, which now resolves inside the dotfiles repo.
# zsh does not create the directory -- without the mkdir it simply never saves.
export HISTFILE=$XDG_STATE_HOME/zsh/history
mkdir -p ${HISTFILE:h}

# Exported rather than plain, because .config/television/cable/zsh-history.toml
# reads $HISTFILE from a child process and would otherwise silently fall back to
# the stale ~/.zsh_history.
