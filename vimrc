" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
""filetype off                  " required

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
" else
"   set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  set vb
  set smarttab
  set expandtab
  set ai
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
  set noexpandtab
  inoremap { {}<Esc>i
  inoremap ( ()<Esc>i
  inoremap [ []<Esc>i
  inoremap " ""<Esc>i
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  ""filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

endif " has("autocmd")

set exrc
set secure
set vb
set nu
set smarttab
set expandtab
set ai
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set nocp
set timeoutlen=100
filetype plugin on
nnoremap ; :
nnoremap : ;
nnoremap - $
inoremap <TAB> <c-r>=TabSkipPair()<CR>
inoremap <CR> <c-r>=CRnextline()<CR>
nnoremap <F3> <Esc>:call ToggleLine()<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"" Calendar
nnoremap <F9> :Calendar<cr>

vmap "+y :w !pbcopy<CR><CR>
nmap "+p :r !pbpaste<CR><CR>

func TabSkipPair()
	if getline('.')[col('.') - 1] == '}'||getline('.')[col('.') - 1] == ')'||getline('.')[col('.') - 1] == ']'||getline('.')[col('.') - 1] == '"'||getline('.')[col('.') - 1] == "'"||getline('.')[col('.') - 1] == '>'
		return "\<Right>"
	else
		return "\<Tab>"
	endif
endfunc

func Comment()
	if getline('.')[col('.') + 1] == '/'
		return ""
	else
		return "\<Esc>\j"
	endif
endfunc

function! ToggleLine()
	if !exists("g:linenum_toggle")
		let g:linenum_toggle= 0
	endif
	if g:linenum_toggle == 0
	    let g:linenum_toggle = 1
	    set nu
	elseif g:linenum_toggle == 1
	    let g:linenum_toggle = 2
	    set rnu
	elseif  g:linenum_toggle == 2
	    let g:linenum_toggle = 0
		set nornu
	    set nonu
	endif
endfunc

func CRnextline()
	if getline('.')[col('.') - 1] == '}'
		return "\<CR>\<CR>\<Up>\<Tab>"
	else
		return "\<CR>"
	endif
endfunc

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

let g:vim_markdown_folding_disabled = 1
