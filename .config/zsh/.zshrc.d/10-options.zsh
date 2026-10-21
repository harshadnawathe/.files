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

# extended_glob is deliberately NOT set. It makes `^` a pattern operator, and
# with nomatch on (the zsh default) that breaks every caret git revision:
#
#   $ git log HEAD^
#   zsh:1: no matches found: HEAD^
#
# which takes `gd HEAD^`, `git show HEAD^` and `grh HEAD^` with it -- in a
# config whose headline feature is 166 git aliases. The silent case is worse:
# in a directory containing a file whose name starts with HEAD, `HEAD^` expands
# to that filename and git is handed a revision nobody typed.
#
# `setopt no_nomatch` would fix the error but keep the silent misexpansion, so
# it is not the answer either. What extended_glob buys here is `ls ^*.bak`,
# which fd and rg already cover.

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
