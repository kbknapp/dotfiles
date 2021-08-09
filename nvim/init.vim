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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'godlygeek/tabular'
nnoremap <leader>t= :Tab /=<CR>
vnoremap <leader>t= :Tab /=<CR>
nnoremap <leader>t" :Tab /"<CR>
vnoremap <leader>t" :Tab /"<CR>
nnoremap <leader>t' :Tab /"<CR>
vnoremap <leader>t' :Tab /"<CR>
nnoremap <leader>t: :Tab /:\zs<CR>
vnoremap <leader>t: :Tab /:\zs<CR>
" Better window resizing with Ctrl+E"
Plug 'simeji/winresizer'

" GUI enhancements
Plug 'itchyny/lightline.vim'
""Plug 'dense-analysis/ale'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

" Ctrl+P Fuzzy Matching Files
"     -> <c-p> / :CtrlP [dir]    Fuzzy Match Files
"     -> :CtrlPBuffer            Search Buffers
"     -> :CtrlPMixed             Files, Buffers, and MRU
"Plugin 'kien/ctrlp.vim'
" Plug  'ctrlpvim/ctrlp.vim'
" let g:ctrlp_map = "<c-p>"
" nnoremap <C-p> :CtrlPMixed<CR>
" nnoremap <C-m> :CtrlPMRU<CR>
" nnoremap <leader>bb :CtrlPBuffer<CR>
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
nnoremap <C-n> :NERDTreeToggle<CR>
" Better Buffer Close support (don't wipe out splits, etc.)
Plug 'moll/vim-bbye'

Plug 'airblade/vim-rooter'
""Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
""Plug 'junegunn/fzf.vim'

""" Rust
"" CoC based
""Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Zig
Plug 'ziglang/zig.vim'

"" nvim-lsp based"
Plug 'neovim/nvim-lspconfig'           " Common configuration
Plug 'nvim-lua/lsp_extensions.nvim'    " type inlay hints, etc
Plug 'hrsh7th/nvim-compe'              " Autcompletions
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/vim-vsnip'               " Snippet handling
Plug 'simrat39/rust-tools.nvim'
Plug 'zigtools/zls'

" Optional dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>/ <cmd>Telescope live_grep<cr>
nnoremap <leader>ss <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>Telescope tags<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fe <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <leader>fee <cmd>Telescope lsp_workspace_diagnostics<cr>
Plug 'windwp/nvim-spectre'
nnoremap <leader>sr :lua require('spectre').open()<CR>
"search current word
nnoremap <leader>sw :lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>s :lua require('spectre').open_visual()<CR>
"  search in current file
nnoremap <leader>sb viw:lua require('spectre').open_file_search()<cr>

" agnostic
Plug 'mhinz/vim-crates'

if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

" Semantic language support
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
nmap <leader>T :TagbarToggle<CR>

" Markdown
Plug 'mzlogin/vim-markdown-toc'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'
" Configuration for vim-markdown
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'
let g:vim_markdown_follow_anchor = 1

" Completion plugins
Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
"
" ----- Git Plugins -----
""Plug 'tpope/vim-fugitive'
""Plug 'TimUntersberger/neogit'
nnoremap <silent> <leader>gg :silent ! emacs -e magit-status &<CR>

" +,-,~ in gutter
Plug 'airblade/vim-gitgutter'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'dag/vim-fish'

" Colorscheme
""Plug 'nightsense/cosmic_latte'
Plug 'ghifarit53/tokyonight-vim'

" Vimwiki
"Plug 'vimwiki/vimwiki'
"let g:vimwiki_list = [{'path': '~/Projects/vimwiki/',
"	             \ 'path_html': '~/Projects/vimwiki_html',
"                     \ 'syntax': 'markdown', 'ext': '.md'}]

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
" set background=dark
" colorscheme cosmic_latte
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

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
	let g:ctrlp_user_command = 'rg --files %s --hidden --color=never --glob ""'
	let g:ctrlp_use_caching = 0
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_switch_buffer = 'et'
endif

:lua << EOF
    local lspconfig = require('lspconfig')

    local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        require('completion').on_attach()
    end

    local servers = {'zls'}
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
        }
    end
EOF

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Enable completions as you type
let g:completion_enable_auto_popup = 1
" Linter
" only lint on save
" set omnifunc=ale#completion#OmniFunc
" let g:ale_completion_enabled = 1
" let g:ale_completion_autoimport = 1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_enter = 0
" let g:ale_virtualtext_cursor = 1
" highlight link ALEWarningSign Todo
" highlight link ALEErrorSign WarningMsg
" highlight link ALEVirtualTextWarning Todo
" highlight link ALEVirtualTextInfo Todo
" highlight link ALEVirtualTextError WarningMsg
" highlight ALEError guibg=None
" highlight ALEWarning guibg=None
" let g:ale_sign_error = "✖"
" let g:ale_sign_warning = "⚠"
" let g:ale_sign_info = "i"
" let g:ale_sign_hint = "➤"
" let g:ale_sign_column_always = 1
" let g:ale_fix_on_save = 1
" let g:ale_fixers = {
"     \ '*': ['remove_trailing_lines', 'trim_whitespace'],
"     \ 'rust': ['rustfmt'],
" \}
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" nmap <silent> <leader>acd :ALEGoToDefinition<CR>
" nmap <silent> <leader>acr :ALEFindReferences<CR>
" nmap <silent> <leader>aj :ALENext<cr>
" nmap <silent> <leader>ak :ALEPrevious<cr>
" nmap <silent> <leader>al :ALELint<cr>
" nmap <silent> <leader>aep <Plug>(ale_previous_wrap)
" nmap <silent> <leader>aen <Plug>(ale_next_wrap)
" nmap <silent> <leader>al <Plug>(ale_lint)
" nmap <silent> <leader>ad <Plug>(ale_detail)
" nmap <silent> <C-g> :close<cr>
" nnoremap <silent> K :ALEHover<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Enable faster viewport scrolling
nnoremap <C-e> 8<C-e>
nnoremap <C-y> 8<C-y>

" Mirror CLion for tags and jumps
nnoremap <C-b> <C-]>
" C-BS doesn't work in Terminal VIM: https://vim.fandom.com/wiki/Map_Ctrl-Backspace_to_delete_previous_word
"nnoremap <C-BS> <C-O>
nnoremap <C-\> <C-O>

" Open hotkeys
""map <C-p> :Files<CR>
""nmap <leader>bb :Buffers<CR>
nmap <leader>bp :bp<CR>
nmap <leader>bn :bn<CR>
nmap <leader>bw :Bwipeout!<CR>
nmap <leader>bk :Bdelete!<CR>
nmap <leader>bW :wa :bufdo :Bwipeout!<CR>
" Close all buffers but re-open the most recent...i.e. all but current one
nmap <leader>bK :wa :%bdelete!<CR><C-O>:Bd#<CR>

" Quick-save
nmap <leader>w :w<CR>

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
" Better completion experience
set completeopt=noinsert,menu,menuone,noselect
" Avoid showing extra messages with completions
set shortmess+=c
" tab to select
" and don't hijack my enter key
""inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
""inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

" Code navigation shortcuts
" as found in :help lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>cd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" rust-analyzer does not yet support goto declaration
" re-mapped `gd` to definition
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Completion
lua <<EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
  };
}
EOF
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hover, but don't focus
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

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

" Noevide Settings
let g:neovide_cursor_vfx_mode = "railgun"

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
"nnoremap ; :

" Use jj for escape
inoremap jj <ESC>

" Edit/Source the config
nnoremap <silent> <leader>ec :e ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>sc :source ~/.config/nvim/init.vim<CR>

" Use ALT+hkjl to navigate windows"
inoremap <A-h> <C-w>h
inoremap <A-j> <C-w>j
inoremap <A-k> <C-w>k
inoremap <A-l> <C-w>l
inoremap <A-c> <C-w>c
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-c> <C-w>c

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

" <leader>/ for Rg search
" noremap <leader>/ :Rg<space>
" let g:fzf_layout = { 'down': '~20%' }
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --hidden --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)
"
" function! s:list_cmd()
"   let base = fnamemodify(expand('%'), ':h:.:S')
"   return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
" endfunction
"
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
"   \                               'options': '--tiebreak=index'}, <bang>0)

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" arrows can switch buffers/tabs
nnoremap <left> :tp<CR>
nnoremap <right> :tn<CR>
nnoremap <up> :bp<CR>
nnoremap <down> :bn<CR>

" Move by visual line
nnoremap j gj
nnoremap k gk

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
nnoremap <leader>R :call <SID>ranger()<CR>

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

" Terminal Mode
nnoremap <C-t> <Esc>:terminal<CR>
inoremap <C-t> <Esc>:terminal<CR>
nnoremap <leader>oe :terminal<CR>
" Use ESC normally
tnoremap <Esc> <C-\><C-n>
tnoremap <leader>bp :bp<CR>
tnoremap <leader>bk :Bwipeout!<CR>:e#<CR>
" ALT+hkjl to navigate windows
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
" Simulate CTRL-r
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" =============================================================================
" # Autocommands
" =============================================================================

" Rust-tags support
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

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
au BufNewFile,BufRead *.rs setlocal colorcolumn=100
au BufNewFile,BufRead *.py setlocal colorcolumn=80
au BufNewFile,BufRead *.rs setlocal foldmethod=syntax
" Use space to toggle folds under cursor
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Rust Language Support"
lua <<EOF
local opts = {
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {}, -- rust-analyer options
}

require('rust-tools').setup(opts)
EOF

nnoremap <silent> <leader>crh :RustToggleInlayHints<CR>
nnoremap <silent> <leader>crm :lua require'rust-tools.expand_macro'.expand_macro()<CR>
nnoremap <silent> <leader>crr :RustRunnables<CR>
nnoremap <silent> <leader>cra :RustHoverActions<CR>

" For custom commenting functions.
let b:Comment="//"
let b:EndComment=""

" Four space indents.
runtime! include/spacing/four.vim

" Make syntax highlighting more efficient.
syntax sync fromstart

" Always run rustfmt is applicable and always use stable.
let g:rustfmt_autosave_if_config_present = 1
let g:rustfmt_command = "rustfmt +stable"

" Make CTRL-T work correctly with goto-definition.
"setlocal tagfunc=CocTagFunc

" nmap <Leader>gt <Plug>(coc-type-definition)
" nmap <Leader>gre <Plug>(coc-references)
" nmap <Leader>grn <Plug>(coc-rename)
" nmap <Leader>gd <Plug>(coc-diagnostic-info)
" nmap <Leader>gp <Plug>(coc-diagnostic-prev)
" nmap <Leader>gn <Plug>(coc-diagnostic-next)

" Markdown Help
autocmd FileType markdown set cursorline
autocmd FileType markdown set conceallevel=2
autocmd FileType markdown set linebreak
autocmd FileType markdown setlocal scrolloff=12
autocmd FileType markdown setlocal spell spelllang=en_us
autocmd FileType markdown Goyo

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
