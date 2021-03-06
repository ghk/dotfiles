# split
# Autogenerated from man page /usr/share/man/man1/split.1.gz
# using Deroffing man parser
complete -c split -s a -l suffix-length --description 'use suffixes of length N (default 2).'
complete -c split -s b -l bytes --description 'put SIZE bytes per output file.'
complete -c split -s C -l line-bytes --description 'put at most SIZE bytes of lines per output file.'
complete -c split -s d -l numeric-suffixes --description 'use numeric suffixes instead of alphabetic.'
complete -c split -s e -l elide-empty-files --description 'do not generate empty output files with `-n\'.'
complete -c split -l filter --description 'write to shell COMMAND; file name is $FILE.'
complete -c split -s l -l lines --description 'put NUMBER lines per output file.'
complete -c split -s n -l number --description 'generate CHUNKS output files.   See below.'
complete -c split -s u -l unbuffered --description 'immediately copy input to output with `-n r/. \'.'
complete -c split -l verbose --description 'print a diagnostic just before each output file is opened.'
complete -c split -l help --description 'display this help and exit.'
complete -c split -l version --description 'output version information and exit.'

