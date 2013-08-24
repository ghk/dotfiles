function fish_prompt --description 'Write out the prompt'
	
    #set vi_mode i
    set stat $status
    set sep \u2b80
    set sep_thin \u2b81

    set mode_start (set_color -b blue)
    set mode_end (set_color blue)

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1|sed 's/she-wolf-mint//')
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_color_blue
        set -g __fish_color_blue (set_color -o blue)
    end

    #Set the color for the status depending on the value
    set __fish_color_status (set_color -o green)
    if test $stat -gt 0
        set __fish_color_status (set_color -o red)
    end

    switch $vi_mode
    case d
        set mode_start (set_color -b red)
        set mode_end (set_color red)
    case n
        set mode_start (set_color -b green)
        set mode_end (set_color green)
    end
        

    switch $USER

    case root

        if not set -q __fish_prompt_cwd
            if set -q fish_color_cwd_root
                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
            else
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end
        end

        printf '%s@%s %s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

    case '*'

        printf '%s %s %s%s%s' $mode_start $vi_mode (set_color -b 433) $mode_end $sep 
        printf '%s' (/home/ghk/testc/powerli $stat)
        #stty -icrnl

    end
end
