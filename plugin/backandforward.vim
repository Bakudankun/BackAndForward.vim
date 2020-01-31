scriptencoding utf-8

if exists('g:loaded_backandforward')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim


if !exists('g:backandforward_config')
  let g:backandforward_config = {}
endif


if get(g:backandforward_config, 'define_commands', 1)
  let s:prefix = get(g:backandforward_config, 'command_prefix', '')
  execute 'command! -count=1 ' . s:prefix . 'Back call backandforward#nextFile(-<count>)'
  execute 'command! -count=1 ' . s:prefix . 'Forward call backandforward#nextFile(<count>)'
  unlet s:prefix
endif

nnoremap <silent> <Plug>(backandforward-back) :<C-U>call backandforward#nextFile(-v:count1)<CR>
nnoremap <silent> <Plug>(backandforward-forward) :<C-U>call backandforward#nextFile(v:count1)<CR>

if get(g:backandforward_config, 'auto_map', 1)
  nmap <A-Left> <Plug>(backandforward-back)
  nmap <A-Right> <Plug>(backandforward-forward)
endif


let &cpo = s:save_cpo
unlet s:save_cpo


" vim: et sw=2 sts=-1
