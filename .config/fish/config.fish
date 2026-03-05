if not status is-interactive
    fish_add_path -gm ~/.local/share/mise/shims
else
    fzf_configure_bindings --directory=\cf --git_log= --git_status=\cs --history= --processes= --variables=\cv
end

fish_add_path -gm \
    ~/bin \
    ~/go/bin \
    ~/.local/bin \
    "/Users/harshadn/Library/Application Support/JetBrains/Toolbox/scripts/"
