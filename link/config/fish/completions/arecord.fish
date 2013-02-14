# arecord
# Autogenerated from man page /usr/share/man/man1/arecord.1.gz
# using Deroffing man parser
complete -c arecord -s h -l help --description 'Help: show syntax.'
complete -c arecord -l version --description 'Print current version.'
complete -c arecord -s l -l list-devices --description 'List all soundcards and digital audio devices.'
complete -c arecord -s L -l list-pcms --description 'List all PCMs defined.'
complete -c arecord -s D -l device --description 'Select PCM by name.'
complete -c arecord -s q -l quiet --description 'Quiet mode.  Suppress messages (not sound :)).'
complete -c arecord -s t -l file-type --description 'File type (voc, wav, raw or au).'
complete -c arecord -s c -l channels --description 'The number of channels.  The default is one channel.'
complete -c arecord -s f -l format --description 'Sample format .'
complete -c arecord -s r -l rate --description 'Sampling rate in Hertz.  The default rate is 8000 Hertz.'
complete -c arecord -s d -l duration --description 'Interrupt after # seconds.  A value of zero means infinity.'
complete -c arecord -s s -l sleep-min --description 'Min ticks to sleep.  The default is not to sleep.'
complete -c arecord -s M -l mmap --description 'Use memory-mapped (mmap) I/O mode for the audio stream.'
complete -c arecord -s N -l nonblock --description 'Open the audio device in non-blocking mode.'
complete -c arecord -s F -l period-time --description 'Distance between interrupts is # microseconds.'
complete -c arecord -s B -l buffer-time --description 'Buffer duration is # microseconds If no buffer … [See Man Page]'
complete -c arecord -l period-size --description 'Distance between interrupts is # frames If no p… [See Man Page]'
complete -c arecord -l buffer-size --description 'Buffer duration is # frames If no buffer time a… [See Man Page]'
complete -c arecord -s A -l avail-min --description 'Min available space for wakeup is # microseconds.'
complete -c arecord -s R -l start-delay --description 'Delay for automatic PCM start is # microseconds… [See Man Page]'
complete -c arecord -s T -l stop-delay --description 'Delay for automatic PCM stop is # microseconds from xrun.'
complete -c arecord -s v -l verbose --description 'Show PCM structure and setup.  This option is accumulative.'
complete -c arecord -s V -l vumeter --description 'Specifies the VU-meter type, either stereo or mono.'
complete -c arecord -s I -l separate-channels --description 'One file for each channel.'
complete -c arecord -s P --description 'Playback.'
complete -c arecord -s C --description 'Record.'
complete -c arecord -s i -l interactive --description 'Allow interactive operation via stdin.'
complete -c arecord -l disable-resample --description 'Disable automatic rate resample.'
complete -c arecord -l disable-channels --description 'Disable automatic channel conversions.'
complete -c arecord -l disable-format --description 'Disable automatic format conversions.'
complete -c arecord -l disable-softvol --description 'Disable software volume control (softvol).'
complete -c arecord -l test-position --description 'Test ring buffer position.'
complete -c arecord -l test-coef --description 'Test coefficient for ring buffer position; default is 8.'
complete -c arecord -l test-nowait --description 'Do not wait for the ring buffer--eats the whole CPU.'
complete -c arecord -l max-file-time --description 'While recording, when the output file has been … [See Man Page]'
complete -c arecord -l process-id-file --description 'aplay writes its process ID here, so other prog… [See Man Page]'
complete -c arecord -o c2 -o 'r44100]' --description '.'
complete -c arecord -o 'f44100]' --description '.'
complete -c arecord -o 'r48000]' --description '.'
complete -c arecord -l use-strftime --description 'When recording, interpret %-codes in the file n… [See Man Page]'
complete -c arecord -l 'separate-channels.' --description '.'

