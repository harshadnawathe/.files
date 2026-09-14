# delta themes -- trimmed to the one theme actually in use.
#
# Upstream ships ~15 themes in this file. Only mellow-barbet is referenced
# (see `delta.features` in ../../git/config), and the other 14 contributed
# 331 dead entries to `git config --list` -- 362 of 491 total, for 31 used.
#
# Source: https://github.com/dandavison/delta/blob/main/themes.gitconfig
# To try another theme, copy its block back in from upstream and add its
# name to `delta.features`.
#
# The tokyonight feature that overrides syntax-theme lives in ../../git/config,
# not here, so it is unaffected by anything in this file.

[delta "mellow-barbet"]
    # author: https://github.com/kvrohit
    # To configure terminal colors see https://github.com/kvrohit/mellow.nvim#terminals
    dark = true
    syntax-theme = base16
    line-numbers = true
    side-by-side = true
    file-style = brightwhite
    file-decoration-style = none
    file-added-label = [+]
    file-copied-label = [==]
    file-modified-label = [*]
    file-removed-label = [-]
    file-renamed-label = [->]
    hunk-header-decoration-style = "#3e3e43" box ul
    plus-style = brightgreen black
    plus-emph-style = black green
    minus-style = brightred black
    minus-emph-style = black red
    line-numbers-minus-style = brightred
    line-numbers-plus-style = brightgreen
    line-numbers-left-style = "#3e3e43"
    line-numbers-right-style = "#3e3e43"
    line-numbers-zero-style = "#57575f"
    zero-style = syntax
    whitespace-error-style = black bold
    blame-code-style = syntax
    blame-palette = "#161617" "#1b1b1d" "#2a2a2d" "#3e3e43"
    merge-conflict-begin-symbol = ~
    merge-conflict-end-symbol = ~
    merge-conflict-ours-diff-header-style = yellow bold
    merge-conflict-ours-diff-header-decoration-style = "#3e3e43" box
    merge-conflict-theirs-diff-header-style = yellow bold
    merge-conflict-theirs-diff-header-decoration-style = "#3e3e43" box
