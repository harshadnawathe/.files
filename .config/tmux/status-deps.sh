#!/usr/bin/env bash
# Warn at config-source time about tools the status bar shells out to.
#
# The pill scripts degrade silently by design -- a missing tool renders
# nothing rather than an error string in the bar -- which is right for the
# bar but means a PATH problem is indistinguishable from "nothing to show".
# This closes that gap: you learn once, at source time, that a segment is
# disabled rather than idle.
#
# tmux runs this via run-shell, so display-message needs an attached
# client. At server start there may not be one yet and the warning is
# missed; on a reload (prefix + r, or source-file) it always shows.

declare -a missing=()
command -v git     >/dev/null 2>&1 || missing+=('git (branch pill)')
command -v workmux >/dev/null 2>&1 || missing+=('workmux (agent pill)')

[ ${#missing[@]} -eq 0 ] && exit 0

list=$(printf '%s, ' "${missing[@]}")
tmux display-message -d 5000 "status bar: ${list%, } not on PATH -- disabled"
