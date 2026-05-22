# brew
if not test -f ~/.config/fish/caches/brew_shellenv.fish
  brew shellenv fish > ~/.config/fish/caches/brew_shellenv.fish
end
source ~/.config/fish/caches/brew_shellenv.fish

fish_add_path -gm \
~/bin \
~/go/bin \
~/.local/bin \
"/Users/harshadn/Library/Application Support/JetBrains/Toolbox/scripts/"

if not status is-interactive
  fish_add_path -gm ~/.local/share/mise/shims
end

if status is-interactive
  fzf_configure_bindings --directory=\cf --git_log= --git_status=\cs --history= --processes= --variables=\cv

  # starship
  if not test -f ~/.config/fish/caches/starship_init.fish 
    starship init fish > ~/.config/fish/caches/starship_init.fish
  end
  source ~/.config/fish/caches/starship_init.fish

  # mise
  if not test -f ~/.config/fish/caches/mise_activate.fish
    mise activate fish > ~/.config/fish/caches/mise_activate.fish
  end
  source ~/.config/fish/caches/mise_activate.fish

  # thefuck
  if not test -f ~/.config/fish/caches/thefuck.fish
    thefuck --alias > ~/.config/fish/caches/thefuck.fish
  end
  source ~/.config/fish/caches/thefuck.fish

  # zoxide
  if not test -f ~/.config/fish/caches/zoxide-init.fish
    zoxide init fish > ~/.config/fish/caches/zoxide-init.fish
  end
  source ~/.config/fish/caches/zoxide-init.fish
end
