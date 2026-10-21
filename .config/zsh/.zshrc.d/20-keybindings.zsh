# Vi mode, brought up to what fish's vi bindings actually do. zsh's stock viins
# keymap is a good deal further from fish than it looks: ^K, ^P, ^N and ^Y are
# all `self-insert`, so they type a control character into the line, and ^U, ^W
# and backspace all refuse to act on text typed before you entered insert mode.
#
# Every binding below was read out of `fish -c 'fish_vi_key_bindings; bind'`
# rather than guessed, so the comments name fish's widget where the zsh one is
# spelled differently.

bindkey -v

# Hundredths of a second, so 3 == the 30ms fish_escape_delay_ms defaults to.
# zsh ships 40 (400ms), which is what makes ESC feel broken in vi mode. Not the
# 1 that most guides suggest: at 10ms there is no margin for a multi-byte
# escape sequence that arrives split, and an arrow key degrades into a literal
# `[A` on the line.
KEYTIMEOUT=3

# fish binds ^W to backward-kill-path-component, which zsh has no widget for.
# Dropping `/` from WORDCHARS gets the same result out of backward-kill-word:
# `foo-bar.baz` stays one word, `a/b` is two. This is the stock list minus `/`.
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# zsh's vi-kill-line / vi-backward-kill-word / vi-backward-delete-char all stop
# at the point where insert mode began; fish's equivalents do not, so the
# non-vi widgets are the faithful port.
autoload -Uz edit-command-line
zle -N edit-command-line

# BOTH keymaps, not just viins. In `fish -c 'fish_vi_key_bindings; bind'` these
# print with no `-M`, which means fish's default (vi normal) mode as well as
# insert -- so in fish they keep working after you press escape. Binding them
# in viins alone made every one of them a silent no-op in normal mode, which is
# the largest single gap from the parity this file claims.
() {
  local km
  for km in viins vicmd; do
    bindkey -M $km '^U' backward-kill-line     # fish: ctrl-u backward-kill-line
    bindkey -M $km '^K' kill-line              # fish: ctrl-k kill-line
    bindkey -M $km '^W' backward-kill-word     # fish: ctrl-w backward-kill-path-component
    bindkey -M $km '^Y' yank                   # fish: ctrl-y yank
    bindkey -M $km '\ey' yank-pop              # fish: alt-y yank-pop
    bindkey -M $km '\ed' kill-word             # fish: alt-d kill-word
    bindkey -M $km '\eb' backward-word         # fish: alt-b prevd-or-backward-word
    bindkey -M $km '\ef' forward-word          # fish: alt-f nextd-or-forward-word
    bindkey -M $km '\e.' insert-last-word      # fish: alt-. history-token-search-backward
    bindkey -M $km '\ee' edit-command-line     # fish: alt-e edit_command_buffer
    bindkey -M $km '\ev' edit-command-line     # fish: alt-v edit_command_buffer

    # fish: ctrl-d delete-or-exit. zsh handles the exit half itself -- EOF on an
    # empty buffer ends the shell whatever ^D is bound to -- so this only needs
    # to supply the delete half.
    bindkey -M $km '^D' delete-char-or-list

    # fish leaves these inert in insert mode; in zsh they would self-insert a
    # control character, and doing nothing is not one of the options. Deliberate
    # non-parity, applied to both modes for consistency. vicmd `v` is left alone
    # -- it is visual mode in both shells.
    bindkey -M $km '^A' beginning-of-line
    bindkey -M $km '^E' end-of-line
  done
}

# Insert-mode only: there is no text being inserted to delete in normal mode.
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

# fish: up/down are up-or-search, i.e. prefix search when the line has text.
# *-beginning-search, not zsh's up-line-or-search: the latter searches on the
# first word of the buffer, these search on everything left of the cursor,
# which is what fish does.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# config.fish:7-8 put the same thing on ctrl-p / ctrl-n in insert mode.
bindkey -M viins '^P' up-line-or-beginning-search
bindkey -M viins '^N' down-line-or-beginning-search
bindkey -M vicmd 'k'  up-line-or-beginning-search
bindkey -M vicmd 'j'  down-line-or-beginning-search

# /etc/zshrc:63-67 bound these into `main` while it was still the emacs keymap;
# `bindkey -v` above replaced main with viins and took them with it. Both the
# terminfo code and the two literal forms are bound, because terminfo reports
# the application-mode sequence and the terminal may send the normal-mode one.
() {
  local -A _nav=(
    up-line-or-beginning-search   "$terminfo[kcuu1]|^[[A|^[OA"
    down-line-or-beginning-search "$terminfo[kcud1]|^[[B|^[OB"
    beginning-of-line             "$terminfo[khome]|^[[H|^[[1~"
    end-of-line                   "$terminfo[kend]|^[[F|^[[4~"
    delete-char                   "$terminfo[kdch1]|^[[3~"
  )
  local widget seq
  for widget in ${(k)_nav}; do
    for seq in ${(s:|:)_nav[$widget]}; do
      [[ -n $seq ]] || continue
      bindkey -M viins "$seq" $widget
      bindkey -M vicmd "$seq" $widget
    done
  done
}

# ^S is XOFF by default and freezes the terminal until ^Q -- a footgun with no
# upside here, since nothing binds it. fish has never been exposed to it
# because it puts the terminal in raw mode. Guarded because .zshrc is also read
# by shells with no controlling terminal.
[[ -t 0 ]] && stty -ixon 2>/dev/null
