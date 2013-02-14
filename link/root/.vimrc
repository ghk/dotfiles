set number
set expandtab
set tabstop=4
set shiftwidth=4
set tabstop=4
set autoindent
set clipboard=unnamedplus

filetype plugin indent on

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
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
