Bundle 'ghk/ejoswin'
Bundle 'ghk/tagbar'
Bundle 'kien/ctrlp.vim'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'rosenfeld/conque-term'
Bundle 'ervandew/supertab'

" Use ctrl-[hjkl] to select the active split!
nunmap <c-h>
nunmap <c-j>
nunmap <c-k>
nunmap <c-l>
nmap <silent> <c-h> :call g:EjosWinMove("h")<CR>
nmap <silent> <c-j> :call g:EjosWinMove("j")<CR>
nmap <silent> <c-k> :call g:EjosWinMove("k")<CR>
nmap <silent> <c-l> :call g:EjosWinMove("l")<CR>

map <silent> <F1> :call g:EjosToggleTree()<CR>
map <silent> <F2> :call g:EjosToggleTagbar()<CR>
map <silent> <F3> :CtrlP<CR>
map <silent> <C-\> :silent call g:EjosSetMaster()<CR>

autocmd VimResized * call g:EjosResize() 
autocmd WinLeave * call g:EjosPrepareMasterLeave() 

let g:ctrlp_open_func = { 'files': 'g:CtrlPEjosOpen' }
