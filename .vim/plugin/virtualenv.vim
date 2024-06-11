" Activate python virtual environments automatically

let g:airline_section_x = airline#section#create(['%{GerVirtualEnvStatus()}'])

" Function to activate a virtualenv in the embedded interpreter for
" omnicomplete and other things like that.
function! VirtualEnvActivate(path)
    if a:path == ''
        let path = asyncrun#get_root('%') . '/.venv'
        if getftype(l:path) != "dir"
            call s:create_venv(l:path)
        endif
    else
        let path = a:path
    endif
    let activate_this = l:path . '/bin/activate'
    if getftype(l:path) == "dir" && filereadable(activate_this)
        let b:gervirtualenv_path = l:path
        python3 << EOF
import os
import sys
import subprocess
import re
import vim

activate_this = vim.eval('l:activate_this')

def update_os_environ(line: str) -> None:
    env_var, env_val = line.split("=", 1)
    os.environ[env_var] = env_val
    #print("Updating env var: " + env_var)


#print("Python venv detected. Attempting to update environment variables...")
pipe = subprocess.Popen(". %s; env" % activate_this, stdout=subprocess.PIPE, shell=True)
output = pipe.communicate()[0].decode("utf8").splitlines()

# This variable serves purpose of compiling multi-line env variables
prev_line = None

for line in output:
    if re.match(r"^[A-Za-z_%]+=.+", line):
        if prev_line:
            update_os_environ(prev_line)

        prev_line = line
    else:
        prev_line += "\n" + line

# One last check for prev_line
if prev_line:
    update_os_environ(prev_line)
EOF
    else
        unlet b:gervirtualenv_path
        echom '"' . l:path . '" is not a virtualenv!'
    endif
endfunction

function! GerVirtualEnvStatus()
    let ft = substitute(&filetype, 'filetype=', '', 'g')
    if exists('b:gervirtualenv_path')
        return 'venv ' . l:ft
    else
        return l:ft 
    endif
endfunction

function! s:create_venv(path)
    echom 'Creating virtualenv on path "' . a:path . '"...'
    execute 'silent !echo "Creating virtual env on path ' . a:path . '"'
    execute 'silent !python3 -m venv ' . a:path
    execute 'silent !' . a:path . '/bin/pip install --upgrade pip'
    execute 'silent !' . a:path . '/bin/pip install pylint'
    execute 'silent !' . a:path . '/bin/pip install pydantic'
    execute 'silent !' . a:path . '/bin/pip install pylint_pydantic'
    execute 'silent !' . a:path . '/bin/pip install pylint-django'
    execute 'silent !' . a:path . '/bin/pip install mypy'
    execute 'silent !' . a:path . '/bin/python3 -m pip install types-requests'
    execute 'redraw!'
endfunction

