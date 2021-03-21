if !(&t_Co == 256 || has('gui_running'))
  finish
endif

" Init
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name="simple-bare"
set background=dark

" General Colors
" hi Normal       guifg=#c6c6c6  guibg=#080808  ctermfg=251   ctermbg=232   gui=none      cterm=none
hi Normal       guifg=#c6c6c6  guibg=NONE     ctermfg=251   ctermbg=NONE  gui=none      cterm=none
hi Comment      guifg=#5f875f  guibg=NONE     ctermfg=65    ctermbg=NONE  gui=none      cterm=none
hi Constant     guifg=#d7d7af  guibg=NONE     ctermfg=187   ctermbg=NONE  gui=none      cterm=none
hi Identifier   guifg=#afd7d7  guibg=NONE     ctermfg=152   ctermbg=NONE  gui=none      cterm=none
hi Statement    guifg=#87afd7  guibg=NONE     ctermfg=110   ctermbg=NONE  gui=none      cterm=none
hi PreProc      guifg=#87afd7  guibg=NONE     ctermfg=110   ctermbg=NONE  gui=none      cterm=none
hi Type         guifg=#afd7d7  guibg=NONE     ctermfg=152   ctermbg=NONE  gui=none      cterm=none
hi Special      guifg=#d7d7af  guibg=NONE     ctermfg=187   ctermbg=NONE  gui=none      cterm=none

" Text Markup
hi Underlined   guifg=fg       guibg=NONE     ctermfg=fg    ctermbg=NONE  gui=underline cterm=underline
hi Error        guifg=#ff8787  guibg=NONE     ctermfg=210   ctermbg=NONE  gui=underline cterm=underline
hi Todo         guifg=#d7af00  guibg=NONE     ctermfg=178   ctermbg=NONE  gui=none      cterm=none
hi MatchParen   guifg=fg       guibg=#5f8787  ctermfg=fg    ctermbg=66    gui=none      cterm=none
hi NonText      guifg=#585858  guibg=NONE     ctermfg=240   ctermbg=NONE  gui=none      cterm=none
hi SpecialKey   guifg=#585858  guibg=NONE     ctermfg=240   ctermbg=NONE  gui=none      cterm=none
hi Title        guifg=#d7d7af  guibg=NONE     ctermfg=187   ctermbg=NONE  gui=none      cterm=none

" Text Selection
hi Cursor       guifg=#080808  guibg=fg       ctermfg=232   ctermbg=fg    gui=none      cterm=none
hi CursorIM     guifg=#080808  guibg=fg       ctermfg=232   ctermbg=fg    gui=none      cterm=none
hi CursorColumn guifg=NONE     guibg=#121212  ctermfg=NONE  ctermbg=233   gui=none      cterm=none
hi CursorLine   guifg=NONE     guibg=#121212  ctermfg=NONE  ctermbg=233   gui=none      cterm=none
hi Visual       guifg=NONE     guibg=#005f87  ctermfg=NONE  ctermbg=24    gui=none      cterm=none
hi VisualNOS    guifg=fg       guibg=NONE     ctermfg=fg    ctermbg=NONE  gui=underline cterm=underline
hi IncSearch    guifg=#080808  guibg=#87ffff  ctermfg=232   ctermbg=123   gui=none      cterm=none
hi Search       guifg=#080808  guibg=#ffd75f  ctermfg=232   ctermbg=221   gui=none      cterm=none

" UI
hi LineNr       guifg=#444444  guibg=#121212  ctermfg=238   ctermbg=233   gui=none      cterm=none
hi CursorLineNr guifg=#626262  guibg=#080808  ctermfg=241   ctermbg=232   gui=none      cterm=none
hi Pmenu        guifg=#b2b2b2  guibg=#121212  ctermfg=249   ctermbg=233   gui=none      cterm=none
hi PmenuSel     guifg=fg       guibg=#585858  ctermfg=fg    ctermbg=240   gui=none      cterm=none
hi PMenuSbar    guifg=#121212  guibg=#c6c6c6  ctermfg=233   ctermbg=251   gui=none      cterm=none
hi PMenuThumb   guifg=fg       guibg=#767676  ctermfg=fg    ctermbg=243   gui=none      cterm=none
hi StatusLine   guifg=#b2b2b2  guibg=#121212  ctermfg=243   ctermbg=233   gui=none      cterm=none
hi StatusLineNC guifg=#121212  guibg=#767676  ctermfg=233   ctermbg=243   gui=none      cterm=none
hi TabLine      guifg=fg   	   guibg=#080808  ctermfg=fg    ctermbg=232   gui=none      cterm=none
hi TabLineFill  guifg=fg   	   guibg=#080808  ctermfg=fg    ctermbg=232   gui=none      cterm=none
hi TabLineSel   guifg=#080808  guibg=fg   	  ctermfg=232   ctermbg=fg    gui=none      cterm=none
hi VertSplit    guifg=#8a8a8a  guibg=#b2b2b2  ctermfg=245   ctermbg=249   gui=none      cterm=none
hi Folded       guifg=#080808  guibg=#8a8a8a  ctermfg=232   ctermbg=245   gui=none      cterm=none
hi FoldColumn   guifg=#626262  guibg=#121212  ctermfg=241   ctermbg=233   gui=none      cterm=none

" Diff
hi DiffAdd      guifg=fg       guibg=#005f00  ctermfg=fg    ctermbg=22    gui=none      cterm=none
hi DiffChange   guifg=fg       guibg=#5f5f00  ctermfg=fg    ctermbg=58    gui=none      cterm=none
hi DiffDelete   guifg=fg       guibg=#5f0000  ctermfg=fg    ctermbg=52    gui=none      cterm=none
hi DiffText     guifg=#ffd700  guibg=#5f5f00  ctermfg=220   ctermbg=58    gui=none      cterm=none

" Misc
hi Directory    guifg=fg       guibg=NONE     ctermfg=fg    ctermbg=NONE  gui=none      cterm=none
hi ErrorMsg     guifg=#ff8787  guibg=NONE     ctermfg=210   ctermbg=NONE  gui=none      cterm=none
hi SignColumn   guifg=#afafaf  guibg=NONE     ctermfg=145   ctermbg=NONE  gui=none      cterm=none
hi MoreMsg      guifg=#87ffff  guibg=NONE     ctermfg=123   ctermbg=NONE  gui=none      cterm=none
hi ModeMsg      guifg=fg       guibg=NONE     ctermfg=fg    ctermbg=NONE  gui=none      cterm=none
hi Question     guifg=fg       guibg=NONE     ctermfg=fg    ctermbg=NONE  gui=none      cterm=none
hi WarningMsg   guifg=#d7af87  guibg=NONE     ctermfg=180   ctermbg=NONE  gui=none      cterm=none
hi WildMenu     guifg=NONE     guibg=#005f87  ctermfg=NONE  ctermbg=24    gui=none      cterm=none
hi ColorColumn  guifg=NONE     guibg=#303030  ctermfg=NONE  ctermbg=236   gui=none      cterm=none
hi Ignore       guifg=#262626                 ctermfg=235
