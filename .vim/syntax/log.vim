" Vim syntax file
" Language: 1A logfile
" Maintainer: 
" Latest Revision: 

if exists("b:current_syntax")
  finish
endif

colorscheme delek

set nu
set hlsearch
set wrap
set smartcase

set ruler " Always show current positions along the bottom
set backspace=2 " make backspace work normal


" This creates a keyword ERROR and puts it in the highlight group called logError
:syn keyword logError ERROR
:syn keyword logWarn WARN
:syn keyword logDBG DBG
:syn keyword logInfo INFO
:syn keyword logCXN CXN
:syn keyword logINV INV
:syn keyword logSED SED
:syn keyword logCOM COM
:syn keyword logDB DB

" :syn keyword logNot NOT

" This creates a match on the date and puts in the highlight group called logDate.  The
" nextgroup and skipwhite makes vim look for logTime after the match
:syn match logDate '\d\{4\}/\d\{2\}/\d\{2\}' nextgroup=logTime skipwhite

" This creates a match on the time (but only if it follows the date)
:syn match logTime '\d\{2\}:\d\{2\}:\d\{2\}.\d\{6\}'

:syn match loginfsup '<.\{-\}pp.\{-\}>'

:syn match logPFX '\[PFX.\{-\}\]'

:syn match logRCI 'RCI+:\w\{6\}'

:syn match logIFT 'IFT+ZZZ+.\{-\}\''

:syn match logTVL 'TVL+.\{-\}\''

:syn match logUNH 'UNH+.\{-\}\''

:syn match logUNZ 'UNZ+.\{-\}\''

:syn match logSTX 'STX+.\{-\}\''

:syn match logORG 'ORG+.\{-\}\''

" Now make them appear:
" Link just links logError to the colouring for error
hi logError ctermfg=233 ctermbg=196 cterm=bold
hi logWarn ctermfg=208 
"ctermbg=15
hi logDBG ctermfg=21
hi logInfo ctermfg=226
hi logCXN ctermfg=15
hi logINV ctermfg=33
hi logSED ctermfg=159
hi logCOM ctermfg=237
hi logDB ctermfg=135

"hi logNot ctermfg=darkmagenta

" cterm=bold, underline, standout, reverse... 
" Def means default colour - colourschemes can override
hi logDate ctermfg=34
hi logTime ctermfg=34
hi loginfsup ctermfg=93
hi logPFX ctermfg=51
hi logRCI ctermfg=175
hi logIFT ctermfg=166
hi logTVL ctermfg=69
hi logUNH ctermfg=200
hi logUNZ ctermfg=200
hi logSTX ctermfg=15
hi logORG ctermfg=82

" changing the color of the highlight when searching in VI
hi Search ctermbg=darkmagenta ctermfg=NONE
