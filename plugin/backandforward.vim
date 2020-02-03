scriptencoding utf-8

if exists('g:loaded_backandforward')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim


let s:default_config = {
      \   'always_last_pos': 1,
      \   'auto_map': 1,
      \   'command_prefix': '',
      \   'define_commands': 1,
      \ }

if !exists('g:backandforward_config')
  let g:backandforward_config = {}
endif

call extend(g:backandforward_config, s:default_config, 'keep')
let s:config = g:backandforward_config


if s:config.define_commands
  let s:prefix = s:config.command_prefix
  execute 'command! -count=1 ' . s:prefix . 'Back call backandforward#nextFile(-<count>)'
  execute 'command! -count=1 ' . s:prefix . 'Forward call backandforward#nextFile(<count>)'
  unlet s:prefix
endif

nnoremap <silent> <Plug>(backandforward-back) :<C-U>call backandforward#nextFile(-v:count1)<CR>
nnoremap <silent> <Plug>(backandforward-forward) :<C-U>call backandforward#nextFile(v:count1)<CR>

if s:config.auto_map
  nmap <A-Left> <Plug>(backandforward-back)
  nmap <A-Right> <Plug>(backandforward-forward)
endif


unlet s:config


let &cpo = s:save_cpo
unlet s:save_cpo


" vim: et sw=2 sts=-1
