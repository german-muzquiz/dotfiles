
command! Tags call s:tags()


function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'No tag files'
    echohl None
    return
  endif

  let tagname = expand("<cword>")
  call s:prepare_to_update_tagstack(tagname)
  call fzf#run({
  \ 'source':  s:taglist(tagname),
  \ 'options': '--delimiter [:\t] --select-1 --no-multi --preview-window "right:50%:wrap:nohidden:+{3}-/2"',
  \ 'down':    '50%',
  \ 'sink':    function('s:sink')})
endfunction


function! s:taglist(tagname) abort  " {{{
  let taglist = taglist("^" . a:tagname . "$", expand("%"))
  return map(
  \   taglist,
  \   { _, tag -> join([tag.name, fnamemodify(tag.filename, ":~:.") . ":" . get(tag, "line"), tag.cmd], "\t") }
  \ )
endfunction  " }}}


function! s:prepare_to_update_tagstack(tagname) abort  " {{{
  let bufnr = bufnr("%")
  let item  = #{ bufnr: bufnr, from: [bufnr, line("."), col("."), 0], tagname: a:tagname }
  let winid = win_getid()

  let stack = gettagstack(winid)

  if stack.length ==# stack.curidx
    let action = "r"
    let stack.items[stack.curidx - 1] = item
  elseif stack.length > stack.curidx
    let action = "r"

    if stack.curidx > 1
      let stack.items = add(stack.items[:stack.curidx - 2], item)
    else
      let stack.items = [item]
    endif
  else
    let action = "a"
    let stack.items = [item]
  endif

  let stack.curidx += 1

  let s:tagstack_info_cache = #{ winid: winid, stack: stack, action: action }
endfunction  " }}}


function! s:sink(item) abort  " {{{
  let parts    = split(a:item, "\t")
  let filepath = split(parts[1], ":")[0]
  let excmd    = join(parts[2:-1], "")[:-2]

  call s:update_tagstack()
  execute "edit " . filepath

  try
    silent execute excmd
  catch
    let line = split(parts[1], ":")[1]
    silent execute line
  endtry

  " zv: Show cursor even if in fold.
  " zz: Adjust cursor at center of window.
  normal! zvzz
endfunction  " }}}


function s:update_tagstack() abort  " {{{
  let info = s:tagstack_info_cache
  call settagstack(info.winid, info.stack, info.action)
  unlet s:tagstack_info_cache
endfunction  " }}}
