" Vundle --------
set nocompatible
filetype off

set shell=/bin/bash
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
set novisualbell

Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-powerline'
let Powerline_symbols = 'unicode'
set laststatus=2

Bundle 'sjl/gundo.vim'

" syntax
Bundle 'aliva/vim-fish'


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
let &colorcolumn=80


let g:solarized_termtrans=1
let g:solarized_contrast="high"
let &t_Co=256

set title
syntax on
set background=dark
colorscheme solarized

if has("gui_running")
    set guifont=Consolas\ 10
    set guioptions=
else
endif

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

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-l> :wincmd l<CR>

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

function! g:EjosLoadPack(packname)
    exec ":source ~/.vim/bundlepack/".a:packname.".vim"
endfunction

let s:packname = "default"
if exists("g:ejos_pack")
    let s:packname = g:ejos_pack
endif
call g:EjosLoadPack(s:packname)
