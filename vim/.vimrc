" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set mouse=a

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" ============== Pathogen Initialization =============
" This loads all the plugins in ~/.vim/bundle
" using ~/.vim/autoload/pathogen.vim
execute pathogen#infect()

" ============== Omnicomplete Support ===============
" This adds the autocomplete function
set omnifunc=syntaxcomplete#Complete

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

syntax on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" =============== Mappings  ===========================
nmap <F8> :TagbarToggle<CR>     " Use F8 to open Tagbar
nmap <F7> :NERDTree<CR>         " Use F7 to open NERDTree
inoremap { {<CR><BS>}<Esc>O<BS>	
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap ] <Esc>la
inoremap ) <Esc>la

" =============== Go ================================
" These settings are for Go-lang specific features
autocmd FileType go autocmd BufWritePre <buffer> Fmt	" gofmt code on save
autocmd FileType go compiler go     " Always enable compiler plugin
