status is-interactive; or exit 0

set -x FZF_CTRL_T_COMMAND "fd --hidden --type=f --color=always"

set -lx SEARCH_FILE_PROMPT "󰱽 󰁕 "
set -lx SEARCH_FILE_BORDER_LABEL "[ Search files by name ]"
set -lx SEARCH_FILE_HEADER "(ctrl-w: Search files by text)"

set -lx SEARCH_BY_NAME_BIND "ctrl-f:\
unbind(ctrl-f,change,alt-w)\
+change-prompt($SEARCH_FILE_PROMPT)\
+change-header($SEARCH_FILE_HEADER)\
+change-border-label($SEARCH_FILE_BORDER_LABEL)\
+enable-search\
+reload($FZF_CTRL_T_COMMAND)\
+transform-query(echo {q})\
+change-preview(bat --style=plain --color=always {1})\
+change-preview-window(right)\
+hide-preview\
+rebind(ctrl-w)\
"

set -lx SEARCH_TEXT_PROMPT "󱎸 󰁕 "
set -lx SEARCH_TEXT_COMMAND_PREFIX "rg --hidden -g '!.git/' --column --line-number --no-heading --color=always --smart-case "
set -lx SEARCH_TEXT_HEADER "(ctrl-f: Search files by name)   (alt-w: Toggle filter)"
set -lx SEARCH_TEXT_BORDER_LABEL "[ Search files by text ]"

set -lx SEARCH_TEXT_FILTER_PROMPT "󱎸  "

set -lx SERACH_BY_TEXT_BIND "ctrl-w:\
unbind(ctrl-w)\
+change-prompt($SEARCH_TEXT_PROMPT)\
+change-header($SEARCH_TEXT_HEADER)\
+change-border-label($SEARCH_TEXT_BORDER_LABEL)\
+disable-search\
+reload($SEARCH_TEXT_COMMAND_PREFIX {q})\
+change-preview(bat --style=plain --color=always {1} --highlight-line {2})\
+change-preview-window(right,50%,+{2}+3/3,~3)\
+rebind(ctrl-f,change,alt-w)\
"

set -lx SEARCH_BY_TEXT_CHANGE_BIND "change:\
reload(sleep 0.1; $SEARCH_TEXT_COMMAND_PREFIX {q} || true)\
"

set -lx SEARCH_BY_TEST_TURN_FILTER_OFF "rebind(change)\
+change-prompt($SEARCH_TEXT_PROMPT)\
+disable-search\
+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r\
"

set -lx SEARCH_BY_TEST_TURN_FILTER_ON "unbind(change)\
+change-prompt($SEARCH_TEXT_FILTER_PROMPT)\
+enable-search\
+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f\
"

set -lx SEARCH_BY_TEXT_TOGGLE_FILTER_BIND "alt-w:\
transform:sh -c '[[ \\\"\$FZF_PROMPT\\\" != \\\"$SEARCH_TEXT_PROMPT\\\" ]] && \
echo \\\"$SEARCH_BY_TEST_TURN_FILTER_OFF\\\" || \
echo \\\"$SEARCH_BY_TEST_TURN_FILTER_ON\\\"'"

set -x FZF_CTRL_T_OPTS "--ansi \
  --no-multi \
	--delimiter=\":\" \
	--margin=1 --min-height=40 --height=~50% --padding=1 --reverse --border \
	--prompt \"$SEARCH_FILE_PROMPT\" \
	--header=\"$SEARCH_FILE_HEADER\" \
	--border-label \"$SEARCH_FILE_BORDER_LABEL\" \
	--preview 'bat --style=plain --color=always {1}' \
	--preview-window 'right,hidden' \
	--bind \"$SEARCH_BY_NAME_BIND\" \
  --bind \"$SERACH_BY_TEXT_BIND\" \
	--bind \"$SEARCH_BY_TEXT_CHANGE_BIND\" \
	--bind \"$SEARCH_BY_TEXT_TOGGLE_FILTER_BIND\" \
	--bind ctrl-y:preview-up \
	--bind ctrl-e:preview-down \
	--bind ctrl-u:preview-page-up \
	--bind ctrl-d:preview-page-down \
	--bind alt-p:toggle-preview \
	--bind 'focus:transform-preview-label:echo [ {1} ]' \
	--bind \"start:unbind(change,ctrl-f,alt-w)\" \
  --bind \"enter:become(sh -c 'echo {1}')\" \
"

