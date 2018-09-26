if &term =~ "xterm" 
 "256 color -- 
 let &t_Co=256 
endif

" enable syntax highlighting 
syntax on 

au BufRead,BufNewFile *.log setfiletype log
au BufRead,BufNewFile *.log* setfiletype log 
au BufRead,BufNewFile *.gz setfiletype log
au BufWinEnter,WinEnter * if bufname('') == '' | setfiletype log | endif
au BufRead,BufNewFile *.ts   setfiletype typescript

" Vundle - 
"set nocompatible " be iMproved, required
"filetype off     " required
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

"Plugin 'leafgarland/typescript-vim'
" ...

" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"-----------
" Options
"-----------

" indent
set wrap
set smartindent
set noautoindent

" file format (unix end of line charac)
set ff=unix

" history levels
set history=1000

" undo levels
set undolevels=1000

" select case-insenitiv search (not default)
set ignorecase

" show cursor line and column in the status line
set ruler

set background=dark

" show cursor line and column in the status line
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" display mode INSERT/REPLACE/...
set showmode

" changes special characters in search patterns (default)
" set magic

" Required to be able to use keypad keys and map missed escape sequences
set esckeys

set backspace=indent,eol,start

" Lines before/after cursor position while scrolling
set scrolloff=5

" Show line number
set number

" Number of spaces for a tab
set tabstop=2

" Insert espace instead of tabulation
set expandtab

" Show current uncompleted command?  Absolutely!
set showcmd

"       laststatus:  show status line?  Yes, always!
"       laststatus:  Even for only one buffer.
set laststatus=2

" Hightlight search
set hlsearch

" Incremental search
set incsearch

" Hightlight current column
"set cursorcolumn

" Hightlight current line
set cursorline

" What to do on current line when cursorline is on
hi CursorLine cterm=bold,underline

" What to do on current line number when cursor line is on
"hi CursorLineNR cterm=bold

" Turn off swap & backup files
set noswapfile
set nobackup
set nowb

" A buffer becomes hidden when it is abandoned
set hidden

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Enable scrolling with the mouse wheel
set mouse=a

" statusline
" cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" format markers:
"   %< truncation point
"   %n buffer number
"   %f relative path to file
"   %m modified flag [+] (modified), [-] (unmodifiable) or nothing
"   %r readonly flag [RO]
"   %y filetype [ruby]
"   %= split point for left and right justification
"   %-35. width specification
"   %l current line number
"   %L number of lines in buffer
"   %c current column number
"   %V current virtual column number (-n), if different from %c
"   %P percentage through buffer
"   %) end of width specification
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

nnoremap <C-K> :call HighlightNearCursor()<CR>
function HighlightNearCursor()
  if !exists("s:highlightcursor")
    match Todo /\k*\%#\k*/
    let s:highlightcursor=1
  else
    match None
    unlet s:highlightcursor
  endif
endfunction

noremap % v%

" C style comments
set comments=s1:/*,mb:\ *,elx:\ */

" colors molokai_original
" colors monokai

" See https://github.com/altercation/vim-colors-solarized
color solarized

