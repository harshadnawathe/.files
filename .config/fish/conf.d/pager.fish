# Colourised man pages via bat.
#
# Deliberately not gated on `status is-interactive`: man also gets run from
# scripts and from nvim's `:!man`, and two `set` calls cost nothing.
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
set -gx MANROFFOPT -c
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
