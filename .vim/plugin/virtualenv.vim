" Activate python virtual environments automatically

command! -nargs=? VenvInstallRequirements call s:install_requirements('')
command! -nargs=? VenvCreate call s:create_venv()

let g:gervirtualenvstatus_prev_return = ''
call airline#parts#define_accent('GerVirtualEnvStatus', 'none')
call airline#parts#define_function('GerVirtualEnvStatus', 'GerVirtualEnvStatus')
let g:airline_section_x = airline#section#create(['GerVirtualEnvStatus'])

" Function to activate a virtualenv in the embedded interpreter for
" omnicomplete and other things like that.
function! VirtualEnvActivate(path)
    if exists('b:gervirtualenv_path') || exists('b:gervirtualenv_dontask')
        return
    endif

    " Create the virtualenv if it doesn't exist
    if a:path == ''
        let path = asyncrun#get_root('%') . '/.venv'
    else
        let path = a:path
    endif

    " Activate the virtualenv
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


pipe = subprocess.Popen(". %s; env" % activate_this, stdout=subprocess.PIPE, shell=True)
output = pipe.communicate()[0].decode("utf8").splitlines()

# This variable serves the purpose of compiling multi-line env variables
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
        if exists('b:gervirtualenv_path')
            unlet b:gervirtualenv_path
        endif
        echom '"' . l:path . '" is not a virtualenv!'
    endif
endfunction

function! GerVirtualEnvStatus()
    let ft = substitute(&filetype, 'filetype=', '', 'g')

    " if not a python file, do nothing
    if ft == 'python'
        if exists('b:gervirtualenv_path')
            let return_value = 'venv ' . l:ft
        else
            let return_value = 'novenv ' . l:ft 
        endif
    else
        let return_value = l:ft
    endif

    " Check if the status has changed
    if l:return_value != g:gervirtualenvstatus_prev_return
        if l:return_value == 'novenv ' . l:ft
            call airline#parts#define_accent('GerVirtualEnvStatus', 'red')
        else
            call airline#parts#define_accent('GerVirtualEnvStatus', 'none')
        endif
        let g:airline_section_x = airline#section#create(['GerVirtualEnvStatus'])
        AirlineRefresh
        let g:gervirtualenvstatus_prev_return = l:return_value
    endif
    return l:return_value
endfunction

function! s:install_requirements(root)
    if !exists('b:gervirtualenv_path')
        return
    endif
    if a:root == ''
        let workdir = asyncrun#get_root('%')
    else
        let workdir = a:root
    endif
    let requirements_file = l:workdir . '/requirements.txt'
    echo 'Installing requirements from ' . l:requirements_file
    " check if requirements.txt exists and is a file
    if getftype(l:requirements_file) != "file" || !filereadable(l:requirements_file)
        echo 'No requirements.txt found in ' . l:requirements_file
        return
    endif
    call asyncrun#run('', {'mode':'term', 'pos':'bottom', 'close': 0, 'cwd': l:workdir}, 'pip install -r ' . l:requirements_file . ' -U && pip install . && echo "Requirements installed!"')
endfunction

function! s:create_venv()
    let workdir = asyncrun#get_root('%')
    let path = asyncrun#get_root('%') . '/.venv'
    " Ask user if we should create the virtualenv
    if getftype(l:path) == "dir"
        echo "Virtualenv already exists in " . l:path
        return
    endif
    echo "Create virtualenv in " . l:path . "?"
    let options = ['1. Yes', '2. No']
    let choice = inputlist(options)
    if choice == 0 || choice == 2
        return
    endif
    let cmd = 'python3 -m venv ' . l:path . ' && ' . l:path . '/bin/pip install --upgrade pip pylint pydantic pylint_pydantic pylint-django mypy types-requests && echo "Virtualenv created!"'
    call asyncrun#run('', {'mode':'term', 'pos':'bottom', 'close': 0, 'cwd': l:workdir, 'post':'call VenvInitialize("' . l:workdir . '")'}, l:cmd)
endfunction

function! VenvInitialize(root)
    call VirtualEnvActivate('')
    call s:install_requirements(a:root)
endfunction
