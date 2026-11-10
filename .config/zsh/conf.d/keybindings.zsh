# Overrides OMZP::vi-mode, which loads earlier. vi mode is already on before
# `bindkey -v`: zsh picks it whenever $EDITOR matches *vi*, and that is nvim.

bindkey -v
KEYTIMEOUT=1

# Drop / and . so ^W deletes one path segment rather than the whole path.
WORDCHARS=${WORDCHARS//[\/.]}

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M viins '\ee' edit-command-line
bindkey -M vicmd '\ee' edit-command-line
bindkey -M viins '\ev' edit-command-line
bindkey -M vicmd '\ev' edit-command-line

# insert-last-word is an emacs-keymap default; `bindkey -v` leaves ^[. unbound,
# so Alt-. fell through to vi-cmd-mode + vi-repeat-change.
bindkey -M viins '\e.' insert-last-word
bindkey -M vicmd '\e.' insert-last-word

# Expand !! and !$ as you type the space, rather than only on Enter.
bindkey -M viins ' ' magic-space
bindkey -M emacs ' ' magic-space

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M viins '^P' up-line-or-beginning-search
bindkey -M viins '^N' down-line-or-beginning-search

# Freed for the fzf git-status picker; OMZ's binding here duplicates atuin.
bindkey -M viins -r '^S'
bindkey -M emacs -r '^S'
