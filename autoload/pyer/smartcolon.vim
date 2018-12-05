" auto add new line after colon


function! pyer#smartcolon#new() abort
    let s = {}

    function! s.AutosmartcolonMap()
        execute 'inoremap <silent> : <C-R>=pyer#smartcolon#insert()<CR>'
        execute 'inoremap <silent> <A-a> <C-R>=pyer#smartcolon#insert()<CR>'
    endfunction

    function! s.init()
        call self.AutosmartcolonMap()
    endfunction

    return s
endfunction

function! pyer#smartcolon#insert()
    let line = getline('.')
    let prev_char = line[col('.')-2]
    let current_char = line[col('.')-1]

    if col('.') < col('$') - 1
        return ":"
    end
    " Ignore auto close if prev character is \
    if prev_char == '\'
        return ":"
    end

    " Skip the character if current character is the same as input

    if line =~ '^\s*\(def\|if\|elif\|else\|while\|for\|try\|except\|with\)\>'
        if col('.') == col('$')
            if prev_char == ':'
                return "\<CR>"
            else
                return ":\<CR>"
            end
        else
            return "\<Right>:\<CR>"
        end
    elseif line =~ '^\s*\(class\)\>'
        if col('.') == col('$')
            if prev_char == ':'
                return "\<CR>def\<Space>__init__(self,\<Space>)\<Left>"
            else
                return ":\<CR>def\<Space>__init__(self,\<Space>)\<Left>"
            end
        else
            return "\<Right>:\<CR>def\<Space>__init__(self,\<Space>)\<Left>"
        end
    end
    

    return ":"
endfunction

let g:pyer#smartcolon#instance = pyer#smartcolon#new()
