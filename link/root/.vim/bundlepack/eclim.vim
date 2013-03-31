Bundle 'ghk/ejoswin'
Bundle "eclim"
Bundle 'tpope/vim-fugitive'
Bundle 'ghk/tagbar'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'

let g:EclimProjectTreeActions = [
    \ {'pattern': '.*', 'name': 'Open Master', 'action': 'EjosOpenMaster'},
    \ {'pattern': '.*', 'name': 'Open Slave', 'action': 'EjosOpenSlave'},
  \ ]

let g:EclimLocateFileDefaultAction = "EjosOpenMaster"
let g:EclimJavaSearchSingleResult = "EjosOpenMaster"
let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
let g:SuperTabClosePreviewOnPopupClose = 1

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
map <silent> <F3> :LocateFile<CR>

map <silent> <C-\> :silent call g:EjosSetMaster()<CR>
map <silent> <C-=> :silent call g:EjosSetFirstSlave()<CR>

nmap <silent> gd :JavaSearchContext<CR>
noremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>

" generators
nmap <silent> <Leader>gi :JavaImport<CR>
nmap <silent> <Leader>gm :JavaImpl<CR>
nmap <silent> <Leader>gd :JavaDelegate<CR>

nmap <silent> <Leader>gc :JavaConstructor<CR>
vmap <silent> <Leader>gc :JavaConstructor<CR>
nmap <silent> <Leader>gg :JavaGet<CR>
vmap <silent> <Leader>gg :JavaGet<CR>
nmap <silent> <Leader>gs :JavaSet<CR>
vmap <silent> <Leader>gs :JavaSet<CR>
nmap <silent> <Leader>ga :JavaGetSet<CR>
vmap <silent> <Leader>ga :JavaGetSet<CR>

" refactor
nmap <silent> <Leader>rn :JavaRename 
nmap <silent> <Leader>rm :JavaMove 
nmap <silent> <Leader>ru :RefactorUndo<CR>
nmap <silent> <Leader>rp :RefactorUndoPeek<CR>
nmap <silent> <Leader>rr :RefactorRedo<CR>

" eclipse
nmap <silent> <Leader>ef :!eclipse %<CR><CR>

command -nargs=+ EjosOpenMaster :call g:EjosOpenMaster(<q-args>)
command -nargs=+ EjosOpenSlave :call g:EjosOpenSlave(<q-args>)

autocmd VimResized * call g:EjosResize() 
autocmd WinLeave * call g:EjosPrepareMasterLeave() 
