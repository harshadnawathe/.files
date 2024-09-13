
function __fzf-aws-vault-abbr

    function __fzf_select
        echo -e $argv \
            | tr ' ' '\n' \
            | fzf \
            --margin=1 --padding=1 --border \
            --ansi \
            --height=~50% \
            --reverse \
            --bind "ctrl-j:down,ctrl-k:up"
    end

    function __fzf-aws-profile
        __fzf_select $(aws-vault list --profiles)
    end

    function __fzf-aws-credential
        __fzf_select $(aws-vault list --credentials)
    end

    function __avsh
        echo "aws-vault exec $(__fzf-aws-profile) -- fish"
    end

    function __avenv
        echo "eval \$(aws-vault export $(__fzf-aws-profile) --format=export-env)"
    end

    function __avl
        echo "aws-vault login $(__fzf-aws-credential)"
    end

    #### Register abbreviations ####
    abbr -a avsh -f __avsh
    abbr -a avenv -f __avenv
    abbr -a avl -f __avl

end

__fzf-aws-vault-abbr
