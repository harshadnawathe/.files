
# Enable Vi mode
set -g fish_key_bindings fish_vi_key_bindings

# brew
if not test -f ~/.config/fish/caches/brew_shellenv.fish
  brew shellenv fish > ~/.config/fish/caches/brew_shellenv.fish
end
source ~/.config/fish/caches/brew_shellenv.fish

fish_add_path -gm \
~/bin \
~/go/bin \
~/.local/bin \
"~/Library/Application Support/JetBrains/Toolbox/scripts/"

if not status is-interactive
  fish_add_path -gm ~/.local/share/mise/shims
end

if status is-interactive
  if test -f (brew --prefix)/etc/brew-wrap.fish
    source (brew --prefix)/etc/brew-wrap.fish
  end

  fzf_configure_bindings --directory=\cf --git_log= --git_status=\cs --history= --processes= --variables=\cv

  # starship
  if not test -f ~/.config/fish/caches/starship_init.fish 
    starship init fish > ~/.config/fish/caches/starship_init.fish
  end
  function starship_transient_prompt_func
    printf "   "
    starship module character
  end
  source ~/.config/fish/caches/starship_init.fish
  enable_transience

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
