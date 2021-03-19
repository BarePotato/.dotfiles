"---- CoC
" call formatter
nmap <leader>ff :call <SID>FormatOrElse()<CR>
" command! -nargs=0 Format :call CocAction('format')
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
function! s:FormatOrElse()
	if &filetype == 'javascript'
		:CocCommand prettier.formatFile
	else
		:call CocAction('format')
	endif
endfunction
"navigates completion menu with tab and shift-tab
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~ '\s'
endfunction
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : kite#completion#autocomplete()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : <SID>check_back_space() ? "\<S-Tab>" : kite#completion#autocomplete()
inoremap <silent><expr> <C-Space> coc#refresh()
if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    " inoremap <expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
else
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
"get help for word under cursor or relevant doc
nnoremap <silent> K :call <SID>show_doc()<CR>
function! s:show_doc()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h ' .expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
"Symbol renaming.
nmap <F2> <Plug>(coc-rename)
nmap <silent> <F12> <Plug>(coc-definition)
nmap <silent> <C-F12> <Plug>(coc-implementation)
nmap <silent> <S-F12> <Plug>(coc-refernces)
nmap ]e <Plug>(coc-diagnostic-next-error)
nmap [e <Plug>(coc-diagnostic-prev-error)
nmap ]w <Plug>(coc-diagnostic-next)
nmap [w <Plug>(coc-diagnostic-prev)
nmap <leader>ca :CocAction<CR>
