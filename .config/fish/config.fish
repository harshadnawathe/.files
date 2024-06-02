eval (/opt/homebrew/bin/brew shellenv)

if status is-interactive
  # Commands to run in interactive sessions can go here
  set -U fish_greeting

  # # Abbreaviations
  # for f in $(find ~/.config/fish/abbrs/ -type f -name '*-abbr.fish' )
  #     source $f
  # end

  # Use lsd as ls command with color and icons
  set -g __fish_ls_command lsd
  set -g __fish_ls_color_opt --color=auto

  #Theme
  # fish_config theme choose Nord

  # FZF Theme
  set -Ux FZF_DEFAULT_OPTS "\
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

  starship init fish | source
  zoxide init fish | source
  mise activate fish | source
else
  mise activate --shims | source
end

# golang
set -Ux GOPATH (~/.local/share/mise/shims/go env GOPATH)
fish_add_path $GOPATH/bin

# custom tools
fish_add_path -m \
  ~/bin \
  /usr/sbin/ \
  "/Users/harshadn/Library/Application Support/JetBrains/Toolbox/scripts/"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# set --export --prepend PATH "/Users/harshadn/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
