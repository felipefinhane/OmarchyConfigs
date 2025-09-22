" ~/.vimrc - Vim configuration for Omarchy

" General settings
set nocompatible
set number
set relativenumber
set cursorline
set showcmd
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set wrap
set linebreak
set scrolloff=3
set sidescrolloff=5
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Create backup directories if they don't exist
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "p")
endif
if !isdirectory($HOME."/.vim/tmp")
    call mkdir($HOME."/.vim/tmp", "p")
endif

" Enable syntax highlighting
syntax enable
set background=dark

" Enable file type detection and plugins
filetype plugin indent on

" Key mappings
let mapleader = ","
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>n :nohl<CR>
nnoremap j gj
nnoremap k gk

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Quick edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Status line
set laststatus=2
set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Auto commands
autocmd BufWritePre * :%s/\s\+$//e  " Remove trailing whitespace on save
autocmd BufRead,BufNewFile *.md setlocal spell  " Enable spell check for markdown

" Load local customizations if they exist
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif