#!/usr/bin/env bash
# Pane-scoped git segment for status-right.
# Prints nothing outside a repo, so the segment costs zero columns there.
# Usage: git-status.sh <path>

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

printf '#[fg=colour232,bg=colour5]  #[default,bg=colour235] %s%s%s #[default] ' \
  "$branch" "$dirty" "$unpushed"
