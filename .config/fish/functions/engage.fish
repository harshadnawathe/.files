function engage
    if set -q argv[1]
        set session_name argv[1]
    else
        set session_name (basename $PWD)
    end

    set tmux_cmd "tmux attach -t $session_name || tmux new -s $session_name \;"
    set tmux_cmd "$tmux_cmd rename-window $session_name \;"

    for project_dir in (find . -type d -name .git -mindepth 1 -maxdepth 2 -execdir pwd \;)
        set window_name (basename $project_dir)
        set tmux_cmd " $tmux_cmd new-window -c $project_dir \; rename-window $window_name \;"
    end

    set tmux_cmd "$tmux_cmd select-window -t $session_name"

    fish -c $tmux_cmd
end
