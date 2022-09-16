
setl noexpandtab
setl tabstop=4
setl shiftwidth=4
setl colorcolumn=80

" 开启注释排版
setl formatoptions=Bmcroql

if has_key(g:plugs, 'coc.nvim')
  "autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
  "autocmd BufWritePre *.go :silent call CocAction('format')

endif
