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

function! s:exec(cmd)
    let old_ei = &ei
    set ei=all
    exec a:cmd
    let &ei = old_ei
endfunction

function! s:getWinNum(name)
    if a:name == "tree" && exists("t:NERDTreeBufName")
        return bufwinnr(t:NERDTreeBufName)
    elseif a:name == "tag"
        return bufwinnr('__Tagbar__')
    elseif a:name == "master"
        return s:isWinOpen("tree") ? 2 : 1
    endif
    return -1
endfunction

function! s:putCursorInWin(name)
    call s:exec(s:getWinNum(a:name) . "wincmd w")
endfunction

function! s:isWinOpen(name)
    return s:getWinNum(a:name) != -1
endfunction

function! s:hasSlave()
    let totalWin = winnr("$")
    if s:getWinNum("tree") != -1
        let totalWin = totalWin - 1
    endif
    if s:getWinNum("tag") != -1
        let totalWin = totalWin - 1
    endif
    return totalWin != 1
endfunction

" when stacked:
" tag
" tree
" windows (first is master)

function! s:stackAll()
    "stack up master win
    call s:putCursorInWin("tree")
    call s:exec("wincmd l")
    call s:exec('wincmd K')

    "stack up tree win
    call s:putCursorInWin("tree")
    call s:exec('wincmd K')

    if s:isWinOpen("tag")
        "stack up tag win
        call s:putCursorInWin("tag")
        call s:exec('wincmd K')
    endif

endfunction

function! s:restoreAll()
    "restore tag
    if s:isWinOpen("tag")
        call s:putCursorInWin("tag")
        call s:exec('wincmd H')
    endif

    "restore master
    call s:putCursorInWin("tree")
    call s:exec("wincmd j")
    call s:exec('wincmd H')

    "restore tree
    call s:putCursorInWin("tree")
    call s:exec('wincmd H')
endfunction

let s:tree_up_dir_line = '.. (up a dir)'

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

    let winnr = bufwinnr('^' . treenode.path.str() . '$')
    if winnr != -1
        call s:exec(winnr . "wincmd w")
        call g:EjosSetMaster()
        return
    endif

    let curLine = line(".")
    let curCol = col(".")
    let topLine = line("w0")

    call s:stackAll()

    call s:putCursorInWin("tree")
    exec "below new " . treenode.path.str({'format': 'Edit'})

    call s:restoreAll()

    let old_scrolloff=&scrolloff
    let &scrolloff=0
    call cursor(topLine, 1)
    normal! zt
    call cursor(curLine, curCol)
    let &scrolloff = old_scrolloff

    call s:putCursorInWin("tree")
    call s:exec('wincmd l')
    call g:EjosResize()
endfunction


call NERDTreeAddKeyMap({
       \ 'key': 'i',
       \ 'callback': 'NERDTreeOpenSlave',
       \ 'quickhelpText': 'cww scroll',
       \ 'scope': 'FileNode' })


function! NERDTreeOpenSlave(treenode)
    let treenode = a:treenode
    let winnr = bufwinnr('^' . treenode.path.str() . '$')
    if winnr != -1
        let master_nr = s:getWinNum("master")
        if winnr == master_nr
            return
        endif
        let top_slave = master_nr + 1
        let diffnr = winnr - top_slave
        if diffnr >= 1
            call s:exec(winnr . "wincmd w")
            call s:exec(diffnr . "wincmd ")
        endif
        call s:putCursorInWin("tree")
        call g:EjosResize()
        return
    endif

    let curLine = line(".")
    let curCol = col(".")
    let topLine = line("w0")

    call s:stackAll()

    "go to top of the most top slave. i.e tag win or master win
    call s:putCursorInWin("tree")
    call s:exec("wincmd j")
    exec "below new " . treenode.path.str({'format': 'Edit'})

    call s:restoreAll()

    let old_scrolloff=&scrolloff
    let &scrolloff=0
    call cursor(topLine, 1)
    normal! zt
    call cursor(curLine, curCol)
    let &scrolloff = old_scrolloff

    call g:EjosResize()
endfunction


function! g:EjosSetMaster()
    " check if current is not a slave
    let nr = winnr()
    if nr==s:getWinNum("master") || nr==s:getWinNum("tag") || nr == s:getWinNum("tree")
        return
    endif

    call s:putCursorInWin("master")
    call s:exec('wincmd K')

    call s:exec('wincmd p')
    call s:exec('wincmd K')
    
    if s:isWinOpen("tree")
        call s:putCursorInWin("tree")

        let curLine = line(".")
        let curCol = col(".")
        let topLine = line("w0")

        call s:exec('wincmd K')
        call s:exec("wincmd p")
    endif

    if s:isWinOpen("tag")
        call s:putCursorInWin("tag")
        call s:exec('wincmd K')
        call s:exec('wincmd H')
        call s:exec("wincmd p")
    endif

    call s:exec('wincmd H')

    if s:isWinOpen("tree")
        call s:putCursorInWin("tree")
        call s:exec('wincmd H')

        let old_scrolloff=&scrolloff
        let &scrolloff=0
        call cursor(topLine, 1)
        normal! zt
        call cursor(curLine, curCol)
        let &scrolloff = old_scrolloff

        call s:exec('wincmd p')
    endif

    call g:EjosResize()
endfunction

function! g:EjosToggleTree() 
    exec("NERDTreeToggle")
    call g:EjosResize()
endfunction

function! g:EjosToggleTagbar() 
    let master_nr = s:getWinNum("master")
    let nr = winnr()
    let inMaster = nr==#master_nr

    if s:hasSlave()
        call s:putCursorInWin("master")

        call tagbar#ToggleWindow()

        if !inMaster
            if !s:isWinOpen("tree") ||  nr != 1
                if nr > master_nr
                   "must be a slave
                   if  s:isWinOpen("tag")
                       call s:exec((nr+1) . "wincmd w")
                   else
                       call s:exec((nr-1) . "wincmd w")
                   endif
                endif
            else
                "previous in tree
                    call s:exec(1 . "wincmd w")
            endif
        endif

    else
        if !inMaster
            call s:putCursorInWin("master")
        endif
        call tagbar#ToggleWindow()
        if !inMaster
            call s:exec(1 . "wincmd w")
        endif
    endif
    call g:EjosResize()
endfunction

function! s:setSize(treeSize, masterSize, tagSize, slaveSize)
    if s:isWinOpen("tree") 
        call s:putCursorInWin("tree")
        exec("silent vertical resize ". a:treeSize)
    endif

    call s:putCursorInWin("master")
    exec("silent vertical resize ". a:masterSize)

    if s:isWinOpen("tag") 
        call s:putCursorInWin("tag")
        exec("silent vertical resize ". a:tagSize)
    endif

    if s:hasSlave() 
        call s:exec("wincmd b")
        exec("silent vertical resize ". a:slaveSize)
    endif
    
    if s:isWinOpen("tree") 
        call s:putCursorInWin("tree")
        exec("silent vertical resize ". a:treeSize)
    endif
endfunction

function! g:EjosResize()
    let nr = winnr()
    let remaining = &columns
    let twoColThres = 82
    if s:isWinOpen("tag") 
        let twoColThres = twoColThres + 30
    endif
    if s:isWinOpen("tree") 
        let twoColThres = twoColThres + 30
    endif
    if s:hasSlave()
        let twoColThres = twoColThres + 30
    endif

    if remaining < 82
        "one column windows
        exec("silent vertical resize ". remaining)
    elseif remaining < twoColThres
        "master 82 and another column 30
        call s:setSize(0, 0, 0, 0)

        let treeSize = 0
        let tagSize = 0
        let masterSize = 0
        let slaveSize = 0

        if s:isWinOpen("tag")
            if nr != s:getWinNum("tree")
                let remaining = remaining - 30
                let tagSize = 30
            else
                let tagSize = remaining - 82 - 30
                if tagSize < 0
                    let tagSize = 0
                endif
                let remaining = remaining - tagSize
            endif
        endif
        if s:isWinOpen("tree") 
            if remaining >= 112 || nr == s:getWinNum("tree")
                let treeSize = 30
                let remaining = remaining - 30
            endif
        endif
        if s:hasSlave() 
            let mainSize = remaining
            if remaining > 82
                let mainSize = 82
            endif
            if nr != s:getWinNum("tag") && nr > s:getWinNum("master")
                let masterSize = remaining - mainSize
                let slaveSize = mainSize
            else
                let slaveSize = remaining - mainSize
                let masterSize = mainSize
            endif
        else
            let masterSize = remaining
        endif

        call s:setSize(treeSize, masterSize, tagSize, slaveSize)

    else
        if s:isWinOpen("tree")
            call s:putCursorInWin("tree")
            exec("silent vertical resize ". 30)
            let remaining = remaining - 30
        endif
        if s:isWinOpen("tag")
            call s:putCursorInWin("tag")
            exec("silent vertical resize ". 30)
            let remaining = remaining - 30
        endif
        if s:hasSlave()
            let slaveWidth = 82
            if remaining < 164
                let slaveWidth = remaining - 82
            endif
            call s:exec("wincmd b")
            exec("silent vertical resize ". slaveWidth)
        endif
    endif
    call s:exec(nr . "wincmd w")
endfunction

function! g:EjosWinMove(dir)
    call s:exec("wincmd ".a:dir)
    call g:EjosResize()
endfunction
