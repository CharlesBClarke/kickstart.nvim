" Vim color file
" Name: vintage_ibm
" Description: Inspired by the IBM vintage data center image with increased contrast

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "vintage_ibm"

" Define color palette
let s:bg = "#1c1c1c"
let s:fg = "#ffd700"
let s:comment = "#cc7722"
let s:string = "#ff8c00"
let s:keyword = "#ffa500"
let s:function = "#e0e0e0"
let s:variable = "#ffbf00"
let s:constant = "#ff4500"

" Editor colors
hi Normal       guifg=s:fg       guibg=s:bg
hi Comment      guifg=s:comment  guibg=NONE  cterm=italic
hi Constant     guifg=s:constant guibg=NONE
hi Identifier   guifg=s:variable guibg=NONE
hi Statement    guifg=s:keyword  guibg=NONE
hi PreProc      guifg=s:keyword  guibg=NONE
hi Type         guifg=s:keyword  guibg=NONE
hi Special      guifg=s:keyword  guibg=NONE
hi Underlined   guifg=s:keyword  guibg=NONE
hi String       guifg=s:string   guibg=NONE
hi Function     guifg=s:function guibg=NONE

" UI elements
hi CursorLine   guibg=#2e2e2e
hi LineNr       guifg=#666666  guibg=NONE
hi StatusLine   guifg=s:fg     guibg=#333333
hi StatusLineNC guifg=#999999  guibg=#333333
hi VertSplit    guifg=#333333  guibg=NONE
hi Pmenu        guifg=s:fg     guibg=#2e2e2e
hi PmenuSel     guifg=s:bg     guibg=s:fg
hi PmenuSbar    guifg=NONE     guibg=#1c1c1c
hi PmenuThumb   guifg=NONE     guibg=#666666
hi Visual       guifg=NONE     guibg=#666666

" Additional highlighting
hi Search       guifg=s:bg     guibg=s:keyword
hi IncSearch    guifg=s:bg     guibg=s:string
hi MatchParen   guifg=NONE     guibg=#333333
hi Folded       guifg=#999999  guibg=#2e2e2e
hi FoldColumn   guifg=#999999  guibg=#1c1c1c
hi DiffAdd      guifg=#00ff00  guibg=NONE
hi DiffChange   guifg=#ffff00  guibg=NONE
hi DiffDelete   guifg=#ff0000  guibg=NONE
hi DiffText     guifg=#0000ff  guibg=NONE
