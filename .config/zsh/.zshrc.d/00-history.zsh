# Out of $ZDOTDIR on purpose: Apple's /etc/zshrc:16 defaults HISTFILE to
# ${ZDOTDIR:-$HOME}/.zsh_history, which now resolves inside the dotfiles repo.
# zsh does not create the directory -- without the mkdir it simply never saves.
#
# NOT exported. It was, so that television's zsh-history channel could read it
# from a child -- but every child saw it, including bash, which writes bare
# lines with no `: <epoch>:<elapsed>;` prefix straight into this file and
# corrupts the format the three consumers below depend on. The channel reads
# $XDG_STATE_HOME directly instead, which is exported anyway.
HISTFILE=$XDG_STATE_HOME/zsh/history
mkdir -p ${HISTFILE:h}

# /etc/zshrc sets 2000/1000. Fish keeps everything by default and that is the
# behaviour being matched; atuin (step 6) imports from this file, so anything
# dropped here is dropped from atuin too.
HISTSIZE=100000
SAVEHIST=100000

# extended_history writes `: <epoch>:<elapsed>;<cmd>`. Required three times
# over: atuin's importer reads the timestamps, television's zsh-history channel
# splits on the `;`, and the fish history import below is written in that form.
setopt extended_history

# share_history is what makes two tmux panes behave like two fish windows --
# each one sees what the other just ran. It implies inc_append_history.
setopt share_history

# hist_ignore_dups only collapses *consecutive* repeats, which is deliberate:
# hist_ignore_all_dups would reorder history, and atuin does the real
# deduplication once it owns Ctrl-R.
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# Expand `!!` onto the line for inspection instead of running it straight away.
# This is what replaces fish's `!!` abbreviation, which expanded visibly before
# you pressed enter.
setopt hist_verify
