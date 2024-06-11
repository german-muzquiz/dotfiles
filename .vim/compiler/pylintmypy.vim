
if exists("current_compiler") | finish | endif
let current_compiler = "pylint"

let pylint_config_file = expand('~') . '/.vim/compiler/.pylintrc'
let mypy_config_file = expand('~') . '/.vim/compiler/mypy.ini'

let &l:makeprg = 'python3 -m pylint --rcfile=' . pylint_config_file . ' --output-format=text --msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}" --reports=n --score=n % & python3 -m mypy --show-column-numbers --no-namespace-packages --config-file ' . mypy_config_file
"let &l:makeprg = 'python3 -m pylint --rcfile=' . pylint_config_file . ' --output-format=text --msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}" --reports=n --score=n --load-plugins pylint_pydantic,pylint_django --django-settings-module=organization_service.settings % & python3 -m mypy --show-column-numbers --no-namespace-packages --config-file ' . mypy_config_file
"let &l:makeprg = 'python3 -m pylint --rcfile=' . pylint_config_file . ' --output-format=text --msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}" --reports=n --score=n --load-plugins pylint_pydantic,pylint_django --django-settings-module=smb_service.settings % & python3 -m mypy --show-column-numbers --no-namespace-packages --config-file ' . mypy_config_file
let &l:errorformat =
    \ '%f:%l:%c:\ %t%*[^:]:\ %m,' .
    \ '%f:%l:%c:\ %t: %m,' .
    \ '%f:%l:%c:%t: %m,' .
    \ '%f:%l: %m,' .
    \ '%f:(%l): %m, ' .
    \ '%-G************* Module %.%#,' .
    \ '%-GFound %.%#,' .
    \ '%-GSuccess:%.%#'
" let &l:errorformat =
"     \ '%f:%l:%c:\ %t%*[^:]:\ %m,' .
"     \ '%f:%l:%c:\ %t: %m,' .
"     \ '%f:%l:%c:%t: %m,' .
"     \ '%f:%l: %m,' .
"     \ '%f:(%l): %m,' .
"     \ '%-G************* Module %.%#,' .
"     \ '%-GFound %.%#,' .
"     \ '%-GSuccess:%.%#,' .
"     \ '%-G%.%#Duplicate module named%.%#,' .
"     \ '%-G%.%#mapping-file-paths-to-modules%.%#,' .
"     \ '%-G%.%#--exclude%.%#,' .
"     \ '%-G%.%#'

silent CompilerSet makeprg
silent CompilerSet errorformat
