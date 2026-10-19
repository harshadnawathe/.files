# Command-line colours, ported from conf.d/fish_frozen_theme.fish. This is the
# one piece of the look that comes from neither starship nor the Ghostty theme,
# so without it the line you are typing is the only unthemed surface left.
#
# ANSI 0-15 only, never the 216-colour cube -- same rule as starship.toml and
# tmux/theme.conf, and for the same reason: those indices are remapped by the
# Ghostty theme, so this retints along with everything else. fish's names map
# directly (brblack 8, brred 9, brcyan 14).
#
# fast-syntax-highlighting splits what fish calls "command" across seven keys
# and what fish calls "quote" across three, hence the grouping below. Assigned
# after the plugin has loaded, which is fine -- the table is read at highlight
# time, not at load.

# fish_color_command blue
for _k in command builtin function precommand hashed-command alias suffix-alias; do
  FAST_HIGHLIGHT_STYLES[$_k]='fg=blue'
done
FAST_HIGHLIGHT_STYLES[reserved-word]='fg=blue'   # fish colours `if`/`for` as commands

# fish_color_param cyan -- plain arguments
FAST_HIGHLIGHT_STYLES[default]='fg=cyan'
FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'

# fish_color_quote yellow
for _k in single-quoted-argument double-quoted-argument dollar-quoted-argument; do
  FAST_HIGHLIGHT_STYLES[$_k]='fg=yellow'
done

# fish_color_escape brcyan -- backslash escapes, inside quotes and out
FAST_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=14'
FAST_HIGHLIGHT_STYLES[back-or-dollar-double-quoted-argument]='fg=14'

FAST_HIGHLIGHT_STYLES[comment]='fg=red'            # fish_color_comment red
FAST_HIGHLIGHT_STYLES[unknown-token]='fg=9'        # fish_color_error brred
FAST_HIGHLIGHT_STYLES[commandseparator]='fg=green' # fish_color_end green
FAST_HIGHLIGHT_STYLES[globbing]='fg=14'            # fish_color_operator brcyan
FAST_HIGHLIGHT_STYLES[variable]='fg=14'            # fish puts `$` under operator
FAST_HIGHLIGHT_STYLES[redirection]='fg=cyan,bold'  # fish_color_redirection cyan --bold

# fish_color_valid_path --underline: an underline *in addition to* whatever
# colour the token already had, which is why neither of these sets fg.
FAST_HIGHLIGHT_STYLES[path]='underline'
FAST_HIGHLIGHT_STYLES[path-to-dir]='underline'

unset _k

# fish_color_autosuggestion brblack
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
