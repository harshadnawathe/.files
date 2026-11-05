# Ported from fish's fzf-options.fish; only the variable names differ.
# --tmux stays out of FZF_DEFAULT_OPTS: obsidian_notes already runs in a popup.

() {
  local search_command='fd --hidden --color=always'

  local file_prompt='󰱽 󰁕 '
  local file_header='(ctrl-w: Search files by text)'
  local file_label='[ Search files by name ]'

  local text_prompt='󱎸 󰁕 '
  local text_filter_prompt='󱎸  '
  local text_header='(ctrl-f: Search files by name)   (alt-w: Toggle filter)'
  local text_label='[ Search files by text ]'
  local text_command="rg --hidden -g '!.git/' --column --line-number --no-heading --color=always --smart-case "

  local filter_off="rebind(change)+change-prompt($text_prompt)+disable-search+transform-query:echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r"
  local filter_on="unbind(change)+change-prompt($text_filter_prompt)+enable-search+transform-query:echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"

  # One element per argument, so the nested quoting in --bind stays readable.
  local -a opts=(
    --ansi
    --delimiter=:
    --margin=1 --min-height=40 --height=~50% --padding=1 --reverse --border
    --prompt="$file_prompt"
    --header="$file_header"
    --border-label="$file_label"
    --preview='bat --style=plain --color=always {1}'
    --preview-window=right,hidden
    "--bind=ctrl-f:unbind(ctrl-f,change,alt-w)+change-prompt($file_prompt)+change-header($file_header)+change-border-label($file_label)+enable-search+reload($search_command)+transform-query(echo {q})+change-preview(bat --style=plain --color=always {1})+change-preview-window(right)+hide-preview+rebind(ctrl-w)"
    "--bind=ctrl-w:unbind(ctrl-w)+change-prompt($text_prompt)+change-header($text_header)+change-border-label($text_label)+disable-search+reload($text_command {q})+change-preview(bat --style=plain --color=always {1} --highlight-line {2})+change-preview-window(right,50%,+{2}+3/3,~3)+rebind(ctrl-f,change,alt-w)"
    "--bind=change:reload(sleep 0.1; $text_command {q} || true)"
    "--bind=alt-w:transform:sh -c 'if [ \"\$FZF_PROMPT\" != \"$text_prompt\" ]; then echo \"$filter_off\"; else echo \"$filter_on\"; fi'"
    --bind=ctrl-y:preview-up
    --bind=ctrl-e:preview-down
    --bind=ctrl-u:preview-page-up
    --bind=ctrl-d:preview-page-down
    --bind=alt-p:toggle-preview
    '--bind=focus:transform-preview-label:echo [ {1} ]'
    --bind='start:unbind(change,ctrl-f,alt-w)'
    # {+1} not {1}: the widget force-appends -m, so multi-select must emit all.
    '--bind=enter:become(printf "%s\n" {+1})'
  )

  # Ctrl-F rather than fzf's default Ctrl-T, matching _fzf_search_directory in fish.
  bindkey '^F' fzf-file-widget
  bindkey -M viins '^F' fzf-file-widget

  export FZF_CTRL_T_COMMAND=$search_command
  # The @ matters: without it the join happens first and every space is escaped.
  export FZF_CTRL_T_OPTS="${(j: :)${(q@)opts}}"
}
