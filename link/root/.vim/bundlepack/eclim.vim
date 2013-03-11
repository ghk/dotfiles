Bundle 'ghk/ejoswin'
Bundle "eclim"
Bundle 'tpope/vim-fugitive'
Bundle 'ghk/tagbar'
Bundle 'ervandew/supertab'

function! g:EjosToggleTree() 
    exec("ProjectTreeToggle")
    call g:EjosResize()
endfunction

function! s:GetTreeTitle() 
  " support a custom name from an external plugin
  if exists('t:project_tree_name')
    return t:project_tree_name
  endif

  if !exists('t:project_tree_id')
    let t:project_tree_id = s:project_tree_ids + 1
    let s:project_tree_ids += 1
  endif
  return g:EclimProjectTreeTitle . t:project_tree_id
endfunction " }}}

function! g:EjosGetTreeName()
  let title = s:GetTreeTitle()
  let bufnum = bufnr(title)
  let winnum = bufwinnr(title)
  if bufnum == -1 || winnum == -1
      return -1
  else
      return title
  endif
endfunction

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

nmap <silent> gd :JavaSearchContext<CR>

command -nargs=+ EjosOpenMaster :call g:EjosOpenMaster(<q-args>)
command -nargs=+ EjosOpenSlave :call g:EjosOpenSlave(<q-args>)
