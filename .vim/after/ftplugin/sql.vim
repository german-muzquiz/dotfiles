function! SqlRunInEnv()
    :Dotenv ~/code/.env

    let ph = winheight(0) / 2
    execute "setlocal previewheight=" . ph

    echo "Choose database environment: "
    let options = ['1. local', '2. dev', '3. prod']
    let choice = inputlist(options)

    if choice == 0
        return
    endif
    " return the connection string name with the option selected
    let connstring = "$DB_CONN_STRING_" . split(options[choice - 1])[1]
    " execute the DB command with the connection string
    execute "%DB " . connstring
    ":%DB connstring
endfunction

nnoremap <buffer> <leader>rf :call SqlRunInEnv()<cr>
