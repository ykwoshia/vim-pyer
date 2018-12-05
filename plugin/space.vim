function! s:spaceLeftBracket()
    let lnum = line(".")-1
    if lnum > 0
    while getline(lnum) =~ '^\s*$'
        execute lnum.'d'
        execute 'nohlsearch'
        let lnum = line(".")-1
        if lnum < 1
            break
        endif
    endwhile
    silent! call repeat#set("\<Plug>SpaceLeftBracket", v:count)
    endif
endfunction

function! s:spaceRightBracket()
    let lnum = line(".") + 1
    while getline(lnum) =~ '^\s*$'
        execute lnum.'d'
        execute 'nohlsearch'
        let lnum = line(".")
    endwhile

    silent! call repeat#set("\<Plug>SpaceRightBracket", v:count)
endfunction

function! s:spaceMinus()
    if getline(line(".")) =~ '^\s*$'
        " execute '?\S?+1,/\S/-1d'
        " execute 'nohlsearch'
        normal dip
        silent! call repeat#set("\<Plug>SpaceMinus", v:count)
    endif
endfunction


nnoremap <silent> <Plug>SpaceLeftBracket :<C-U>call <SID>spaceLeftBracket()<CR>
nmap <Space>[ <Plug>SpaceLeftBracket

nnoremap <silent> <Plug>SpaceRightBracket :<C-U>call <SID>spaceRightBracket()<CR>
nmap <Space>] <Plug>SpaceRightBracket

nnoremap <silent> <Plug>SpaceMinus :<C-U>call <SID>spaceMinus()<CR>
nmap <Space>- <Plug>SpaceMinus





