function! g:EjosGetTreeName()
    if exists("t:NERDTreeBufName")
        return t:NERDTreeBufName
    endif
    return -1
endfunction
let s:tree_up_dir_line = '.. (up a dir)'

"NERD TREE

call NERDTreeAddKeyMap({
       \ 'key': '<c-j>',
       \ 'callback': 'NERDTreeCJ',
       \ 'quickhelpText': 'cww scroll',
       \ 'scope': 'all' })

function! NERDTreeCJ()
    wincmd j
    "call g:EjosWinMove("k")
endfunction

call NERDTreeAddKeyMap({
       \ 'key': '<c-k>',
       \ 'callback': 'NERDTreeCK',
       \ 'quickhelpText': 'cww scroll',
       \ 'scope': 'all' })

function! NERDTreeCK()
    wincmd k
    "call g:EjosWinMove("k")
endfunction

call NERDTreeAddKeyMap({
       \ 'key': 'o',
       \ 'callback': 'NERDTreeOpenMaster',
       \ 'quickhelpText': 'cww scroll',
       \ 'scope': 'FileNode' })

function! NERDTreeOpenMaster(treenode)
    if getline(".") ==# s:tree_up_dir_line
        call g:NERDTreeUpDir(0)
        return
    endif

    let treenode = a:treenode
    if treenode == {} || isdirectory(treenode.path.str())
        call treenode.activate(0)
        return
    endif

    call s:openMaster(treenode.path.str())

endfunction

call NERDTreeAddKeyMap({
       \ 'key': 'i',
       \ 'callback': 'NERDTreeOpenSlave',
       \ 'quickhelpText': 'cww scroll',
       \ 'scope': 'FileNode' })


function! NERDTreeOpenSlave(treenode)
    let treenode = a:treenode
    call s:openSlave(treenode.path.str())
endfunction


"CtrlP
"
function! g:CtrlPEjosOpen(action, line)
    if a:action == "e"
        call ctrlp#exit()
        call s:openMaster(a:line)
    else
        call call('ctrlp#acceptfile', [a:action, a:line])
    endif
endfunction

function! g:EjosToggleTree() 
    exec("NERDTreeToggle")
    call g:EjosResize()
endfunction
