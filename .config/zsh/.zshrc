# Interactive shells only. Loaded from $ZDOTDIR (see ~/.zshenv), which is why
# this file and .zprofile live here rather than in $HOME.
#
# Nothing is configured in this file -- it only decides what loads and in what
# order. Settings go in .zshrc.d/, functions in .zfunctions/, completion styles
# in .zstyles.

# Before antidote: fzf-tab reads these when it builds its menu, and ez-compinit
# defers the real compinit to the end of startup so the rest still applies.
[[ ! -f ${ZDOTDIR}/.zstyles ]] || source ${ZDOTDIR}/.zstyles

# Clones and the generated static bundle stay out of the repo. Anything written
# inside .config/zsh/ would break stow's directory fold -- see .config/workmux,
# which is file-linked today for exactly that reason.
export ANTIDOTE_HOME=${XDG_CACHE_HOME}/antidote
zstyle ':antidote:static' file ${XDG_CACHE_HOME}/zsh/.zsh_plugins.zsh
zstyle ':antidote:static' zcompile yes

# $HOMEBREW_PREFIX, not `brew --prefix`: ~/.zshenv already sourced the cached
# `brew shellenv`, and a fork here would cost more than everything below it.
source ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/antidote/share/antidote/antidote.zsh
antidote load

# Autoloaded rather than sourced: a function body is only read the first time
# its name is called.
# The (N) keeps a missing directory quiet, but an EMPTY one is the trap: the
# glob then yields zero words and `autoload -Uz` with no operands *lists* every
# autoload in the shell instead of defining anything -- 639 lines of
# fast-syntax-highlighting chromas onto stdout at every startup, which also
# corrupts anything scraping `zsh -ic`.
if [[ -d ${ZDOTDIR}/.zfunctions ]]; then
  fpath=(${ZDOTDIR}/.zfunctions $fpath)
  _zfns=(${ZDOTDIR}/.zfunctions/*(.N:t))
  (( $#_zfns )) && autoload -Uz $_zfns
  unset _zfns
fi

# (N) so an absent or empty directory is not a glob error -- these files arrive
# over the course of the migration and the loop has to survive their absence.
for _rc in ${ZDOTDIR}/.zshrc.d/*.zsh(N); do
  [[ ${_rc:t} == '~'* ]] || source $_rc
done
unset _rc
