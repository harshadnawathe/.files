#
# This file initializes the zsh using zinit.
# Preference is given to use zinit wherever possible.
# Local configuration comes from a local plugin at `./.config/zsh` (loaded last)
#

# zinit home 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"

# zinit only prepends $ZPFX/bin if it already exists. $ZPFX comes from .zshenv.
[ ! -d $ZPFX/bin ] && mkdir -p "$ZPFX/bin"

#
# zinit installation
#
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


#
# Non-turbo - make the prompt loading slow
#

zinit light-mode for zdharma-continuum/zinit-annex-bin-gem-node

# starship
zinit from"gh-r" as"null" sbin"starship" \
  atclone"./starship init zsh > starship_init.zsh; ./starship completions zsh > _starship; zinit creinstall -q starship/starship" \
  atpull"%atclone" src"starship_init.zsh" nocompile'!' \
  for @starship/starship

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

#
# Turbo mode - loaded after the prompt
#
# The number in wait is seconds, the letter orders within it. Only a, b and c
# exist -- anything else silently falls back to the first slot.
#
# Statements are ordered as per the dependency requirements and overriding order

zinit wait"0a" lucid from"gh-r" as"null" sbin"fzf" \
  atclone"./fzf --zsh > fzf_init.zsh" \
  atpull"%atclone" src"fzf_init.zsh" nocompile'!' \
  for @junegunn/fzf

zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#545c7e'

zinit wait"0a" lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    Aloxaf/fzf-tab \
  zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit wait"0b" lucid from"gh-r" as"null" sbin"zoxide" \
  atclone"./zoxide init zsh > zoxide_init.zsh; zinit creinstall -q ajeetdsouza/zoxide" \
  atpull"%atclone" src"zoxide_init.zsh" nocompile'!' \
  for @ajeetdsouza/zoxide

zinit wait"0b" lucid from"gh-r" as"null" mv"mise-* -> mise" sbin"mise" \
  atclone"./mise completions zsh > _mise; zinit creinstall -q jdx/mise" atpull"%atclone" \
  atload'eval "$(mise activate zsh)"' \
  for @jdx/mise

zinit wait"0b" lucid from"gh-r" as"null" \
  bpick"*aarch64-apple-darwin.tar.gz" sbin"**/vivid -> vivid" \
  atclone'print -r -- "export LS_COLORS=${(qq)$(./*/vivid generate tokyonight-night)}" > ls_colors.zsh' \
  atpull"%atclone" src"ls_colors.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}' \
  for @sharkdp/vivid

zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'icons' yes

zinit wait"0b" lucid light-mode for \
  OMZP::eza \
  OMZP::vi-mode \
  OMZP::git \
  OMZP::brew

zinit wait"0c" lucid from"gh-r" as"null" bpick"*darwin_arm64*" sbin"carapace" \
  atclone"./carapace _carapace zsh > carapace_init.zsh" \
  atpull"%atclone" src"carapace_init.zsh" nocompile'!' \
  atload"zicdreplay" \
  for @carapace-sh/carapace-bin

zinit wait"0c" lucid from"gh-r" as"null" \
  bpick"*aarch64-apple-darwin.tar.gz" sbin"**/tv -> tv" \
  atclone"./*/tv init zsh > tv_init.zsh" \
  atpull"%atclone" src"tv_init.zsh" nocompile'!' \
  atload"zicdreplay" \
  for @alexpasmantier/television

zinit wait"0c" lucid from"gh-r" as"null" \
  bpick"atuin-aarch64-apple-darwin.tar.gz" sbin"**/atuin -> atuin" \
  atclone"./*/atuin init zsh --disable-up-arrow > atuin_init.zsh; ./*/atuin gen-completions --shell zsh > _atuin; zinit creinstall -q atuinsh/atuin" \
  atpull"%atclone" src"atuin_init.zsh" nocompile'!' \
  for @atuinsh/atuin

#
# My ZSH configuration.
# Always keep last as it overrioes some of the zinit plugin configurations
#
zinit wait"0c" lucid light-mode for %${XDG_CONFIG_HOME:-$HOME/.config}/zsh
