function edit_file_command_fzf -d "Select and open file using default editor"
  set file $(
  FZF_DEFAULT_COMMAND='fd --hidden --type=f --color=always --exclude=".git"' fzf --ansi --query="$1" --no-multi --select-1 --exit-0 \
    --margin=1 --height=~50% --padding=1 --reverse --border \
    --preview 'bat --style=plain --color=always --line-range :500 {}' \
    --bind ctrl-y:preview-up \
    --bind ctrl-e:preview-down \
    --bind ctrl-b:preview-page-up \
    --bind ctrl-f:preview-page-down \
    --bind ctrl-u:preview-half-page-up \
    --bind ctrl-d:preview-half-page-down
  )

  if test -n "$file"
    echo $EDITOR $file
  else
    echo $EDITOR
  end
end
