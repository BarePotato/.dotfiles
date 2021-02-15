call plug#begin('$HOME/.vimfiles/pluggs')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'pprovost/vim-ps1'
Plug 'preservim/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-unimpaired'
Plug 'cespare/vim-toml'
Plug 'aliva/vim-fish'
Plug 'gabrielelana/vim-markdown'
Plug 'jiangmiao/auto-pairs'
call plug#end()

"---- Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='zenburn'

"---- CoC
" call formatter
command! -nargs=0 Format :call CocAction('format')
nmap <M-S-f> :Format<CR>
" navigates completion menu with tab and shift-tab
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~ '\s'
endfunction
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : kite#completion#autocomplete()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : <SID>check_back_space() ? "\<S-Tab>" : kite#completion#autocomplete()
"inoremap <silent><expr> <C-Space> coc#refresh()
if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" get help for word under cursor or relevant doc
nnoremap <silent> K :call <SID>show_doc()<CR>
function! s:show_doc()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h ' .expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <F2> <Plug>(coc-rename)

"---- FZF
nmap <C-p> :Files<CR>
":FZF<CR>
"command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"command! -bang -nargs=* -complete=dir Files call fzf#vim#files(<q-args>,  <bang>0)
"" THIS IS NOT THE RIGHT ANSWER
"" BUT it is probably what we want, needs alias in place of env var
"command! -bang -nargs=*  All call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob \"!{node_modules/*,.git/*}"', 'down': '40%', 'options': '--expect=ctrl-t,ctrl-x,ctrl-v --multi --reverse' }))
nmap <C-f> :Find

"---- Undotree
nnoremap <F5> :UndotreeToggle<cr>
"let g:undotree_DiffCommand='diff'
"let g:undotree_HighlightChangedText = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2

"----- NERDTree
nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>
" auto opens nerdtree at start
"augroup nerdtree_open
"	autocmd!
"	autocmd VimEnter * NERDTree | wincmd p
"augroup END

"----- Folds
set viewdir=$HOME/.config/nvim/fold/
augroup FoldKeeper
	autocmd!
	autocmd BufWinLeave ?* silent! mkview!
	autocmd BufWinEnter ?* silent! loadview
augroup END

"----- NERDCommenter
"let g:NERDCreateDefaultMappings = 0
map <silent> gc <Plug>NERDCommenterToggle

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
nmap <silent> <leader>cv :e $HOME/vimfiles/coc-settings.json<CR>
" edit alacritty.yml
nmap <silent> <leader>av :e $HOME/.config/alacritty/alacritty.yml<CR>
" edit powershell.ps1
nmap <silent> <leader>pv :e $HOME/Documents/PowerShell/profile.ps1<CR>
" edit windows terminal
nmap <silent> <leader>wv :e $HOME/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json<CR>

" json to jsonc because errors suck
augroup json_comments
	autocmd! FileType json set filetype=jsonc
augroup END

" new tab
nmap <C-n> :tabe<CR>

syntax on
"set t_Co=256
set t_Co=termguicolors
if (has("termguicolors"))
	set termguicolors
endif
"set t_ut=
colo simple-dark

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

" match brackets () [] {} <>
set showmatch
set matchpairs+=<:>

" insert a comment header
nnoremap <silent> gh i//----------[  ]<left><left>

set ignorecase
set smartcase

" popup list height
set pumheight=10

" clear search highlight
"nmap <silent> ,/ :nohlsearch<CR>
nmap <silent> ,/ :let @/ = ""<CR>
nmap <silent> <space>/ ,/

" shorten updatetime for things like CursorHold
set updatetime=300

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

" CoC Highlights
hi CocWarningSign      ctermfg=202
hi CocWarningHighlight ctermfg=202  cterm=underline
hi CocErrorHighlight   ctermfg=Red  cterm=underline
hi CocErrorSign 	   ctermfg=Red
" Syntax Highlights
hi Comment 			   ctermfg=65   guifg=#5f875f
hi Normal  			   ctermfg=251  ctermbg=232  guibg=#080808  guifg=#c6c6c6
