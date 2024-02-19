if set -q KITTY_WINDOW_ID
  function rg --wraps rg
    kitty +kitten hyperlinked_grep $argv
  end
end
