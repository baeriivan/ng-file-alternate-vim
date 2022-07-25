" ng-file-alternate.vim
" Author:       Ivan Baeriswyl <https://baeriivan.github.io/>
" Version:      0.2

if exists("g:loaded_ng_file_alternate")
  finish
endif
let g:loaded_ng_file_alternate = 1

let s:ng_file_alternate_htmlfiletype = get(g:, 'ng_file_alternate_htmlfiletype', ".html")
let s:ng_file_alternate_scriptfiletype = get(g:, 'ng_file_alternate_scriptfiletype', ".ts")
let s:ng_file_alternate_testfiletype = get(g:, 'ng_file_alternate_testfiletype', ".spec.ts")
let s:ng_file_alternate_stylefiletype = get(g:, 'ng_file_alternate_stylefiletype', ".css")

function! s:gettargetbasename()
  let l:base = expand('%:r')
  if (expand('%:r:e') == 'spec')
    let l:base = expand('%:r:r')
  endif
  return l:base
endfunction

function! Gotohtmlfile()
  let l:file = s:gettargetbasename() . s:ng_file_alternate_htmlfiletype
  exec "edit " . l:file
endfunction

function! Gotoscriptfile()
  let l:file = s:gettargetbasename() . s:ng_file_alternate_scriptfiletype
  exec "edit " . l:file
endfunction

function! Gototestfile()
  let l:file = s:gettargetbasename() . s:ng_file_alternate_testfiletype
  exec "edit " . l:file
endfunction

function! Gotostylefile()
  let l:file = s:gettargetbasename() . s:ng_file_alternate_stylefiletype
  exec "edit " . l:file
endfunction

nnoremap <silent> <leader>hh :call Gotohtmlfile()<cr>
nnoremap <silent> <leader>jj :call Gotoscriptfile()<cr>
nnoremap <silent> <leader>kk :call Gototestfile()<cr>
nnoremap <silent> <leader>ll :call Gotostylefile()<cr>

" nnoremap <Plug>GoToHtmlNgFileAlternate   :call Gotohtmlfile()<cr>
" nnoremap <Plug>GoToScriptNgFileAlternate :call Gotoscriptfile()<cr>
" nnoremap <Plug>GoToTestNgFileAlternate   :call Gototestfile()<cr>
" nnoremap <Plug>GoToStyleNgFileAlternate  :call Gotostylefile()<cr>

" if !exists("g:ng_file_alternate_no_mappings") || ! g:ng_file_alternate_no_mappings
"   nnoremap <leader>hh <Plug>GoToHtmlNgFileAlternate
"   nnoremap <leader>jj <Plug>GoToScriptNgFileAlternate
"   nnoremap <leader>kk <Plug>GoToTestNgFileAlternate
"   nnoremap <leader>ll <Plug>GoToStyleNgFileAlternate
" endif

