#!/usr/bin/env bash
# Global workmux agent tally for status-right.
# Prints nothing when no agents are tracked, so the segment costs zero
# columns when you aren't running any.
#
# Renders as one pill, matching the git and clock segments: an accent cap
# plus a @sb_body body. The cap takes the colour of the most urgent
# status present, so a waiting agent still turns a solid block red the way
# the old per-status blocks did -- foreground colour alone reads too
# quietly for something meant to interrupt you.

# Pull the @sb_* palette in one tmux call rather than one per colour, so
# these scripts and theme.conf share a single source of truth. Defaults
# keep the pill readable if the palette block ever goes missing.
eval "$(tmux show -g 2>/dev/null | sed -n 's/^@sb_\([a-z]*\) \(.*\)$/SB_\1=\2/p')"
: "${SB_dark:=colour0}"  ; : "${SB_body:=colour0}" ; : "${SB_alert:=colour1}"
: "${SB_ok:=colour2}"    ; : "${SB_busy:=colour3}" ; : "${SB_git:=colour5}"
: "${SB_mute:=colour8}"  ; : "${SB_text:=colour15}"

json=$(workmux status --all --json 2>/dev/null) || exit 0

# grep -o | wc -l, not grep -c: counts occurrences, not matching lines,
# so it holds whether or not the JSON is pretty-printed.
tally() { printf '%s' "$json" | grep -o "\"status\": *\"$1\"" | wc -l | tr -d ' '; }

BODY="#[default,bg=$SB_body,fg=$SB_text]"

n_waiting=$(tally waiting)
n_done=$(tally done)
n_working=$(tally working)
n_stale=$(tally stale)

[ $((n_waiting + n_done + n_working + n_stale)) -eq 0 ] && exit 0

# Cap colour: most urgent status wins.
if   [ "$n_waiting" -gt 0 ]; then cap=$SB_alert   # red: needs you
elif [ "$n_done"    -gt 0 ]; then cap=$SB_ok      # green: finished
elif [ "$n_working" -gt 0 ]; then cap=$SB_busy    # yellow: busy
else                              cap=$SB_mute    # muted: only stale left
fi

# Body: same hues as the caps. There is no brighter tier to reach for --
# Tokyonight Night maps ANSI 9-14 to the same values as 1-6, so the
# colour9/10/11 this used to carry rendered identically to colour1/2/3.
seg=""
add() { [ "$1" -gt 0 ] && seg="$seg#[fg=$2]$3 $1$BODY  "; }
add "$n_waiting" "$SB_alert" '󰭹'
add "$n_done"    "$SB_ok"    '󰄬'
add "$n_working" "$SB_busy"  '󰑮'
add "$n_stale"   "$SB_mute"  '󰅖'

seg="${seg%%  }"  # drop the trailing pad from the last add

printf '#[fg=%s,bg=%s]   %s %s #[default] ' "$SB_dark" "$cap" "$BODY" "$seg"
