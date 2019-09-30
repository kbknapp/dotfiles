" =========
" ==== RUST
" =========

" Follow Rust code style rules
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100

" <leader>= reformats current tange
nnoremap <leader>= :'<,'>RustFmtRange<cr>

" ---- Rusty Tags
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi

" linter
let g:ale_rust_rls_config = {
	\ 'rust': {
		\ 'all_targets': 1,
		\ 'build_on_save': 1,
		\ 'clippy_preference': 'on'
	\ }
	\ }
let g:ale_rust_rls_toolchain = 'nightly'
let g:ale_linters = {'rust': ['rls']}

" racer + rust
" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
"let g:racer_cmd = "/usr/bin/racer"
"let g:racer_experimental_completer = 1
let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

noremap <leader>rc :!RUSTFLAGS='-Awarnings' cargo check<CR>
noremap <leader>rb :Cbuild<CR>
noremap <leader>rt :Ctest<CR>
noremap <leader>rr :Cbuild --release<CR>


