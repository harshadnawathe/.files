status is-interactive; or exit 0

set -l SEARCH_COMMAND "fd --hidden --color=always"

# --- UI Constants ---
set -l SEARCH_FILE_PROMPT "󰱽 󰁕 "
set -l SEARCH_FILE_BORDER_LABEL "[ Search files by name ]"
set -l SEARCH_FILE_HEADER "(ctrl-w: Search files by text)"

set -l SEARCH_TEXT_PROMPT "󱎸 󰁕 "
set -l SEARCH_TEXT_FILTER_PROMPT "󱎸  "
set -l SEARCH_TEXT_HEADER "(ctrl-f: Search files by name)   (alt-w: Toggle filter)"
set -l SEARCH_TEXT_BORDER_LABEL "[ Search files by text ]"
set -l SEARCH_TEXT_COMMAND_PREFIX "rg --hidden -g '!.git/' --column --line-number --no-heading --color=always --smart-case "

# --- Logic Blocks (The Toggle Actions) ---
set -l TURN_FILTER_OFF "rebind(change)+change-prompt($SEARCH_TEXT_PROMPT)+disable-search+transform-query:echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r"
set -l TURN_FILTER_ON "unbind(change)+change-prompt($SEARCH_TEXT_FILTER_PROMPT)+enable-search+transform-query:echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"

# --- The "Master List" of Options ---
# By using a list, we avoid the quoting nightmare entirely.
set -l opts \
    --ansi \
    --no-multi \
    --delimiter=":" \
    --margin=1 --min-height=40 --height=~50% --padding=1 --reverse --border \
    --prompt "$SEARCH_FILE_PROMPT" \
    --header "$SEARCH_FILE_HEADER" \
    --border-label "$SEARCH_FILE_BORDER_LABEL" \
    --preview 'bat --style=plain --color=always {1}' \
    --preview-window 'right,hidden' \
    --bind "ctrl-f:unbind(ctrl-f,change,alt-w)+change-prompt($SEARCH_FILE_PROMPT)+change-header($SEARCH_FILE_HEADER)+change-border-label($SEARCH_FILE_BORDER_LABEL)+enable-search+reload($SEARCH_COMMAND)+transform-query(echo {q})+change-preview(bat --style=plain --color=always {1})+change-preview-window(right)+hide-preview+rebind(ctrl-w)" \
    --bind "ctrl-w:unbind(ctrl-w)+change-prompt($SEARCH_TEXT_PROMPT)+change-header($SEARCH_TEXT_HEADER)+change-border-label($SEARCH_TEXT_BORDER_LABEL)+disable-search+reload($SEARCH_TEXT_COMMAND_PREFIX {q})+change-preview(bat --style=plain --color=always {1} --highlight-line {2})+change-preview-window(right,50%,+{2}+3/3,~3)+rebind(ctrl-f,change,alt-w)" \
    --bind "change:reload(sleep 0.1; $SEARCH_TEXT_COMMAND_PREFIX {q} || true)" \
    --bind "alt-w:transform:sh -c 'if [ \"\$FZF_PROMPT\" != \"$SEARCH_TEXT_PROMPT\" ]; then echo \"$TURN_FILTER_OFF\"; else echo \"$TURN_FILTER_ON\"; fi'" \
    --bind "ctrl-y:preview-up" \
    --bind "ctrl-e:preview-down" \
    --bind "ctrl-u:preview-page-up" \
    --bind "ctrl-d:preview-page-down" \
    --bind "alt-p:toggle-preview" \
    --bind 'focus:transform-preview-label:echo [ {1} ]' \
    --bind "start:unbind(change,ctrl-f,alt-w)" \
    --bind "enter:become(sh -c 'echo {1}')"

# --- fzf.fish configuration ---

set -gx fzf_directory_opts $opts
set -gx fzf_fd_opts --hidden

