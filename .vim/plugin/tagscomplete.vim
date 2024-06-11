" Custom auto completion

" :help complete-functions
function! MyCompletePython(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && (line[start - 1] =~ '\a' || line[start - 1] == '_' || line[start - 1] == '-' || line[start - 1] == '.')
            let start -= 1
        endwhile
        return start
    else
        " find classes matching a:base
        echom 'Original base: '.a:base

        let kinds_to_skip = s:get_kinds_to_skip(a:base)
        let my_base = s:adjust_base(a:base)
        echom 'Adjusted base: '.l:my_base
        let taglist = s:get_tags(l:my_base)
        "echom 'taglist: '.string(taglist)

        " Record what matches − we pass this to complete() later
        let l:res = []

        " Iterate matches
        for m in taglist
            if s:should_filter_item(m, 'Python', l:kinds_to_skip)
                continue
            endif

            " Fill information about each item (:help complete-items)
            let my_item = {
                \ 'word': s:format_word(a:base, l:my_base, l:m['name']),
                \ 'abbr': l:m['name'],
                \ 'info': s:format_info(l:m),
                \ 'kind': l:m['kind'],
                \ 'menu': s:format_menu(l:m, 'site-packages'),
                \ 'icase': 1,
                \ 'dup': 1
            \ }

            " add at the beginning entries that are not from libraries,
            " otherwise append at the end
            if stridx(l:m['filename'], 'site-packages') > 0
                call add(l:res, l:my_item)
            else
                call insert(l:res, l:my_item)
            endif
        endfor

        "echom 'res: '.string(l:res)
        return l:res
    endif
endfun

function! s:adjust_base(base)
    " if the base contains a dot, only find matches after the last dot
    if ! empty(matchstr(a:base, '\.'))
        let my_base = a:base
        while stridx(l:my_base, '.') > 0
            let my_base = l:my_base[stridx(a:base, '.') + 1:]
        endwhile
        return l:my_base
    else
        return trim(a:base)
    endif
endfunction

function! s:should_filter_item(item, language, kinds_to_skip)
    " tags include the language name, filter by the right language
    if has_key(a:item, 'language') == 0
        return v:false
    endif
    if a:item['language'] != a:language
        return v:true
    endif
    for k in a:kinds_to_skip
        echom 'checking kind '.k
        if a:item['kind'] == k
            return v:true
        endif
    endfor
    return v:false
endfun

function! s:get_kinds_to_skip(base)
    return []
endfunction

function! s:get_tags(base)
    " get results from the tags files
    let expr = '^\C'.a:base
    if a:base == ''
        let expr = '^.*$'
    endif
    echom 'taglist expr: ' . l:expr
    let taglist = taglist(expr, expand("%"))
    return l:taglist
endfunction

function! s:format_word(original_base, adjusted_base, tag_name)
    if trim(a:original_base) != trim(a:adjusted_base)
        if a:adjusted_base == ''
            let prefix = a:original_base
        else
            let prefix = a:original_base[:stridx(a:original_base, a:adjusted_base)-1]
        endif
        return l:prefix . a:tag_name
    else
        return a:tag_name
    endif
endfunction

function! s:format_info(tag)
    " remove ugly characters from tags file cmd field
    let my_cmd = trim(a:tag['cmd'], '/^$')
    let my_cmd = trim(l:my_cmd)
    if a:tag['filename'][0:len(getcwd())-1] ==# getcwd()
        let my_fn = a:tag['filename'][len(getcwd())+1:]
    else
        let my_fn = a:tag['filename']
    endif
    return l:my_cmd . "\n\nLocation: " . l:my_fn
endfunction

function! s:format_menu(tag, library_indicator)
    " if the tag belongs to a library show the library name, 
    " otherwise show the python file name
    if stridx(a:tag['filename'], a:library_indicator) > 0
        let suffix = a:tag['filename'][stridx(a:tag['filename'], a:library_indicator . '/') + len(a:library_indicator) + 1:]
        return '[' . strpart(l:suffix, 0, stridx(l:suffix, '/')) . ']'
    else
        return split(a:tag['filename'], '/')[-1]
    endif
endfunction
