#!/usr/bin/env bash
# Pane-scoped git segment for status-right.
# Prints nothing outside a repo, so the segment costs zero columns there.
# Usage: git-status.sh <path>
#
# Cap colour describes BRANCH HEALTH only; the working tree never colours
# it. Editing files is the job, not a problem, and a cap that is always
# lit stops being a signal -- the counts in the body carry that detail.
#
#   red     stop and deal with it   merge conflict, detached HEAD
#   yellow  the remote has commits you do not   behind, diverged
#   magenta everything else   in sync, ahead, no upstream, any amount dirty
#
# 'ahead' is deliberately magenta: a push is always a fast-forward, there
# is nothing to reconcile, and unpushed commits are strictly safer than
# the uncommitted changes we already leave uncoloured.

# Pull the @sb_* palette in one tmux call rather than one per colour, so
# these scripts and theme.conf share a single source of truth. Defaults
# keep the pill readable if the palette block ever goes missing.
# [a-z_]* not [a-z]*: the latter silently drops underscored option names.
eval "$(tmux show -g 2>/dev/null | sed -n 's/^@sb_\([a-z_]*\) \(.*\)$/SB_\1=\2/p')"
: "${SB_dark:=colour0}"  ; : "${SB_body:=colour0}" ; : "${SB_git:=colour5}"
: "${SB_text:=colour15}" ; : "${SB_alert:=colour1}"; : "${SB_ok:=colour2}"
: "${SB_busy:=colour3}"  ; : "${SB_mute:=colour8}"

# Guard the empty case explicitly: `cd ""` succeeds in bash and leaves us
# in whatever directory the tmux job inherited, which would report some
# unrelated repo's branch as if it were this pane's.
[ -n "$1" ] || exit 0
cd "$1" 2>/dev/null || exit 0

detached=0
branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || {
  branch=$(git rev-parse --short HEAD 2>/dev/null) || exit 0
  detached=1
}

# One porcelain pass for every working-tree count. Conflict codes are
# DD AU UD UA DU AA UU -- a U on either side, plus the two doubled ones.
read -r staged unstaged untracked conflicts <<<"$(
  git status --porcelain=v1 --untracked-files=normal 2>/dev/null | awk '
    { x=substr($0,1,1); y=substr($0,2,1) }
    x=="?" && y=="?"                                      { u++; next }
    x=="U" || y=="U" || (x=="A"&&y=="A") || (x=="D"&&y=="D") { c++; next }
    { if (x!=" ") s++; if (y!=" ") m++ }
    END { printf "%d %d %d %d", s+0, m+0, u+0, c+0 }')"

# One call for both directions; fails when the branch has no upstream.
upstream=1
read -r behind ahead <<<"$(git rev-list --count --left-right '@{u}...HEAD' 2>/dev/null)" || upstream=0
[ -n "$ahead" ] || { upstream=0; ahead=0; behind=0; }

if   [ "$conflicts" -gt 0 ] || [ "$detached" -eq 1 ]; then cap=$SB_alert
elif [ "$behind"    -gt 0 ];                          then cap=$SB_busy
else                                                       cap=$SB_git
fi

BODY="#[default,bg=$SB_body,fg=$SB_text]"
seg="$branch"
add() { [ "$1" -gt 0 ] && seg="$seg #[fg=$2]$3$1$BODY"; }
add "$conflicts" "$SB_alert" '!'
add "$staged"    "$SB_ok"    '+'
add "$unstaged"  "$SB_busy"  '~'
add "$untracked" "$SB_mute"  '?'
add "$ahead"     "$SB_mute"  "↑"
add "$behind"    "$SB_busy"  "↓"
[ "$upstream" -eq 0 ] && [ "$detached" -eq 0 ] && seg="$seg #[fg=$SB_mute]⇡?$BODY"

printf '#[fg=%s,bg=%s] 󰘬 %s %s #[default] ' "$SB_dark" "$cap" "$BODY" "$seg"
