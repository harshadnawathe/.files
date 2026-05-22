# 1. Ensure Homebrew paths are front-and-center
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. Expose Mise shims and local bins to the core environment
export PATH="$HOME/.local/share/mise/shims:$HOME/.local/share/mise/bin:$HOME/.local/bin:$PATH"
