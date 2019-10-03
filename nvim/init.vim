" Make nvim read pre-existing vim config
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" Fish doesn't play all that well with others
set shell=/bin/bash
let mapleader = "\<Space>"

" ====
" = PLUGINS
" ====

set nocompatible
filetype off
"set rtp+=~/dev/others/base16/builder/templates/vim/
call plug#begin()

" Load plugins
" VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'vim-scripts/localvimrc'
Plug 'justinmk/vim-sneak'
Plug 'kshenoy/vim-signature'
Plug 'schickling/vim-bufonly'
Plug 'bitc/vim-bad-whitespace'
Plug 'kbknapp/badWords'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

" Ctrl+P Fuzzy Matching Files
"     -> <c-p> / :CtrlP [dir]    Fuzzy Match Files
"     -> :CtrlPBuffer            Search Buffers
"     -> :CtrlPMixed             Files, Buffers, and MRU
"Plugin 'kien/ctrlp.vim'
Plug  'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = "<c-p>"
nnoremap <C-p> :CtrlPMixed<CR>
nnoremap <C-m> :CtrlPMRU<CR>
"nnoremap <C-b> :CtrlPBuffer<CR>
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target'

" Visualize your Undo Tree
"     -> :GundoToggle           See Undo Tree
Plug 'sjl/gundo.vim'
"nnoremap <F5> :GundoToggle<CR>
nnoremap <C-u> :GundoToggle<CR>
" persist (g)undo tree between sessions
set undofile
set undolevels=100
if has('python3')
    let g:gundo_prefer_python3 = 1          " anything else breaks on Ubuntu 16.04+
endif


" files
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'phildawes/racer'
Plug 'racer-rust/vim-racer'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Comment or UN-Comment Code
"     -> gcc                  Comment or uncomment line(s)
Plug 'vim-scripts/tComment'
nnoremap <C-/> gcc

" Better surround support
"     -> cs"'     "Hello"->'Hello'
"     -> ysiw[   'Hello'->[Hello]
"     -> ds[     [Hello]->Hello
Plug 'tpope/vim-surround'

" Repeat all commands with . not just native
Plug 'tpope/vim-repeat'

" Tagbar
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" Markdown
Plug 'mzlogin/vim-markdown-toc'

" Completion plugins
Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
"
" ----- Git Plugins -----
Plug 'tpope/vim-fugitive'

" +,-,~ in gutter
Plug 'airblade/vim-gitgutter'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Colorscheme
Plug 'nightsense/cosmic_latte'

call plug#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

" Colors
set background=dark
colorscheme cosmic_latte

hi Normal ctermbg=NONE
" Get syntax
syntax on

" Plugin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

" Base16
let base16colorspace=256
let g:base16_shell_path="~/dev/others/base16/builder/templates/shell/scripts/"

" Lightline
" let g:lightline = { 'colorscheme': 'wombat' }
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
\ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" if executable('ag')
" 	set grepprg=ag\ --nogroup\ --nocolor
" endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m

	" Use Ripgrep with Ctrl-P
	let g:ctrlp_user_command = 'rg --files %s'
	let g:ctrlp_use_caching = 0
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_switch_buffer = 'et'
endif

" Linter
" only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_virtualtext_cursor = 1
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None
let g:ale_sign_error = "✖"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
nmap <silent> <leader>al :ALELint<cr>
nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Enable faster viewport scrolling
nnoremap <C-e> 8<C-e>
nnoremap <C-y> 8<C-y>

" Mirror CLion for tags and jumps
nnoremap <C-b> <C-]>
nnoremap <C-BS> <C-O>

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Use wide tabs
set shiftwidth=8
set softtabstop=8
set tabstop=8
set noexpandtab

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" move on visual lines not physical
nmap j gj
nmap k gk

" Stay in visual mode when indenting.
vnoremap < <gv
vnoremap > >gv

" change windows with ctrl+(hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent> <Leader>te :tabnew<CR>
nnoremap <silent> <Leader>tn :tabnext<CR>
nnoremap <silent> <Leader>tp :tabprevious<CR>


" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ruler " Where am I?
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set nolist
set listchars=tab:>-,eol:¶,nbsp:¬,extends:»,precedes:«,trail:•

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
"nnoremap ; :

" Ctrl+c and Ctrl+j as Esc
"inoremap <C-j> <Esc>
"vnoremap <C-j> <Esc>
"inoremap <C-c> <Esc>
"vnoremap <C-c> <Esc>

" Suspend with Ctrl+f
inoremap <C-f> :sus<cr>
vnoremap <C-f> :sus<cr>
nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
" system clipboard (requires +clipboard)
set clipboard^=unnamed,unnamedplus

noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)


" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Jump to next/previous error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> L <Plug>(ale_lint)
nmap <silent> <C-l> <Plug>(ale_detail)
nmap <silent> <C-g> :close<cr>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_
noremap <leader>n ct-

" M to make
"noremap M :!make -k -j4<cr>

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

" open ranger as a file chooser using the function below
nnoremap <leader>r :call <SID>ranger()<CR>

function! <SID>ranger()
    let l:temp = tempname()
    execute 'silent !xterm -e ranger --choosefiles='.shellescape(l:temp).' $PWD'
    if !filereadable(temp)
        redraw!
        return
    endif
    let l:names = readfile(l:temp)
    if empty(l:names)
        redraw!
        return
    endif
    execute 'edit '.fnameescape(l:names[0])
    for l:name in l:names[1:]
        execute 'argadd '.fnameescape(l:name)
    endfor
    redraw!
endfunction

" Auto Close Pairs
inoremap {<CR> {<CR>}<C-o>O
inoremap {      {}<Left>
inoremap {{     {
inoremap {}     {}
inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
" function! ConditionalPairMap(open, close)
"   let line = getline('.')
"   let col = col('.')
"   if col < col('$') || stridx(line, a:close, col + 1) != -1
"     return a:open
"   else
"     return a:open . a:close . repeat("\<left>", len(a:close))
"   endif
" endf
" inoremap <expr> ( ConditionalPairMap('(', ')')
" inoremap <expr> { ConditionalPairMap('{', '}')
" inoremap <expr> [ ConditionalPairMap('[', ']')


" =============================================================================
" # Autocommands
" =============================================================================

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Auto-make less files on save
autocmd BufWritePost *.less if filereadable("Makefile") | make | endif

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

" Script plugins
autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim

" Flag bad whitespace
au BufRead,BufNewFile *.rs,*.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
