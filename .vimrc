call pathogen#infect()

" Necessary for lots of cool Vim things
set nocompatible

" Syntastic Plugin Settings -----
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler_options = '-std=c++11'
" -------------------------------

" Show what you're typing as a command
set showcmd

" Necessary for syntax highlightling
filetype on
filetype plugin on
syntax enable

" Autoindent
set autoindent

" Set tab widths
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in the console
set mouse=a

" Enable backspace support like normal programs
set backspace=2

" Display line numbers
set number

" Set smartcase
set smartcase

" Highlight things found using search
set hlsearch

" Remove buffer when a tab is closed
set nohidden

" Decide which colorscheme to use based on if in GUI vs console
if has("gui_running")
	colorscheme jellybeans
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
" Show matching brackets blocks
set showmatch

" Do smart case matching
set smartcase

" Show the line number on the status bar
set ruler

" Don't redraw when it's not necessary
set lazyredraw

" Keep 5 lines above and below the cursor
set scrolloff=5

" Keep at least 3 lines to the left and right of the cursor
set sidescrolloff=3

" Allow up to 1000 undos
set undolevels=1000

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
