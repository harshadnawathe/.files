#!/usr/bin/env bash
# Pane-scoped git segment for status-right.
# Prints nothing outside a repo, so the segment costs zero columns there.
# Usage: git-status.sh <path>

# Pull the @sb_* palette in one tmux call rather than one per colour, so
# these scripts and theme.conf share a single source of truth. Defaults
# keep the pill readable if the palette block ever goes missing.
eval "$(tmux show -g 2>/dev/null | sed -n 's/^@sb_\([a-z]*\) \(.*\)$/SB_\1=\2/p')"
: "${SB_dark:=colour0}"  ; : "${SB_body:=colour0}" ; : "${SB_git:=colour5}"
: "${SB_text:=colour15}"

# Guard the empty case explicitly: `cd ""` succeeds in bash and leaves us
# in whatever directory the tmux job inherited, which would report some
# unrelated repo's branch as if it were this pane's.
[ -n "$1" ] || exit 0
cd "$1" 2>/dev/null || exit 0

branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) \
  || branch=$(git rev-parse --short HEAD 2>/dev/null) \
  || exit 0

# '*' = tracked changes in the worktree or index
git diff --quiet --ignore-submodules HEAD 2>/dev/null || dirty="*"

# 'N' = commits on HEAD not yet on its upstream (no upstream: silent)
ahead=$(git rev-list --count '@{u}..HEAD' 2>/dev/null) \
  && [ "$ahead" -gt 0 ] 2>/dev/null \
  && unpushed="$ahead"

printf '#[fg=%s,bg=%s] 󰘬 #[default,bg=%s,fg=%s] %s%s%s #[default] ' \
  "$SB_dark" "$SB_git" "$SB_body" "$SB_text" "$branch" "$dirty" "$unpushed"
