
# Enable Vi mode
set -g fish_key_bindings fish_vi_key_bindings

function fish_user_key_bindings
  # Bind Ctrl+P and Ctrl+N to history navigation in insert mode
  bind -M insert \cp up-or-search
  bind -M insert \cn down-or-search
end

# brew, by absolute path: it is not on fish's default PATH, so resolving it by
# name only works in a shell that inherited one. Everything below relies on
# shellenv having put the brew prefix on PATH.
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew
  if test -x $brew_bin
    cached_eval brew_shellenv $brew_bin "$brew_bin shellenv fish"
    break
  end
end

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

  # $argv forwards --status/--keymap from starship's fish init, so the
  # collapsed prompt turns red after a failure and shows the vi-mode
  # character. Without it every scrollback arrow is a green insert-mode one.
  function starship_transient_prompt_func
    starship module character $argv
  end
  cached_eval starship_init starship "starship init fish"
  enable_transience

  cached_eval mise_activate mise "mise activate fish"
  cached_eval thefuck thefuck "thefuck --alias"
  cached_eval zoxide_init zoxide "zoxide init fish"
  cached_eval television_integration tv "tv init fish"
  cached_eval workmux_completions workmux "workmux completions fish"
end
