cask_args appdir: "/Applications"

tap "homebrew/bundle"
# tap "homebrew/cask"
# tap "homebrew/core"
tap "homebrew/cask-fonts"
tap "homebrew/services"
tap "buo/cask-upgrade"

# clojure
# not able to find a rtx plugin for this
# tap "clojure/tools"
# brew "clojure/tools/clojure"
# brew "leiningen"

# scala
# brew "sbt"
# brew "metals"
# brew "coursier"

brew "mas"

# tap "spring-io/tap"
# tap "buildpacks/tap"


# brew "grpc"
# brew "apache-arrow"
brew "cmake"
brew "clang-format"
# brew "pack"

# brew "zsh"
brew "fish"
is_fish_installed = !`which fish`.chomp.empty?
if is_fish_installed 
  File.open("#{Dir.home}/.config/fish/conf.d/brew-shellenv.fish", mode:'w') do |f|
    f.write(`brew shellenv fish`)
  end
end

brew "jq"
brew "yq"
brew "ripgrep"
brew "ast-grep"
# brew "git"
brew "pre-commit"
brew "starship"
is_starship_installed = !`which starship`.chomp.empty?
if is_fish_installed && is_starship_installed 
  File.open("#{Dir.home}/.config/fish/conf.d/starship-activate.fish", mode:'w') do |f|
    f.write("status is-interactive; or exit 0\n\n")
    f.write(`starship init fish --print-full-init`)
  end
end

# brew "autojump"  # replaces with zoxide
brew "zoxide"
is_zoxide_installed = !`which zoxide`.chomp.empty?
if is_fish_installed && is_zoxide_installed 
  File.open("#{Dir.home}/.config/fish/conf.d/zoxide-activate.fish", mode:'w') do |f|
    f.write("status is-interactive; or exit 0\n\n")
    f.write(`zoxide init fish`)
  end
end

brew "thefuck"
is_thefuck_installed = !`which thefuck`.chomp.empty?
if is_fish_installed && is_thefuck_installed
  File.open("#{Dir.home}/.config/fish/conf.d/thefuck-alias.fish", mode:'w') do |f|
    f.write("status is-interactive; or exit 0\n\n")
    f.write(`TF_SHELL=fish thefuck --alias`)
  end
end

brew "lsd"
brew "bat"
brew "git-delta"
# brew "libssh"
# brew "talisman"
brew "fswatch"
# brew "entr"
brew "coreutils"
brew "parallel"
brew "wget"
# brew "dos2unix"
brew "btop"

brew "qemu"
brew "colima"
# brew "minikube" # repalced with rancher
# cask "rancher"   # replaced with colima
# brew "kind"
brew "docker"
brew "docker-compose"
brew "docker-buildx"
brew "docker-credential-helper"

# brew "libgit2"
# brew "python-tabulate"
# brew "dvc"
# brew "gh"
# brew "gnupg"

# brew "hyperkit"
# brew "krb5"
# brew "kubernetes-cli"
# brew "terraform"
# brew "spring-boot"

brew "k9s"

# brew "go" #using asdf-vm
# brew "node@16" #using asdf-vm
# brew "node@14" #using asdf-vm
# brew "openjdk" #using asdf-vm
# brew "openjdk@8" #using asdf-vm
# brew "postgresql@14"
# brew "python@3.9" #using asdf-vm

# brew "mongosh"
# brew "postgresql"
# brew "kafka"
# brew "redis"
# brew "rabbitmq"
# brew "tree"  # replaced with lsd -T
# brew "yarn"
# brew "mongodb/brew/mongodb-community"
# brew "direnv"
# brew "duckdb"
brew "tmux"

brew "fzf"       #for tmux plugin
is_fzf_installed = !`which fzf`.chomp.empty?
if is_fish_installed && is_fzf_installed 
  File.open("#{Dir.home}/.config/fish/conf.d/fzf-activate.fish", mode:'w') do |f|
    f.write("status is-interactive; or exit 0\n\n")
    f.write(`fzf --fish`)
    f.write("\n\nbind --erase \cr")
  end
end

brew "fpp"       #for tmux plugin
# brew "urlview"   #for tmux urlview
# brew "extract_url"
# brew "gifski"
# brew "zellij"  # not able to replicate the current tmux workflow of session manangement

# brew "asdf" #replaced with rtx
# brew "rtx"
brew "mise"
is_mise_installed = !`which mise`.chomp.empty?
if is_fish_installed && is_mise_installed 
  File.open("#{Dir.home}/.config/fish/conf.d/mise-activate.fish", mode:'w') do |f|
    f.write("status is-interactive; or exit 0\n\n")
    f.write(`mise activate fish`)
  end
end

brew "gpg"
brew "gawk"
brew "gnu-sed" # required by nvim plugin spectre
brew "stow"
brew "neovim"
# cask "neovide"
# brew "neovim", args: ["HEAD"]
# brew "yazi"

# brew "helix", args: ["ignore-dependencies"]
# language-servers for helix
# brew "rust-analyzer"

# Required by neovim pluins
# brew "stylua"
# brew "prettier", args: ["ignore-dependencies"]
brew "lazygit"
# brew "lazydocker"
# brew "cmatrix" 
# Alternative is https://github.com/st3w/neo - requires build
# brew "automake"  #required for neo build
# brew "ncurses"   #required for neo build
brew "fd" # required by nvim venv-selector-plugin
brew "luarocks"
# brew "checkstyle"
# brew "pmd"

brew "ollama"

cask "rectangle"
cask "notunes"
# cask "amethyst"   #Tiling manager with layout
cask "zoom"
# cask "microsoft-remote-desktop"
# cask "microsoft-teams"
# cask "webex"
cask "visual-studio-code"
# cask "vscodium"
# cask "skype"
# cask "whatsapp"
# cask "xmind"
# cask "kitty"
# cask "iterm2"
#cask "alacritty"
cask "wezterm"
# cask "warp"
# cask "adobe-acrobat-reader"
cask "jetbrains-toolbox"
# cask "citrix-workspace"
# cask "vmware-horizon-client"
# cask "virtualbox"
cask "google-drive"
cask "firefox"
cask "google-chrome"
# cask "google-chat"
cask "slack"
cask "ferdium"
# cask "anaconda"
cask "kindle"
# cask "logitech-options"
# cask "logi-options-plus"
cask "logitech-camera-settings"
cask "caffeine"
cask "obsidian"
cask "postman"
cask "raycast"
# cask "openoffice"
# cask "libreoffice"
cask "drawio"

cask "font-symbols-only-nerd-font"
cask "font-fira-code"
cask "font-jetbrains-mono"
cask "font-monaspace"
cask "karabiner-elements"

# cask "font-hack-nerd-font"
cask "font-fira-code-nerd-font"
# cask "font-jetbrains-mono-nerd-font"
# cask "font-monaspace-nerd-font"
# cask "font-meslo-lg-nerd-font"
# cask "font-powerline-symbols"

vscode "Catppuccin.catppuccin-vsc"
vscode "angular.ng-template"
vscode "golang.go"
vscode "ms-python.python"
vscode "vmware.vscode-boot-dev-pack"
vscode "vscjava.vscode-gradle"
vscode "vscjava.vscode-java-pack"
vscode "mongodb.mongodb-vscode"
vscode "gitlab.gitlab-workflow"
vscode "ms-azuretools.vscode-docker"
vscode "ms-vscode-remote.vscode-remote-extensionpack"
vscode "humao.rest-client"
vscode "iterative.vscode-dvc-pack"

mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
mas "‎WhatsApp", id: 310633997

# For project work
# brew "glab" 
# brew "kubectx" 
brew "kubectl" 
brew "helm"
# brew "just" 
# brew "sshuttle" 
brew "aws-vault" 
# tap "alajmo/mani" 
# brew "mani"
# brew "ansible" 
brew "awscli" 
# tap "mongodb/brew"              
# brew "mongodb-database-tools"   
# cask "mongodb-compass"          
# cask "dbeaver-community"        
# cask "pgadmin4"                 
# brew "gitleaks"
brew "thrift"
brew "azure-cli"
tap "Azure/kubelogin"
brew "Azure/kubelogin/kubelogin"
