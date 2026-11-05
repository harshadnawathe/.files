# OMZP::brew covers the rest; these greedy variants have no OMZ equivalent.
alias bcg='brew outdated --greedy'
alias bcug='brew upgrade --greedy'
alias bupc='brew update && brew upgrade && brew cleanup; brew autoremove; brew cleanup --prune=0'
