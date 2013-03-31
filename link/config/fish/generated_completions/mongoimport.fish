# mongoimport
# Autogenerated from man page /usr/share/man/man1/mongoimport.1.gz
# using Deroffing man parser
complete -c mongoimport -l help --description 'show usage information.'
complete -c mongoimport -s h -l host --description 'server to connect to (default HOST=localhost).'
complete -c mongoimport -s d -l db --description 'database to use.'
complete -c mongoimport -s c -l c --description 'collection to use (some commands).'
complete -c mongoimport -l dbpath --description 'directly access mongod data files in this path,… [See Man Page]'
complete -c mongoimport -s v -l verbose --description 'be more verbose (include multiple times for more verbosity e.'
complete -c mongoimport -s f -l fields --description 'comma separated list of field names e. g.  -f name,age.'
complete -c mongoimport -l fieldFile --description 'file with fields names - 1 per line.'
complete -c mongoimport -l jsonArray --description 'load a json array, not one item per line.'
complete -c mongoimport -l ignoreBlanks --description 'if given, empty fields in csv and tsv will be ignored.'
complete -c mongoimport -l type --description 'type of file to import.   default: json (json,csv,tsv).'
complete -c mongoimport -l file --description 'file to import from; if not specified stdin is used.'
complete -c mongoimport -l drop --description 'drop collection first.'
complete -c mongoimport -l headerline --description 'CSV,TSV only - use first line as headers COPYRIGHT.'
