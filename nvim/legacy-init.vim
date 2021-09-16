set termguicolors " this variable must be enabled for colors to be applied properly

let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }

" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 0,
    \ }

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
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

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages with completions
set shortmess+=c

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hover, but don't focus
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})

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
set printfont=:h10
set guifont=FantasqueSansMono\ Nerd\ Font:h9
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
nnoremap <silent> <Space>z @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

nnoremap <silent> <leader>crh :RustToggleInlayHints<CR>
nnoremap <silent> <leader>crm <cmd>lua require'rust-tools.expand_macro'.expand_macro()<CR>
nnoremap <silent> <leader>crr :RustRunnables<CR>
nnoremap <silent> <leader>cra :RustHoverActions<CR>

" dap
nnoremap <silent> <leader>dd <cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dr <cmd>lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>la
nnoremap <silent> <leader>db <cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dc <cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F9> <cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dsi <cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F10> <cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>dso <cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>dsO <cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <F12> <cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>dtm <cmd>lua require'dap-python'.test_method()<CR>
nnoremap <silent> <leader>dtc <cmd>lua require'dap-python'.test_class()<CR>
nnoremap <silent> <leader>dds <cmd>lua require'dap-python'.debug_selection()<CR>
nnoremap <silent> <leader>di <cmd>lua require'dap.ui.variables'.hover(function () return vim.fn.expand("<cexpr>") end)<CR>
nnoremap <silent> <leader>di <cmd>lua require'dap.ui.variables'.visual_hover()<CR>


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

" Markdown Help
autocmd FileType markdown set cursorline
autocmd FileType markdown set conceallevel=2
autocmd FileType markdown set linebreak
autocmd FileType markdown setlocal scrolloff=12
autocmd FileType markdown setlocal spell spelllang=en_us
"autocmd FileType markdown Goyo

" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif

" vim-sandwhich for Rust
fun! s:AddRustSandwichBinding(input, start, end)
	let g:sandwich#recipes += [{
		\ 'buns': [a:start, a:end],
		\ 'filetype': ['rust'],
		\ 'input': [a:input],
		\ 'nesting': 1,
		\ 'indent': 1
	\ }]
endf
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
call s:AddRustSandwichBinding('d', 'dbg!(', ')')
call s:AddRustSandwichBinding('o', 'Some(', ')')
call s:AddRustSandwichBinding('r', 'Ok(', ')')
call s:AddRustSandwichBinding('e', 'Err(', ')')
call s:AddRustSandwichBinding('v', 'vec![', ']')
call s:AddRustSandwichBinding('b', 'Box::new(', ')')
call s:AddRustSandwichBinding('B', 'Box<', '>')
call s:AddRustSandwichBinding('O', 'Option<', '>')
call s:AddRustSandwichBinding('R', 'Result<', '>')

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

