# Source a tool's init script from a cache, regenerating it whenever the binary
# that generates it is newer. Guarding on existence alone -- as this config did
# until now -- meant a cache written once was never refreshed again, so an
# upgraded tool kept running its old init script indefinitely.
#
# $argv[1] cache name, $argv[2] the generating binary (name or absolute path;
# absent means the tool isn't installed, so do nothing), $argv[3..] the command.
function cached_eval --description 'Source a command\'s output from cache, refreshed when its binary changes'
    set -l bin (command -s $argv[2])
    test -n "$bin"; or return

    set -l base $XDG_CACHE_HOME
    test -n "$base"; or set base $HOME/.cache
    set -l dir $base/fish/activation_scripts
    set -l cache $dir/$argv[1].fish

    if test -s $cache; and test $cache -nt $bin
        source $cache
        return
    end

    mkdir -p $dir
    eval $argv[3..-1] >$cache.tmp
    if test -s $cache.tmp
        mv -f $cache.tmp $cache
        source $cache
    else
        # Never leave an empty file behind: it would look like a valid cache and
        # silently skip the tool forever. Run uncached instead.
        rm -f $cache.tmp
        eval $argv[3..-1] | source
    end
end
