# hp-scan
# Autogenerated from man page /usr/share/man/man1/hp-scan.1.gz
# using Deroffing man parser
complete -c hp-scan -o 'd<device-uri>' -l device --description 'To specify a CUPS printer:.'
complete -c hp-scan -o 'p<printer>' -l printer --description 'MODE Run in interactive mode:.'
complete -c hp-scan -s i -l interactive --description 'OPTIONS Set the logging level:.'
complete -c hp-scan -o 'l<level>' -l logging --description '<level>: none, info*, error, warn, debug (*defa… [See Man Page]'
complete -c hp-scan -s g -o 'ldebug)' --description 'This help information:.'
complete -c hp-scan -s h -l help --description 'OPTIONS (GENERAL) Scan destinations:.'
complete -c hp-scan -o 's<dest_list>' -l dest --description 'where <dest_list> is a comma separated list con… [See Man Page]'
complete -c hp-scan -o 'm<mode>' -l mode --description 'Scanning resolution:.'
complete -c hp-scan -o 'r<resolution_in_dpi>' -l res -l resolution --description 'where 300 is default.  Image resize:.'
complete -c hp-scan -l resize --description 'Image contrast:.'
complete -c hp-scan -l contrast --description 'ADF mode:.'
complete -c hp-scan -l adf --description 'OPTIONS (SCAN AREA) Specify the units for area/… [See Man Page]'
complete -c hp-scan -o 't<units>' -l units --description 'where <units> is \'mm\'*, \'cm\', \'in\', \'px\', or \'p… [See Man Page]'
complete -c hp-scan -o 'a<tlx>' -l area --description 'Coordinates are relative to the upper left corn… [See Man Page]'
complete -c hp-scan -l box --description 'tlx and tly coordinates are relative to the upp… [See Man Page]'
complete -c hp-scan -l tlx --description 'Coordinates are relative to the upper left corn… [See Man Page]'
complete -c hp-scan -l tly --description 'Coordinates are relative to the upper left corn… [See Man Page]'
complete -c hp-scan -l brx --description 'Coordinates are relative to the upper left corn… [See Man Page]'
complete -c hp-scan -l bry --description 'Coordinates are relative to the upper left corn… [See Man Page]'
complete -c hp-scan -l size --description 'where <paper size name> is one of: 5x7, photo, … [See Man Page]'
complete -c hp-scan -o 'o<file>' -o 'f<file>' -l file -l output --description 'OPTIONS (\'PDF\' DEST) PDF viewer application:.'
complete -c hp-scan -l pdf --description 'OPTIONS (\'VIEWER\' DEST) Image viewer application:.'
complete -c hp-scan -o 'v<viewer>' -l viewer --description 'OPTIONS (\'EDITOR\' DEST) Image editor application:.'
complete -c hp-scan -o 'e<editor>' -l editor --description 'OPTIONS (\'EMAIL\' DEST) From: address for \'email\' dest:.'
complete -c hp-scan -l email-from --description 'To: address for \'email\' dest:.'
complete -c hp-scan -l email-to --description 'Email subject for \'email\' dest:.'
complete -c hp-scan -l email-subject -l subject --description 'Use double quotes (") around the subject if it … [See Man Page]'
complete -c hp-scan -l email-msg -l email-note --description 'Use double quotes (") around the note/message i… [See Man Page]'
complete -c hp-scan -o 'x<mode>' -l compression --description 'SEE ALSO AUTHOR HPLIP (Hewlett-Packard Linux Im… [See Man Page]'

