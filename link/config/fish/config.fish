. ~/.config/fish/vi-mode.fish

set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
set PATH /home/ghk/.local/bin /opt/vagrant/bin /usr/local/bin $PATH

alias cl="command grc --colour=auto $ARGV"
function tmux
    set -l TERM xterm-256color; command tmux $ARGV;
end

alias ping="cl ping $ARGV"
alias traceroute="cl traceroute $ARGV"
alias make="cl make $ARGV"
alias netstat="cl netstat $ARGV"
alias gcc="cl gcc $ARGV"
alias diff="cl diff $ARGV"
alias vnotes="vim --cmd 'let g:ejos_pack=\"notes\"'"
alias vpad="vim --cmd 'let g:ejos_pack=\"pad\"'"
alias eclim="vim --cmd 'let g:ejos_pack=\"eclim\"'"
alias geclim="gvim --cmd 'let g:ejos_pack=\"eclim\"'"

alias findn="find -name $ARGV"

function vi_mode_user
    bind \co 'prevd; commandline -f repaint'
    bind \ck 'nextd; commandline -f repaint' #urvt mapped ci to ck
    #bind \ci 'nextd; commandline -f repaint'
    switch $argv[1]
        case g
        case normal
    end
end

function fish_user_key_bindings
    vi_mode_insert
end

#less color
set -x LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
set -x LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
set -x LESS_TERMCAP_me \e'[0m'           # end mode
set -x LESS_TERMCAP_se \e'[0m'           # end standout-mode
set -x LESS_TERMCAP_so \e'[38;5;246m'   # begin standout-mode - info box
set -x LESS_TERMCAP_ue \e'[0m'           # end underline
set -x LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline
