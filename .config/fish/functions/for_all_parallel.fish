function for_all_parallel -d "Utility to recursively find git repos and run a command in parallel"
  set -q FOLDER || set FOLDER .
  set -q MINDEPTH || set MINDEPTH 1
  set -q MAXDEPTH || set MAXDEPTH 3

  # echo "folder: $FOLDER"
  # echo "mindepth: $MINDEPTH"
  # echo "maxdepth: $MAXDEPTH"

  fd  \
  -H \
  --no-ignore-vcs \
  -t d \
  --min-depth $MINDEPTH --max-depth $MAXDEPTH \
  -x sh -c 'cd {//}; \
  printf -v title -- "\033[1;33m$1\033[0m in \033[1;36m`basename $(pwd)`\033[0m"; \
  title_len=`wc -c <<< $title`; \
  columns=`tput cols`; \
  left_pad_len=$(((columns - title_len - 2)/2)); \
  right_pad_len=$((columns - title_len - 2 - left_pad_len)); \
  printf -v left_padding -- "\033[0;32m%${left_pad_len}s\033[0m"; \
  left_padding=${left_padding// /─}; \
  printf -v right_padding -- "\033[0;32m%${right_pad_len}s\033[0m"; \
  right_padding=${right_padding// /─}; \
  printf -- "%s %s %s\n" "$left_padding" "$title" "$right_padding"; \
  $1\
  ' -- "$argv" \; \
  '^.git$' \
  $FOLDER
end
