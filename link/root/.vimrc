" Vundle --------
set nocompatible
filetype off

set shell=/bin/bash
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
set novisualbell

Bundle 'gmarik/vundle'

"Bundle 'Lokaltog/vim-powerline'
let Powerline_symbols = 'fancy'

"set rtp+=~/.local/pyenv/powerline/powerline/bindings/vim

Bundle 'sjl/gundo.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'

" syntax
Bundle 'aliva/vim-fish'

filetype plugin indent on

" Indentation ------------

set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set tabstop=4
set autoindent

set number
set showmatch

set hls "highlight search
set incsearch "incremental search

set complete-=i "remove included
set laststatus=2

set ttimeout
set ttimeoutlen=50

set showcmd 

if &history < 1000
    set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif

set display+=lastline

set autoread "auto read again file if changed

"highlight current line
set cul

"search ignore case, but if case differs use it!
set ignorecase
set smartcase

" Misc --------------

"set clipboard=unnamedplus

"column limit hint
let &colorcolumn=80


let g:solarized_termtrans=1
let g:solarized_contrast="high"
let &t_Co=256

set title
syntax on
set background=dark
let base16colorspace=256 
colorscheme solarized

if has("gui_running")
    set guifont=Consolas\ 10
    set guioptions=
else
    " command movements
    cmap h <Left>
    cmap l <Right>
    cmap b <S-Left>
    cmap w <S-Right>
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

" movement improvements
nnoremap Y y$

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-l> :wincmd l<CR>

nnoremap <silent> <C-U> :call SmoothScroll(1)<Enter>
nnoremap <silent> <C-D> :call SmoothScroll(0)<Enter>
map <silent> <F10> :call SmoothScroll(0)<Enter>
map <silent> <F11> :call SmoothScroll(1)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<nter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

set mouse=n
map <ScrollWheelUp> 2<C-Y>
map <ScrollWheelDown> 2<C-E>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Leaders
" clear search results
noremap <silent><Leader>/ :nohls<CR>
"clipboard register
noremap <silent><Leader>x "*
vnoremap <silent><Leader>x "+

" s maps for inserting single character
function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" muahahah
nmap <Space> :
vmap <Space> :
cmap w!! %!sudo tee > /dev/null %


function! g:EjosLoadPack(packname)
    exec ":source ~/.vim/bundlepack/".a:packname.".vim"
endfunction

let s:packname = "default"
if exists("g:ejos_pack")
    let s:packname = g:ejos_pack
endif
call g:EjosLoadPack(s:packname)
