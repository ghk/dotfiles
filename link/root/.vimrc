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
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

map <C-n> :NERDTreeToggle<CR>

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

nnoremap <C-U> :call SmoothScroll(1)<Enter>
nnoremap <C-D> :call SmoothScroll(0)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

set mouse=n
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
