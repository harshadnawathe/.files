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

    starship init fish | source
    zoxide init fish | source
end


#Add direnvj
# direnv hook fish | source

#rtx 
mise activate fish | source

# Go
export GOPATH=/Users/harshadn/Go

fish_add_path -m \
    $GOPATH/bin \
    ~/bin  \
    /usr/sbin/ \
    "/Users/harshadn/Library/Application Support/JetBrains/Toolbox/scripts/"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# set --export --prepend PATH "/Users/harshadn/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
