# git-diff
# Autogenerated from man page /usr/share/man/man1/git-diff.1.gz
# using Deroffing man parser
complete -c git-diff -s p -s u -l patch --description 'Generate patch (see section on generating patches).'
complete -c git-diff -o 'U<n>' -l unified --description 'Generate diffs with <n> lines of context instea… [See Man Page]'
complete -c git-diff -l raw --description 'Generate the raw format.'
complete -c git-diff -l patch-with-raw --description 'Synonym for -p --raw.'
complete -c git-diff -l minimal --description 'Spend extra time to make sure the smallest poss… [See Man Page]'
complete -c git-diff -l patience --description 'Generate a diff using the "patience diff" algorithm.'
complete -c git-diff -l histogram --description 'Generate a diff using the "histogram diff" algorithm.'
complete -c git-diff -l 'stat[' --description 'Generate a diffstat.'
complete -c git-diff -l numstat --description 'Similar to --stat, but shows number of added an… [See Man Page]'
complete -c git-diff -l shortstat --description 'Output only the last line of the --stat format … [See Man Page]'
complete -c git-diff -l summary --description 'Output a condensed summary of extended header i… [See Man Page]'
complete -c git-diff -l patch-with-stat --description 'Synonym for -p --stat.'
complete -c git-diff -s z --description 'When --raw, --numstat, --name-only or --name-st… [See Man Page]'
complete -c git-diff -l name-only --description 'Show only names of changed files.'
complete -c git-diff -l name-status --description 'Show only names and status of changed files.'
complete -c git-diff -l 'submodule[' --description 'Specify how differences in submodules are shown.'
complete -c git-diff -l 'color[' --description 'Show colored diff.'
complete -c git-diff -l no-color --description 'Turn off colored diff.'
complete -c git-diff -l word-diff-regex --description 'Use <regex> to decide what a word is, instead o… [See Man Page]'
complete -c git-diff -l 'color-words[' --description 'Equivalent to --word-diff=color plus (if a rege… [See Man Page]'
complete -c git-diff -l no-renames --description 'Turn off rename detection, even when the config… [See Man Page]'
complete -c git-diff -l check --description 'Warn if changes introduce whitespace errors.'
complete -c git-diff -l full-index --description 'Instead of the first handful of characters, sho… [See Man Page]'
complete -c git-diff -l binary --description 'In addition to --full-index, output a binary di… [See Man Page]'
complete -c git-diff -l 'abbrev[' --description 'Instead of showing the full 40-byte hexadecimal… [See Man Page]'
complete -c git-diff -o 'B[<n>][/<m>]' -l 'break-rewrites[' --description 'Break complete rewrite changes into pairs of delete and create.'
complete -c git-diff -o 'M[<n>]' -l 'find-renames[' --description 'Detect renames.'
complete -c git-diff -o 'C[<n>]' -l 'find-copies[' --description 'Detect copies as well as renames.'
complete -c git-diff -l find-copies-harder --description 'For performance reasons, by default, -C option … [See Man Page]'
complete -c git-diff -s D -l irreversible-delete --description 'Omit the preimage for deletes, i. e.'
complete -c git-diff -o 'l<num>' --description 'The -M and -C options require O(n^2) processing… [See Man Page]'
complete -c git-diff -l diff-filter --description 'Select only files that are Added (A), Copied (C… [See Man Page]'
complete -c git-diff -o 'S<string>' --description 'Look for differences that introduce or remove a… [See Man Page]'
complete -c git-diff -o 'G<regex>' --description 'Look for differences whose added or removed lin… [See Man Page]'
complete -c git-diff -l pickaxe-all --description 'When -S or -G finds a change, show all the chan… [See Man Page]'
complete -c git-diff -l pickaxe-regex --description 'Make the <string> not a plain string but an ext… [See Man Page]'
complete -c git-diff -o 'O<orderfile>' --description 'Output the patch in the order specified in the … [See Man Page]'
complete -c git-diff -s R --description 'Swap two inputs; that is, show differences from… [See Man Page]'
complete -c git-diff -l 'relative[' --description 'When run from a subdirectory of the project, it… [See Man Page]'
complete -c git-diff -s a -l text --description 'Treat all files as text.'
complete -c git-diff -l ignore-space-at-eol --description 'Ignore changes in whitespace at EOL.'
complete -c git-diff -s b -l ignore-space-change --description 'Ignore changes in amount of whitespace.'
complete -c git-diff -s w -l ignore-all-space --description 'Ignore whitespace when comparing lines.'
complete -c git-diff -l inter-hunk-context --description 'Show the context between diff hunks, up to the … [See Man Page]'
complete -c git-diff -s W -l function-context --description 'Show whole surrounding functions of changes.'
complete -c git-diff -l exit-code --description 'Make the program exit with codes similar to diff(1).'
complete -c git-diff -l quiet --description 'Disable all output of the program.  Implies --exit-code.'
complete -c git-diff -l ext-diff --description 'Allow an external diff helper to be executed.'
complete -c git-diff -l no-ext-diff --description 'Disallow external diff drivers.'
complete -c git-diff -l textconv -l no-textconv --description 'Allow (or disallow) external text conversion fi… [See Man Page]'
complete -c git-diff -l 'ignore-submodules[' --description 'Ignore changes to submodules in the diff generation.'
complete -c git-diff -l src-prefix --description 'Show the given source prefix instead of "a/".'
complete -c git-diff -l dst-prefix --description 'Show the given destination prefix instead of "b/".'
complete -c git-diff -l no-prefix --description 'Do not show any source or destination prefix.'
complete -c git-diff -o 'p.' --description '.'
complete -c git-diff -l 'raw.' --description '.'
complete -c git-diff -l stat-graph-width --description '(affects all commands generating a stat graph) … [See Man Page]'
complete -c git-diff -l stat-width --description '.'
complete -c git-diff -l stat-name-width --description 'and.'
complete -c git-diff -l stat-count --description '.'
complete -c git-diff -l stat --description '.'
complete -c git-diff -l 'dirstat[' --description '.'
complete -c git-diff -l dirstat --description 'can be customized by passing it a comma separat… [See Man Page]'
complete -c git-diff -l '*stat' --description 'options.  files.'
complete -c git-diff -l 'stat.' --description '.'
complete -c git-diff -l submodule --description 'or.'
complete -c git-diff -l color --description '.'
complete -c git-diff -l 'word-diff[' --description '.'
complete -c git-diff -l 'color.' --description 'plain.'
complete -c git-diff -l word-diff --description 'unless it was already enabled.'
complete -c git-diff -l abbrev --description '.'
complete -c git-diff -o 'B/70%' --description 'specifies that less than 30% of the original sh… [See Man Page]'
complete -c git-diff -o 'B20%' --description 'specifies that a change with addition and delet… [See Man Page]'
complete -c git-diff -o 'M90%' --description 'means git should consider a delete/add pair to … [See Man Page]'
complete -c git-diff -l 'find-copies-harder.' --description 'n is specified, it has the same meaning as for.'
complete -c git-diff -o 'M<n>.' --description '.'
complete -c git-diff -s C --description 'option finds copies only if the original file o… [See Man Page]'
complete -c git-diff -s B --description '.'
complete -c git-diff -s M --description 'and.'
complete -c git-diff -s S --description 'or.'
complete -c git-diff -s G --description 'finds a change, show all the changes in that ch… [See Man Page]'
complete -c git-diff -l 'exit-code.' --description '.'
complete -c git-diff -l - --description '+++ b/describe.'
complete -c git-diff -s c --description 'option is used): diff --combined file or like this (when.'
complete -c git-diff -l cc --description 'option is used): diff --cc file  2. c   2.  4. 2.'

