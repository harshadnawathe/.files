# The non-git aliases, ported from conf.d/{brew,vim,obs,misc}-abbr.fish.
#
# The 166 git ones are NOT here: they come from ohmyzsh/ohmyzsh path:plugins/git
# (see .zsh_plugins.txt), which is where they were copied from by hand in the
# first place. Only the two that encode this machine's own config rather than a
# git command are kept below.

# fish rendered `ls` through lsd via the __fish_ls_command universal variable
# rather than an alias, so there is nothing in the fish config to port here --
# only the behaviour. Interactive-only in both shells: fish's variable was read
# by its own `ls` wrapper, and a zsh alias is not expanded in scripts.
alias ls=lsd
alias tree='lsd --tree'

# --- brew ---
alias bcg='brew outdated --greedy'
alias bcug='brew upgrade --greedy'
alias bupc='brew update && brew upgrade && brew cleanup; brew autoremove; brew cleanup --prune=0'

# --- editor ---
alias v=nvim
# Retargeted: fish pointed this at ~/.config/nvim/lua/user/init.lua, an
# AstroNvim-era path that has not existed since the config moved to LazyVim --
# the abbreviation has been opening an empty buffer. `avim`
# (NVIM_APPNAME=nvim.astro) is dropped outright for the same reason;
# ~/.config/nvim.astro is gone too.
alias nvcfg='nvim ~/.config/nvim/init.lua'

# --- obsidian (scripts in ~/bin, stowed from bin/) ---
alias obn=obsidian_new
alias obf=obsidian_find
alias obt=obsidian_today

# --- aws ---
alias asf=aws-secrets-fzf

# --- workmux ---
alias wm=workmux
alias wma='workmux add'
alias wmr='workmux remove'
alias wml='workmux list'
alias wmd='workmux dashboard'
alias wms='workmux sidebar'

# --- git: the two that are this machine's, not oh-my-zsh's ---
# `all` is an alias in .config/git/config, so this is not a git command upstream
# could ever have.
alias gal='git all'
# The narrow-pane escape hatch from IMPROVEMENTS.md section 2. The leading `+`
# is load-bearing: a bare `unified` *replaces* the feature list and loses the
# mellow-barbet theme with it.
alias gdu='DELTA_FEATURES=+unified git diff'

# Deliberately not ported:
#
#   grep   `grep --color=auto --exclude-dir={...}` only ever lived in
#          git-abbr.fish by accident, and shadowing grep itself is the
#          annoyance it was meant to solve. .config/fd/ignore and ripgrep
#          already cover the exclusions.
#
#   gup*   renamed upstream to gpr*: gup/gupa/gupav/gupv/gupom/gupomi are now
#          gpr/gpra/gprav/gprv/gprom/gpromi. No compat aliases -- upstream's
#          names win.
#
#   !!     zsh expands it natively through history expansion, so neither the
#          abbreviation nor functions/last_command.fish is needed.
