function edit_file_command_fzf -d "Select and open file using default editor"
    set open_cmd $(~/bin/fzf_select_file | awk -F':' -v e=$EDITOR '{ printf "%s %s", e, $1 }')

    if test -n "$open_cmd"
        echo $open_cmd
    else
        echo $EDITOR
    end
end
