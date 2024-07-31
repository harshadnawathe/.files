set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
fish_add_path -gP "/opt/homebrew/bin" "/opt/homebrew/sbin";
set -q MANPATH; and set MANPATH[1] ":$(string trim --left --chars=":" $MANPATH[1])";
! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;
