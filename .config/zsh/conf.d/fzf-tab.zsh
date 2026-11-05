# Previews. carapace supplies the candidates for almost every command, and its
# words carry a trailing space, so strip it before any file test or git lookup.

# carapace owns git, so every subcommand lands here rather than in git-checkout.
# No -- before $p: that would make git read it as a path, not a ref.
zstyle ':fzf-tab:complete:git:*' fzf-preview \
  'setopt extended_glob
   p=${${realpath:-$word}%%[[:space:]]##}
   if git rev-parse --verify --quiet $p >/dev/null 2>&1; then
     git log --color=always --oneline --decorate -20 $p
   elif [[ -f $p ]]; then
     bat --style=plain --color=always --line-range=:200 -- $p
   else
     print -r -- $p
   fi'

zstyle ':fzf-tab:complete:*:*' fzf-preview \
  'setopt extended_glob
   p=${${realpath:-$word}%%[[:space:]]##}
   if [[ -d $p ]]; then
     eza -1 --color=always --icons=always -- $p
   elif [[ -f $p ]]; then
     bat --style=plain --color=always --line-range=:200 -- $p
   else
     print -r -- $p
   fi'
