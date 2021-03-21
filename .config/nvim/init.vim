" little more convenient than \
"let mapleader=","
let mapleader=" "

call plug#begin('$HOME/.vimfiles/pluggs')
" CoC LSP Config
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Neovim LSP Config
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
" Plug 'vimwiki/vimwiki'
Plug 'cespare/vim-toml'
Plug 'aliva/vim-fish'
Plug 'ziglang/zig.vim'
call plug#end()

" CoC LSP Config
source $XDG_CONFIG_HOME/nvim/coc-init.vim
" Neovim LSP Config
" source $XDG_CONFIG_HOME/nvim/lsp-init.vim

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
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
nmap <C-f> :Find<Space>

"---- Undotree
nnoremap <F5> :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 15
let g:undotree_RelativeTimestamp = 1
let g:undotree_ShortIndicators = 1

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

" window/split management
nmap <leader>ww <C-w><C-w>
nmap <leader>wh <C-w><C-h>
nmap <leader>wj <C-w><C-j>
nmap <leader>wk <C-w><C-k>
nmap <leader>wl <C-w><C-l>
nmap <leader>ws <C-w><C-s>
nmap <leader>wv <C-w><C-v>
nmap <leader>wq <C-w><C-q>

" page up/down
nmap <leader>u <C-u>
nmap <leader>d <C-d>

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
set scrolloff=10

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

" CoC Highlights
hi CocWarningSign      guifg=#ff5f00 ctermfg=202
hi CocWarningHighlight guifg=#ff5f00 ctermfg=202  cterm=underline gui=underline
hi CocErrorHighlight   guifg=#FF0000 ctermfg=Red  cterm=underline gui=underline
hi CocErrorSign 	   guifg=#ff0000 ctermfg=Red
hi CocListBlackBlack   guifg=#262626 guibg=#121212
