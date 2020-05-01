" auto add new line after op


function! pyer#smartop#new() abort
    let s = {}

    function! s.AutosmartopMap()
        execute 'inoremap <silent> , <C-R>=pyer#smartop#insertcomma()<CR>'
        let s1 = g:pyer#smartcolon#instance
        call s1.init()
        let s2 = g:pyer#smartsemicolon#instance
        call s2.init()
        " execute 'inoremap <silent> : <C-R>=pyer#smartop#insertcolon()<CR>'
        " execute 'inoremap <silent> ; <C-R>=pyer#smartop#insertsemicolon()<CR>'
    endfunction

    function! s.init()
        call self.AutosmartopMap()
    endfunction

    return s
endfunction

function! pyer#smartop#insertcolon()
    let line = getline('.')
    let prev_char = line[col('.')-2]
    let current_char = line[col('.')-1]

    " Ignore auto close if prev character is \
    if prev_char == '\'
        return ":"
    end

    if line =~ '^\s*\(case\|default\)\>'
        if col('.') < col('$') - 1
            return "\<Esc>A:\<CR>"
        else
            return ":\<CR>"
        end
    endif

    if line =~ '^\s*\w\+\>\s*$'
        if col('.') < col('$') - 1
            return "\<Esc>A:\<CR>"
        end
    endif

    return ":"
endfunction

function! pyer#smartop#insertsemicolon()
    let line = getline('.')
    let prev_char = line[col('.')-2]
    let current_char = line[col('.')-1]
    let last_char = line[col('$')-2]

    if prev_char == '\'
        return ";"
    end

    if last_char == '}'
        return ";"
    end

    if line =~ '^\s*for\>('
        return "; "
    end

    if col('.') > col('$')-2
        if col('.') == col('$')
            if prev_char == ';'
                return "\<Esc>"
            else
                return ";\<Esc>"
            end
        else
            return "\<Esc>A;\<Esc>"
        end
    else
        return "\<Esc>A;\<Esc>"
    end
    
    return ";"
endfunction

function! pyer#smartop#insertcomma()
    let line = getline('.')
    " let prev_char = line[col('.')-2]
    " let current_char = line[col('.')-1]

    if line =~ '('
        return ", "
    end
    
    return ","
endfunction

let g:pyer#smartop#instance = pyer#smartop#new()
