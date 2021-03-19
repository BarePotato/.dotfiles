"---- LSP
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_matching_strategy_list	= ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case	= 1

lua << EOF
local catpeasnt = require'lspconfig'

local attachyboi = function(client)
	require'completion'.on_attach(client)
end

catpeasnt.rust_analyzer.setup({
	on_attach=attachyboi,
	settings = {
		["rust-analyzer"] = {
			inlayHints = {
				chainingHints = false,
				typeHints = true,
			},
		}
	}
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true, signs = true, update_in_insert = true 
	}
)
EOF

" move up down popup menu with tab and shift tab
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <F12> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
" Goto previous/next diagnostic warning/error
nnoremap <silent> [e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]e <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
" this brings up the completion popup if absent, tab triggers with smart tab does this already
imap <silent> <c-l> <Plug>(completion_trigger)

