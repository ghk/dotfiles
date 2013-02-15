call NERDTreeAddKeyMap({
       \ 'key': '<c-j>',
       \ 'callback': 'NERDTreeCJ',
       \ 'quickhelpText': 'cww scroll',
       \ 'scope': 'all' })

function! NERDTreeCJ()
    wincmd j
endfunction

call NERDTreeAddKeyMap({
       \ 'key': '<c-k>',
       \ 'callback': 'NERDTreeCK',
       \ 'quickhelpText': 'cww scroll',
       \ 'scope': 'all' })

function! NERDTreeCK()
    wincmd k
endfunction
