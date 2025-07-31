" BEGIN OF Vundle

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " Vundle dogfooding itself, required

Plugin 'tpope/vim-fugitive'     " powerful git tool
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'msanders/snipmate.vim'
" Plugin 'honza/vim-snippets'

Plugin 'rhysd/vim-clang-format'

Plugin 'rizzatti/dash.vim'
Plugin 'bling/vim-airline' "{{{
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#left_sep=' '
      let g:airline#extensions#tabline#left_alt_sep='¦'
      if !exists('g:airline_symbols')
          let g:airline_symbols = {}
      endif
      let g:airline_left_sep = ''
      let g:airline_left_alt_sep = ''
      let g:airline_right_sep = ''
      let g:airline_right_alt_sep = ''
      let g:airline_symbols.branch = ''
      let g:airline_symbols.readonly = ''
      let g:airline_symbols.linenr = ''
    "}}}
Plugin 'edkolev/tmuxline.vim'

Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter' " git diff
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/a.vim'

call vundle#end()
" All of your Plugins must be added before the following line
filetype plugin indent on    " required
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

" END OF Vundle
syntax enable
colorscheme molokai

set autowrite                  " Writes on make/shell commands
set autoread
set backspace=2           " Allow backspacing over indents, line breaks, and start of insert

" 81 character line
if exists("+colorcolumn")
    set colorcolumn=81
endif

" Visual "{{{
syntax on                      " enable syntax

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

set mousehide                 " Hide mouse after chars typed

set showmatch                 " Show matching brackets.

set wildmode=longest,list     " At command line, complete longest common string, then list alternatives.

set completeopt+=preview

set novisualbell              " No blinking
set noerrorbells              " No noise.
set vb t_vb=                  " disable any beeps or flashes on error

set shortmess+=atI             " shortens messages

set foldenable                " Turn on folding
set foldmethod=marker         " Fold on the marker
set foldlevel=100             " Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

set virtualedit=block

set splitbelow
set splitright

set list                      " display unprintable characters f12 - switches
scriptencoding utf-8
set encoding=utf-8
set listchars=tab:\ ·,trail:·
set listchars+=extends:»,precedes:«
map <silent> <F12> :set invlist<CR>

" "}}}

" old stuff from pnaimoli

let $VIMRC = '~/.vimrc'   " for portability

filetype on               " enable filetype detection

set hid                   " don't auto-remove hidden buffers
set history=1000          " 1000 commands stored in history
set hlsearch              " highlight all search pattern matches
set incsearch             " incremental search
set isk+=%,#              " none of these should be word dividers
set linebreak             " enable smart linebreaking
set matchtime=0           " prevent matching delay
set ic                    " force case-sensitive
set nu                    " show line numbers
set scrolloff=2           " keep 2 lives visible above/below the cursor
set laststatus=2          " always show status line.
set shortmess+=IA         " suppress intro and swap file messages
set showcmd               " show command on last line
set showmode              " show mode
set smartcase             " overrides ignorecase if uppercase used
set wig=*.o,*.pyc         " Ignore these files for wildmenu completion
set wildmenu              " Better command-line completion
set wildmode=longest:full " Makes tab completion smarter
set winheight=3           " Never let a window be less than 3 lines
set winminheight=3        " Never let a window be less than 3 lines

set autoindent            " indent like the last line, by default
set cindent               " indent for c syntax
set cinkeys-=0#           " I should look up what this does again
set cinoptions+=g2        " indent scope declarations by 2
set cinoptions+=h2        " indent statements after scope declarations by 2
set smarttab              " delete shifted spaces as if they were tabs
set tabstop=4             " tabs = 4 spaces
set shiftwidth=4          " basic indents = 4 spaces
set expandtab             " expand tabs to spaces
set paste

function! SetupOmnirankEnvironment()
  let l:path = expand('%:p')
  if l:path =~ '.*/omnirank/.*'
    setlocal expandtab smarttab tabstop=2 shiftwidth=2
  endif
endfunction

function! CPPHeader()
  " run
  " g++ -E -x c++ - -v < /dev/null
  " to find out the default compiler header file path
  if system("uname") =~ "Linux"
    set path+=/usr/include/c++/4.8,/usr/include/x86_64-linux-gnu/c++/4.8,/usr/include/c++/4.8/backward,/usr/lib/gcc/x86_64-linux-gnu/4.8/include,/usr/local/include,/usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed,/usr/include/x86_64-linux-gnu,/usr/include
  endif
endfunction
""""""""""""""""""""""""""""""""""
" ===== Auto command section =====
""""""""""""""""""""""""""""""""""
if has('autocmd')
    augroup vimrc
    au!
    " Set up CPP specific autocommands
    au FileType c,cpp,cc setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://

    au BufNewFile,BufRead *.{c,cpp,cc,cxx,h}        set ft=cpp
    " special indentation
    au FileType c,cpp,cc        call SetupOmnirankEnvironment()
    au FileType c,cpp,cc        call CPPHeader()
    au BufNewFile,BufRead *.{sig,cnf,conf,config}   set ft=config
    au BufNewFile,BufRead *.slaqur                  set filetype=yaml

    " When entering a buffer, cd to the file's directory, silently fail
	autocmd BufEnter * silent! lcd %:p:h


    " Auto remove trailing whitespace
    autocmd BufWritePre *.{py,c,cpp,cc,cxx,h} :%s/\s\+$//e

    " Auto source the vimrc file when it is saved
    au! BufWritePost [\._]vimrc source $VIMRC

    augroup END
endif


""""""""""""""""""""""""""""""""""
" ===== Fast Window Resizing =====
""""""""""""""""""""""""""""""""""
nmap + <C-W>+
nmap - <C-W>-

"""""""""""""""""""""""""""""""
" ===== Nice Window Title =====
"""""""""""""""""""""""""""""""
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                                              " file name
    set titlestring+=%h%m%r%w                                         " flags
    set titlestring+=\ -\ %{v:progname}                               " program name
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" ===== TODO: Organize this at a later point =====
""""""""""""""""""""""""""""""""""""""""""""""""""
" switch between .h and .cc file Easily
let g:alternateExtensions_cc = "he,h"
let g:alternateExtensions_h = "cc,c"
let g:alternateExtensions_he = "cc,c"
let g:alternateRelativeFiles = 1
map <F2> :A<CR>

" super paste
"inoremap <C-V> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
vnoremap <S-C> "+y

" Load filetype plugins
filetype plugin on

" easy key to pop back from looking at a tag
" noremap <silent> <C-[> :pop<CR>
set encoding=utf-8

""""""""""""""""""""""""""""""""""
" ===== Edit & Reload .vimrc =====
""""""""""""""""""""""""""""""""""
nmap ,s :source $VIMRC
nmap ,e :e $VIMRC

""""""""""""""""""""""""""""
" ===== Switching tabs =====
""""""""""""""""""""""""""""
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

"""""""""""""""""""""""""""""""""""""""""
" ===== Alternative navigation keys =====
"""""""""""""""""""""""""""""""""""""""""
set whichwrap+=<,>,[,]
map j gj
map k gk

map <up> gk
imap <up> <C-O><up>
map <down> gj
imap <down> <C-O><down>

""""""""""""""""""""""""""""""""""
" ===== Commenting utilities =====
"""""""""""""""""""""""""""""""""

let mapleader=' '

map <silent> <leader>a :noh<CR>

fun! s:CoolComment(chars)
    let @@=@/
    exe "s@^\\(\\s*\\)@\\1".a:chars."@"
    let @/=@@
endfun

fun! s:ClearComment()
    let @@=@/
    try
        exe "s@^\\(\\s*\\)\\(//\\|--\\|> \\|[#\"%!;]\\)@\\1@"
    catch
    endtry
    let @/=@@
endfun

map <silent> <leader># :call <SID>CoolComment("#")<CR>
map <silent> <leader>" :call <SID>CoolComment("\"")<CR>
map <silent> <leader>/ :call <SID>CoolComment("//")<CR>
map <silent> <leader>c :call <SID>ClearComment()<CR>

nnoremap ; :
nnoremap Y y$
vnoremap < <gv
vnoremap > >gv
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap ]] ]]zz
nnoremap [[ [[zz
nnoremap } }zz
nnoremap { {zz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" When we replace the selected text xyz123 with our previous yanked text
" abc456, the "+ register will hold abc456 after the replacement. So if we want 
" to replace many different stuff with xyz123, we should store it in another
" register. That's why we use the register "o in the following four lines.
nnoremap <F4> "oyiw
vnoremap <F4> "oy
nnoremap <F5> viw"op
vnoremap <F5> "op
