# Shell options, and the environment variables that are not a tool's own
# activation (those live in 40-tools.zsh).

# `#` at the prompt is a comment, as it is in fish. Off by default in zsh.
setopt interactive_comments

# /etc/zshrc:28 turns BEEP on explicitly. fish never beeps on an ambiguous
# completion and neither should this.
unsetopt beep

# cd pushes, so `cd -<tab>` offers the stack. pushd_ignore_dups keeps it from
# filling with one repeated directory, pushd_silent stops every cd printing it.
setopt auto_pushd pushd_ignore_dups pushd_silent

# extended_glob is the one option here that is not fish parity -- it is what
# makes `^`, `~` and `#` operators in patterns (`ls ^*.bak`, `print *.c~foo.c`).
# Worth knowing it changes those three characters in *unquoted glob position*,
# so a literal `^` or `#` in a filename argument now needs quoting.
setopt extended_glob

# Lifted out of fish's universal variable store, where nothing but fish could
# read it -- this is why fzf is unthemed in every zsh on the machine today.
# TokyoNight Night, matching bat, delta, television and the Ghostty theme.
export FZF_DEFAULT_OPTS="\
--highlight-line \
--info=inline-right \
--ansi \
--layout=reverse \
--border=none \
--color=bg+:#283457 \
--color=border:#27a1b9 \
--color=fg:#c0caf5 \
--color=gutter:#16161e \
--color=header:#ff9e64 \
--color=hl+:#2ac3de \
--color=hl:#2ac3de \
--color=info:#545c7e \
--color=marker:#ff007c \
--color=pointer:#ff007c \
--color=prompt:#2ac3de \
--color=query:#c0caf5:regular \
--color=scrollbar:#27a1b9 \
--color=separator:#ff9e64 \
--color=spinner:#ff007c"
