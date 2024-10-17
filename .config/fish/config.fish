if not status is-interactive
  eval "$(mise activate fish --shims)"
end

fish_add_path -gm \
  ~/bin \
  ~/go/bin \
  ~/.local/bin \
  "/Users/harshadn/Library/Application Support/JetBrains/Toolbox/scripts/"

