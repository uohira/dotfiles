"""""""""""""""""""""""""""""""""""""""
" http://inari.hatenablog.com/entry/2014/05/05/231307
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermbg=9 guibg=red
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif
"""""""""""""""""""""""""""""""""""""""

augroup vim_formatoptions
  autocmd!
  " autocmd FileType * setlocal formatoptions-=ro
  autocmd VimEnter * setlocal formatoptions-=ro
augroup END

augroup vim_filetype
  autocmd!
  autocmd BufRead,BufNewFile *.{markdown,md} set filetype=markdown
augroup END

augroup vim_pastemode
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END
