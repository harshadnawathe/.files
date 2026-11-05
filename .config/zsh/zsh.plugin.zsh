# Single entry point for this directory, loaded from .zshrc by zinit.

# zinit's recommended $0 handling, so the plugin finds its own directory.
0=${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}
0=${${(M)0:#/*}:-$PWD/$0}
zsh_config_dir=${0:A:h}

fpath=($zsh_config_dir/functions $fpath)

# ensure ./functions/ is not empty
autoload -Uz $zsh_config_dir/functions/*(.:t)

# conf.d configurations are loaded in sorted order
for conf in $zsh_config_dir/conf.d/*.zsh(N) $zsh_config_dir/aliases/*.zsh(N); do
  source $conf
done

unset zsh_config_dir conf
