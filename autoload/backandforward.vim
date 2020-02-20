scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim


function! backandforward#nextBuffer(count) abort
  let cmd = backandforward#nextBufferCommand(a:count)

  if cmd != ''
    execute 'normal!' cmd
  endif
endfunction


function! backandforward#nextBufferCommand(count) abort
  let jumplist = getjumplist()
  let jumps = jumplist[0]
  let direction = a:count >= 0 ? 1 : -1
  let dest = jumplist[1] + direction

  if dest < 0 || dest >= len(jumps)
    return ''
  endif

  if jumplist[1] >= len(jumps)
    let bufnr = bufnr()
  else
    let bufnr = jumps[jumplist[1]].bufnr
  endif

  let remain = a:count
  while remain != 0
    while dest >= 0 && dest < len(jumps) && bufnr == jumps[dest].bufnr
      let dest += direction
    endwhile

    if dest < 0 || dest >= len(jumps)
      break
    endif

    let bufnr = jumps[dest].bufnr
    let remain -= direction
  endwhile

  let dest = min([max([dest, 0]), len(jumps) - 1])

  if g:backandforward_config.always_last_pos
    let next = dest + 1
    while next < len(jumps) && bufnr == jumps[next].bufnr
      let dest = next
      let next += 1
    endwhile
  endif

  let jumpCount = (dest - jumplist[1]) * direction
  if jumpCount <= 0
    return ''
  endif

  if direction < 0
    return jumpCount . "\<C-O>"
  else
    return jumpCount . "\<C-I>"
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo


" vim: et sw=2 sts=-1
