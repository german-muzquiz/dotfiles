
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
setlocal tags=./tags;

" Highlight bad whitespaces
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let python_highlight_all=1

"let g:syntastic_python_checkers=['flake8']
":lopen to open the list of errors
"let g:syntastic_auto_loc_list = 2  

"Run current file
nnoremap <leader>r :!python3 %:p 

"Comment lines
nnoremap <leader>c :norm I #<Enter>

