" auto add new line after semicolon


function! pyer#smartsemicolon#new() abort
    let s = {}

    function! s.AutosmartsemicolonMap()
        " execute 'inoremap <silent> : <C-R>=pyer#smartsemicolon#insertcolon()<CR>'
        execute 'inoremap <silent> ; <C-R>=pyer#smartsemicolon#insert()<CR>'
        " execute 'inoremap <silent> <A-a> <C-R>=pyer#smartsemicolon#insert()<CR>'
    endfunction

    function! s.init()
        call self.AutosmartsemicolonMap()
    endfunction

    return s
endfunction

function! pyer#smartsemicolon#insertcolon()
    let line = getline('.')
    let prev_char = line[col('.')-2]
    let current_char = line[col('.')-1]

    if col('.') < col('$') - 1
        return ":\<CR>"
    end
    " Ignore auto close if prev character is \
    if prev_char == '\'
        return ":"
    end

    return ":"
endfunction

function! pyer#smartsemicolon#insert()
    let line = getline('.')
    let prev_char = line[col('.')-2]
    let current_char = line[col('.')-1]

    if prev_char == '\'
        return ";"
    end

    if line =~ '^\s*\(return\)\>'
        if col('.') == col('$')
            if prev_char == ';'
                return "\<Esc>"
            else
                return ";\<Esc>"
            end
        end
    end

    if line =~ '^\s*for\>('
        return "; "
    end

    " if col('.') < col('$') - 1
    if col('.') < col('$')
        return "\<Esc>A;\<CR>"
    end
    " Ignore auto close if prev character is \

    " Skip the character if current character is the same as input

    
    return ";\<CR>"
endfunction

let g:pyer#smartsemicolon#instance = pyer#smartsemicolon#new()
