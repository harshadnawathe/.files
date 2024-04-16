function vim_edit_file_command_fzf -d "Select and open file using neo vim"
    set open_cmd $(~/bin/fzf_select_file | 
      awk -F':' 'NF == 1 { printf "nvim %s", $1 } NF >= 2 { printf "nvim +%s %s", $2, $1 }')

    if test -n "$open_cmd"
        echo $open_cmd
    else
        echo $EDITOR
    end
end
