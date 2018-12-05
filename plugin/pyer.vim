" Language:	VimScript
" Maintainer:	ykwoshia <ykwoshia@gmail.com>
" Last Change:  07/16/18
" Version: 0.1
" Repository: https://github.com/ykwoshia/vim-pyer
"
" Auto add spaces around operators like = + += ==

if exists('g:pyerLoaded') || &cp
  finish
end
let g:pyerLoaded = 1

let s1 = g:pyer#around#instance
call s1.init()

let s2 = g:pyer#smartcolon#instance
call s2.init()
