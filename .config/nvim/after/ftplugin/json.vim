
setlocal equalprg=python\ -m\ json.tool\ 2>/dev/null

" npm install -g jsonlint
let g:syntastic_json_checkers=['jsonlint']

