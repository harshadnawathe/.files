# Colourised man pages via bat. Ported verbatim from conf.d/pager.fish, which
# is where the measurements below were taken.
#
# `col -bx` is not optional. Even with MANROFFOPT=-c, macOS groff still emits
# backspace-overstrike sequences for bold and underline -- measured on `man ls`:
#
#   raw man output          esc: 0    backspace: 153
#   piped straight to bat   esc: 134  backspace: 153   <- overstrike survives
#   through `col -bx`       esc: 0    backspace: 0
#
# Without col those \x08 pairs reach the terminal as literal `l^Hl^Hs^Hs`.
# `-b` drops the backspaces, `-x` turns tabs into spaces so bat's line
# handling stays sane.
#
# MANROFFOPT=-c tells groff not to emit its own SGR colours, which would
# otherwise fight bat's syntax highlighting.
#
# The fish version deliberately sat outside `status is-interactive` so that
# scripts and nvim's `:!man` got it too. The zsh equivalent would be ~/.zshenv;
# it is here instead because MANPAGER is only ever read by a pager attached to
# a terminal, and ~/.zshenv runs for every `zsh -c` on the machine.
export MANROFFOPT=-c
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
