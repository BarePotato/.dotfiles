call plug#begin('$HOME/.vimfiles/pluggs')
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-lua/lsp_extensions.nvim'
" Stuff
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
" The masters files
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Syntax
Plug 'vimwiki/vimwiki'
Plug 'cespare/vim-toml'
Plug 'aliva/vim-fish'
Plug 'ziglang/zig.vim'
call plug#end()

"---- CoC
" call formatter
command! -nargs=0 Format :call CocAction('format')
nmap <M-S-f> :Format<CR>
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


"---- LSP
" set completeopt=menuone,noinsert,noselect
" set shortmess+=c
" let g:completion_matching_strategy_list	= ['exact', 'substring', 'fuzzy']
" let g:completion_matching_smart_case	= 1

"lua << EOF
"	local catpeasnt = require'lspconfig'

" 	local attachyboi = function(client)
" 		require'completion'.on_attach(client)
" 	end

"	catpeasnt.rust_analyzer.setup({
"		on_attach=attachyboi,
"		settings = {
"			["rust-analyzer"] = {
"				"rust-analyzer.inlayHints.enable"
"			}
"		}
"	})

"	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
"		vim.lsp.diagnostic.on_publish_diagnostics, {
"			virtual_text = true,
"			signs = true,
"			update_in_insert = true,
"		}
"	)
"EOF

" " move up down popup menu with tab and shift tab
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" " use <Tab> as trigger keys
" imap <Tab> <Plug>(completion_smart_tab)
" imap <S-Tab> <Plug>(completion_smart_s_tab)

" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <F12> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
" " Show diagnostic popup on cursor hold
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
" " Goto previous/next diagnostic warning/error
" nnoremap <silent> [e <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> ]e <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" Enable type inlay hints
" autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
" this brings up the completion popup if absent, tab triggers with smart tab does this already
" imap <silent> <c-l> <Plug>(completion_trigger)

"---- Markdown
let g:markdown_enable_spell_checking = 0

"---- Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='bare'

"---- FZF
nmap <C-p> :Files<CR>
":FZF<CR>
"command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"command! -bang -nargs=* -complete=dir Files call fzf#vim#files(<q-args>,  <bang>0)
"" THIS IS NOT THE RIGHT ANSWER
"" BUT it is probably what we want, needs alias in place of env var
"command! -bang -nargs=*  All call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob \"!{node_modules/*,.git/*}"', 'down': '40%', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi --reverse' }))
nmap <C-f> :Find<Space>

"---- Undotree
nnoremap <F5> :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 15
let g:undotree_RelativeTimestamp = 1
let g:undotree_ShortIndicators = 1

"----- NERDTree
"nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>
" auto opens nerdtree at start
"augroup nerdtree_open
"	autocmd!
"	autocmd VimEnter * NERDTree | wincmd p
"augroup END

"----- Folds
set viewdir=$HOME/.config/nvim/fold/
augroup FoldKeeper
	autocmd!
	autocmd BufWinLeave * silent! mkview! 1
	autocmd BufWinEnter * silent! loadview 1
augroup END
set foldcolumn=1
set viewoptions-=curdir

"----- Find Replace
command! -nargs=+ FindR call FindReplace(<f-args>)
function! FindReplace(...)
	if a:0 == 2
		exec printf('%%substitute/%s/%s/gc', a:1, a:2)
	endif
endfunction


command! Trail :%s/\s\+$//e

"---- Vim\Neovim
"this breaks on windows so disable
"map <C-z> <Nop>

" little more convenient than \
"let mapleader=","
let mapleader=" "

" let clipboarDCreateDefaultMappings
set cb=unnamedplus

" Don't enter Ex mode
map Q <Nop>

" Terminal Stuff
" exit integrated terminal mode - assumes buffer
tnoremap <Esc> <C-\><C-N>:bd!<CR>
" powershell
command! -nargs=0 Term :ene | call termopen('pwsh') | startinsert
" cargo run if rust
command! -nargs=*  Run :call <SID>CargoRun(<q-args>)
function! s:CargoRun(param)
	if &filetype == 'rust'
		ene | call termopen('cargo r -- ' . (a:param)) | startinsert
	endif
endfunction
" cargo build if rust
command! -nargs=0 Build :call <SID>CargoBuild()
function! s:CargoBuild()
	if &filetype == 'rust'
		ene | call termopen('cargo build') | startinsert
	endif
endfunction
" cargo check if rust
command! -nargs=0 Check :call <SID>CargoCheck()
function! s:CargoCheck()
	if &filetype == 'rust'
		ene | call termopen('cargo check') | startinsert
	endif
endfunction
" cargo docs if rust
command! -nargs=0 Doc :call <SID>CargoDoc()
function! s:CargoDoc()
	if &filetype == 'rust'
		:silent !cargo doc -q --open
	endif
endfunction

" Configurations
" edit and reload vim rc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" edit coc-settings.json
nmap <silent> <leader>cv :e $HOME/.config/nvim/coc-settings.json<CR>
" edit alacritty.yml
nmap <silent> <leader>av :e $HOME/.config/alacritty/alacritty.yml<CR>

" json to jsonc because errors suck
augroup json_comments
	autocmd! FileType json set filetype=jsonc
augroup END

" new tab
nmap <C-n> :tabe<CR>

syntax on
filetype plugin indent on

"set t_Co=256
set t_Co=termguicolors
if (has("termguicolors"))
	set termguicolors
endif
"set t_ut=

" protect from thingies
set nomodeline

" sign column - number(use # col) or yes(own col left of #)
set signcolumn=number

" turn off comment insertion
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=cro

" cursor - blink all, vertical insert, horizontal replace, default otherwise
set guicursor=a:blinkon100,i-c-ci:ver20,r-cr-o:hor20

set wildignore+=*.o,*.a,*.so,.git\*,.svn\*,.hg\*,*\target\*,*.swp,*.bak,*.class,*.pyc

set title
set novisualbell
set noerrorbells
set tabstop=4
set shiftwidth=4
set shiftround
set copyindent

" relative line numbers by default
set number
set rnu
" absolute line numbers while in insert
augroup relnumtoggle
	autocmd!
	autocmd InsertEnter * set nornu
	autocmd InsertLeave * set rnu
augroup END
" highlight current line
set cursorline
set numberwidth=2

" match brackets () [] {} <>
set showmatch
set matchpairs+=<:>

" insert a comment header
nnoremap <silent> gh i//----------[  ]<left><left>

set ignorecase
set smartcase
set updatetime=300

" popup list height
set pumheight=10

" clear search highlight
nmap <silent> <leader>/ :let @/ = ""<CR>

" keeps n lines above or below the cursor at top or bottom
set scrolloff=20

nnoremap ; :
nnoremap j gj
nnoremap k gk

set mouse=a

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" undo
set undodir=$HOME/.config/nvim/undo/
set undofile

set noshowmode
colo simple-bare
