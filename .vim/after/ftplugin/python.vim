setlocal completeopt=popup,menuone,noinsert,noselect
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal tags+=$HOME/.cache/vim/ctags/python-libs-tags

compiler pylint

function! MyGenerateTags()
    echom 'Generating ctags for python libraries in sys.path'
py3 <<EOF
import os
import vim
import sys 
vim.command("let pypath = '%s'" % (' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d))))
EOF
    let cmd = 'ctags -R --fields=+ailmnS --languages=python --python-kinds=-v -f '. expand('~/.cache/vim/ctags/python-libs-tags') . ' ' . pypath
    execute '!'.cmd
endfunction
