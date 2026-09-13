#!/usr/bin/env bash
# Global workmux agent tally for status-right.
# Prints nothing when no agents are tracked, so the segment costs zero
# columns when you aren't running any.
#
# Renders as one pill, matching the git and clock segments: an accent cap
# plus a colour235 body. The cap takes the colour of the most urgent
# status present, so a waiting agent still turns a solid block red the way
# the old per-status blocks did -- foreground colour alone reads too
# quietly for something meant to interrupt you.

json=$(workmux status --all --json 2>/dev/null) || exit 0

# grep -o | wc -l, not grep -c: counts occurrences, not matching lines,
# so it holds whether or not the JSON is pretty-printed.
tally() { printf '%s' "$json" | grep -o "\"status\": *\"$1\"" | wc -l | tr -d ' '; }

BODY='#[default,bg=colour235]'

n_waiting=$(tally waiting)
n_done=$(tally done)
n_working=$(tally working)
n_stale=$(tally stale)

[ $((n_waiting + n_done + n_working + n_stale)) -eq 0 ] && exit 0

# Cap colour: most urgent status wins.
if   [ "$n_waiting" -gt 0 ]; then cap=colour1   # red: needs you
elif [ "$n_done"    -gt 0 ]; then cap=colour2   # green: finished
elif [ "$n_working" -gt 0 ]; then cap=colour3   # yellow: busy
else                              cap=colour8   # grey: only stale left
fi

# Body: bright foregrounds, which read better than the base colours on 235.
seg=""
add() { [ "$1" -gt 0 ] && seg="$seg#[fg=$2]$3 $1$BODY  "; }
add "$n_waiting" colour9   '󰭹'
add "$n_done"    colour10  '󰄬'
add "$n_working" colour11  '󰑮'
add "$n_stale"   colour244 '󰅖'

seg="${seg%%  }"  # drop the trailing pad from the last add

printf '#[fg=colour232,bg=%s] 󰚩 %s %s #[default] ' "$cap" "$BODY" "$seg"
