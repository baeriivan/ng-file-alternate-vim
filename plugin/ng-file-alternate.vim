" ng-file-alternate.vim
" Author:       Ivan Baeriswyl <https://baeriivan.github.io/>
" Version:      0.3

if exists("g:loaded_ng_file_alternate")
  finish
endif
let g:loaded_ng_file_alternate = 1


" Retrieve default choice from init.vim, if set
let s:ng_file_alternate_htmlfiletype =
  \ get(g:, 'ng_file_alternate_htmlfiletype', ".html")
let s:ng_file_alternate_scriptfiletype =
  \ get(g:, 'ng_file_alternate_scriptfiletype', ".ts")
let s:ng_file_alternate_testfiletype =
  \ get(g:, 'ng_file_alternate_testfiletype', ".spec.ts")
let s:ng_file_alternate_stylefiletype =
  \ get(g:, 'ng_file_alternate_stylefiletype', ".css")

" List of extensions per type, first is more important
let s:ng_file_alternate_htmlfiletype_list = [".html", ".htm"]
let s:ng_file_alternate_scriptfiletype_list = [".ts", ".js"]
let s:ng_file_alternate_testfiletype_list = [".spec.ts"]
let s:ng_file_alternate_stylefiletype_list = [".scss", ".css"]


function! s:gettargetbasename()
  let l:base = expand('%:r')
  if (expand('%:r:e') == 'spec')
    let l:base = expand('%:r:r')
  endif
  return l:base
endfunction


function! s:fileexists(basename, extension)
  return !empty(expand(glob(a:basename . a:extension)))
endfunction


function! s:openifexists(basename, extension)
  if s:fileexists(a:basename, a:extension) 
    exec "edit " . a:basename . a:extension
    return 1
  else
    return 0
  endif
endfunction


function! s:opentypefile(preferred_ext, type_ext_list)
  let l:basename = s:gettargetbasename()
  if s:openifexists(l:basename, a:preferred_ext)
    return
  endif
  for type_ext in a:type_ext_list
    if s:openifexists(l:basename, type_ext)
      return
    endif
  endfor
  exec "edit " . l:basename . preferred_ext
endfunction


function! Gotohtmlfile()
  call s:opentypefile(s:ng_file_alternate_htmlfiletype, s:ng_file_alternate_htmlfiletype_list)
endfunction


function! Gotoscriptfile()
  call s:opentypefile(s:ng_file_alternate_scriptfiletype, s:ng_file_alternate_scriptfiletype_list)
endfunction


function! Gototestfile()
  call s:opentypefile(s:ng_file_alternate_testfiletype, s:ng_file_alternate_testfiletype_list)
endfunction


function! Gotostylefile()
  call s:opentypefile(s:ng_file_alternate_stylefiletype, s:ng_file_alternate_stylefiletype_list)
endfunction


command! -nargs=0 NgFileAltenativeGoToHTML call Gotohtmlfile()
command! -nargs=0 NgFileAltenativeGoToScript call Gotoscriptfile()
command! -nargs=0 NgFileAltenativeGoToTest call Gototestfile()
command! -nargs=0 NgFileAltenativeGoToStyle call Gotostylefile()


" nnoremap <silent> <leader>hh :call Gotohtmlfile()<cr>
" nnoremap <silent> <leader>jj :call Gotoscriptfile()<cr>
" nnoremap <silent> <leader>kk :call Gototestfile()<cr>
" nnoremap <silent> <leader>ll :call Gotostylefile()<cr>
