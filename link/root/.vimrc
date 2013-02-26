" Vundle --------
set nocompatible
filetype off

set shell=/bin/bash
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline'
Bundle 'majutsushi/tagbar'
Bundle 'kien/ctrlp.vim'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'rosenfeld/conque-term'

filetype plugin indent on

" Indentation ------------

set number
set expandtab
set tabstop=4
set shiftwidth=4
set tabstop=4
set autoindent

" Misc --------------

set clipboard=unnamedplus

"column limit hint
let &colorcolumn="80,".join(range(120,999),",")


let g:solarized_termtrans=1
let g:solarized_contrast="high"
let &t_Co=256

set title
syntax on
set background=dark
colorscheme solarized

if has("gui_running")
    set guifont=Consolas\ 10
    set guioptions-=m
    set guioptions-=T
endif

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-h> :call g:EjosWinMove("h")<CR>
nmap <silent> <c-j> :call g:EjosWinMove("j")<CR>
nmap <silent> <c-k> :call g:EjosWinMove("k")<CR>
nmap <silent> <c-l> :call g:EjosWinMove("l")<CR>

map <silent> <F1> :call g:EjosToggleTree()<CR>
map <silent> <F2> :call g:EjosToggleTagbar()<CR>
map <silent> <C-\> :silent call g:EjosSetMaster()<CR>

function SmoothScroll(up)
    if a:up
        let scrollaction=""
    else
        let scrollaction=""
    endif
    exec "normal " . scrollaction
    redraw
    let counter=1
    while counter<&scroll
        let counter+=1
        sleep 10m
        redraw
        exec "normal " . scrollaction
    endwhile
endfunction

nnoremap <silent> <C-U> :call SmoothScroll(1)<Enter>
nnoremap <silent> <C-D> :call SmoothScroll(0)<Enter>
map <silent> <F10> :call SmoothScroll(0)<Enter>
map <silent> <F11> :call SmoothScroll(1)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

set mouse=n
map <ScrollWheelUp> 2<C-Y>
map <ScrollWheelDown> 2<C-E>

" muahahah
nmap <Space> :

autocmd VimResized * call g:EjosResize() 
