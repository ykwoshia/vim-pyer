" Auto add spaces around operators like = + += ==


function! pyer#around#new() abort
    let s = {}

    if !exists('g:pyer#around')
      let g:pyer#around = {'=':' ', '+':' '}
    end

    function! s.AutoAroundMap(key)
        execute 'inoremap <silent> '.a:key.' <C-R>=pyer#around#insert("\'.a:key.'")<CR>'
    endfunction

    function! s.init()
      for [open, close] in items(g:pyer#around)
        call self.AutoAroundMap(open)
        " if open != close
          " call self.AutoAroundMap(close)
        " end
      endfor

    endfunction

    return s
endfunction

function! pyer#around#insert(key)
    let line = getline('.')
    let prev_char = line[col('.')-2]
    let pprev_char = line[col('.')-3]
    let current_char = line[col('.')-1]

    " Ignore auto close if prev character is \
    if prev_char == '\'
        return a:key
    end

    if prev_char == '!'
        return a:key
    end

    if prev_char == '/'
        return a:key
    end

    if prev_char == '*'
        return a:key
    end

    if prev_char == '+'
        return a:key
    end

    if prev_char == '-'
        return a:key
    end

    if current_char == "'"
        return a:key
    end

    if current_char == '"'
        return a:key
    end

    " Skip the character if current character is the same as input
    if current_char == a:key
        return "\<Right>"
    end

    " Input directly if the key is not an open key
    if !has_key(g:pyer#around, a:key)
        return a:key
    end

    let open = a:key
    let close = g:pyer#around[open]


    " Auto return only if open and close is same
    if prev_char == ' ' 
        if has_key(g:pyer#around, pprev_char)
            return "\<BS>".open.' '
        else
            return open.' '
        end
    end

    if has_key(g:pyer#around, prev_char)
        return open.' '
    else
        return ' '.open.' '
    end
endfunction

let g:pyer#around#instance = pyer#around#new()
