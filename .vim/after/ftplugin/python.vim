setlocal completeopt=popup,menuone,noinsert,noselect,preview
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal tags+=$HOME/.cache/vim/ctags/python-libs-tags
setlocal completefunc=MyCompletePython
setlocal textwidth=120 "used to get autoformat respect width defined in pylint

compiler pylintmypy

autocmd BufEnter <buffer> call VirtualEnvActivate('')

function! RunPythonFile(filename)
    echom a:filename
    " extract the base name of the file
    let base = fnamemodify(a:filename, ':t:r')
    " if the file name starts with 'test', execute pytest
    if match(base, '^test') == 0
        call asyncrun#run('', {'mode':'term', 'pos':'bottom', 'close': 0}, 'pytest -ra -v --tb=short --show-capture=log -vv '.a:filename)
    else
        call asyncrun#run('', {'mode':'term', 'pos':'bottom', 'close': 0}, 'python '.a:filename)
    endif
endfunction

" Mapping for running the current file
nnoremap <leader>r :call RunPythonFile(expand('%'))<cr>
