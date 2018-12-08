setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
autocmd FileType go autocmd BufWritePre <buffer> Fmt
