# traceroute-nanog
# Autogenerated from man page /usr/share/man/man1/traceroute-nanog.1.gz
# using Deroffing man parser
complete -c traceroute-nanog -l help --description 'Print help info and exit.'
complete -c traceroute-nanog -s 4 -s 6 --description 'Explicitly force IPv4 or IPv6 tracerouting.'
complete -c traceroute-nanog -s I --description 'Use ICMP ECHO for probes.'
complete -c traceroute-nanog -s T --description 'Use TCP SYN for probes.'
complete -c traceroute-nanog -s d --description 'Enable socket level debugging (when the Linux k… [See Man Page]'
complete -c traceroute-nanog -s F --description 'Do not fragment probe packets.'
complete -c traceroute-nanog -s f --description 'Specifies with what TTL to start.  Defaults to 1.'
complete -c traceroute-nanog -s g --description 'Tells traceroute to add an IP source routing op… [See Man Page]'
complete -c traceroute-nanog -s i --description 'Specifies the interface through which  tracerou… [See Man Page]'
complete -c traceroute-nanog -s m --description 'Specifies the maximum number of hops (max time-… [See Man Page]'
complete -c traceroute-nanog -s N --description 'Specifies the number of probe packets sent out simultaneously.'
complete -c traceroute-nanog -s n --description 'Do not try to map IP addresses to host names wh… [See Man Page]'
complete -c traceroute-nanog -s p --description 'For UDP tracing, specifies the destination port… [See Man Page]'
complete -c traceroute-nanog -s t --description 'For IPv4, set the Type of Service (TOS) and Precedence value.'
complete -c traceroute-nanog -s w --description 'Set the time (in seconds) to wait for a respons… [See Man Page]'
complete -c traceroute-nanog -s q --description 'Sets the number of probe packets per hop.  The default is 3.'
complete -c traceroute-nanog -s r --description 'Bypass the normal routing tables and send direc… [See Man Page]'
complete -c traceroute-nanog -s s --description 'Chooses an alternative source address.'
complete -c traceroute-nanog -s z --description 'Minimal time interval between probes (default 0).'
complete -c traceroute-nanog -s e --description 'Show ICMP extensions (rfc4884).'
complete -c traceroute-nanog -s A --description 'Perform AS path lookups in routing registries a… [See Man Page]'
complete -c traceroute-nanog -s V --description 'Print the version and exit. br .'
complete -c traceroute-nanog -l sport --description 'Chooses the source port to use.  Implies  -N1 .'
complete -c traceroute-nanog -l fwmark --description 'Set the firewall mark for outgoing packets (sin… [See Man Page]'
complete -c traceroute-nanog -s M --description 'Use specified method for traceroute operations.'
complete -c traceroute-nanog -s O --description 'Specifies some method-specific option.'
complete -c traceroute-nanog -s U --description 'Use UDP to particular destination port for trac… [See Man Page]'
complete -c traceroute-nanog -o UL --description 'Use UDPLITE for tracerouting (default port is 53).'
complete -c traceroute-nanog -s P --description 'Use raw packet of specified protocol for tracerouting.'
complete -c traceroute-nanog -l mtu --description 'Discover MTU along the path being traced.  Implies  -F-N1 .'
complete -c traceroute-nanog -l 'mtu)' --description 'work properly since the Linux kernel 2. 6. 22 only.'
complete -c traceroute-nanog -l back --description 'Print the number of backward hops when it seems… [See Man Page]'
