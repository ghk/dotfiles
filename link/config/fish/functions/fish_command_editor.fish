function fish_command_editor --description 'Edit command line in editor'
    
    set -l tmp (mktemp)
    echo (commandline) > $tmp
    vim -f $tmp
	set -l editor_status $status

	if test $editor_status = 0 
        commandline (cat $tmp)
    end

    rm $tmp

end
