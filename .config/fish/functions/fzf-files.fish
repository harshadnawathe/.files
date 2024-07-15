function fzf-files -d "List files using fzf"
  function __fzf_parse_commandline -d 'Parse the current command line token and return split of existing filepath, fzf query, and optional -option= prefix'
    set -l commandline (commandline -t)

    # strip -option= from token if present
    set -l prefix (string match -r -- '^-[^\s=]+=' $commandline)
    set commandline (string replace -- "$prefix" '' $commandline)

    # eval is used to do shell expansion on paths
    eval set commandline $commandline

    if [ -z $commandline ]
      # Default to current directory with no --query
      set dir '.'
      set fzf_query ''
    else
      set dir (__fzf_get_dir $commandline)

      if [ "$dir" = "." -a (string sub -l 1 -- $commandline) != '.' ]
        # if $dir is "." but commandline is not a relative path, this means no file path found
        set fzf_query $commandline
      else
        # Also remove trailing slash after dir, to "split" input properly
        set fzf_query (string replace -r "^$dir/?" -- '' "$commandline")
      end
    end

    echo $dir
    echo $fzf_query
    echo $prefix
  end

  set -l commandline (__fzf_parse_commandline)
  set -lx dir $commandline[1]
  set -l fzf_query $commandline[2]
  set -l prefix $commandline[3]

  for r in (~/bin/fzf_select_file $fzf_query);
    set result $result $r
  end

  if test -z "$result"
    commandline -f repaint
    return
  else
    commandline -t ""
  end

  for i in $result
    commandline -it -- $prefix
    commandline -it -- (string escape $i)
    commandline -it -- ' '
  end

  commandline -f repaint

end
