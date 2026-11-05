# brew-wrap's brew() keeps the Brewfile in sync. Lift it out under its own name
# so functions/brew can wrap it.

[[ -r ${HOMEBREW_PREFIX:-/opt/homebrew}/etc/brew-wrap ]] || return

source ${HOMEBREW_PREFIX:-/opt/homebrew}/etc/brew-wrap
functions -c brew brewfile_update

# Sourcing brew-wrap clobbered the autoload marker for functions/brew. Without
# re-marking, `brew` falls through to the binary and Brewfile sync stops.
unfunction brew
autoload -Uz brew
