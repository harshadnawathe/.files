#!/usr/bin/env bash
# Global workmux agent tally for status-right.
# Prints nothing when no agents are tracked, so the segment costs zero
# columns when you aren't running any.

json=$(workmux status --all --json 2>/dev/null) || exit 0

# grep -o | wc -l, not grep -c: counts occurrences, not matching lines,
# so it holds whether or not the JSON is pretty-printed.
tally() { printf '%s' "$json" | grep -o "\"status\": *\"$1\"" | wc -l | tr -d ' '; }

out=""
# Ordered by how much they want your attention, not alphabetically.
for s in waiting done working stale; do
  n=$(tally "$s")
  [ "$n" -eq 0 ] && continue
  case "$s" in
    waiting) out="$out#[fg=colour232,bg=colour1] 󰭹 $n " ;;  # red: needs you
    done)    out="$out#[fg=colour232,bg=colour2] 󰄬 $n " ;;  # green: finished
    working) out="$out#[fg=colour232,bg=colour3] 󰑮 $n " ;;  # yellow: busy
    stale)   out="$out#[fg=colour232,bg=colour8] 󰅖 $n " ;;  # grey: stale
  esac
done

[ -n "$out" ] && printf '%s#[default] ' "$out"
