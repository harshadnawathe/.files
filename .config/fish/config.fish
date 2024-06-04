# brew
eval (/opt/homebrew/bin/brew shellenv)

starship init fish | source
zoxide init fish | source
mise activate fish | source

# golang
set -x GOPATH (~/.local/share/mise/shims/go env GOPATH)
fish_add_path -gP $GOPATH/bin

# custom tools
fish_add_path -gP \
  ~/bin \
  "/Users/harshadn/Library/Application Support/JetBrains/Toolbox/scripts/"
