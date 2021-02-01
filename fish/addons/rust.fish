# Rust(lang) Settings
# For RLS
# https://github.com/fish-shell/fish-shell/issues/2456

set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx LD_LIBRARY_PATH (rustc +nightly --print sysroot)"/lib:$LD_LIBRARY_PATH"
set -gx RUST_SRC_PATH (rustc --print sysroot)"/lib/rustlib/src/rust/src"
set -gx DYLD_LIBRARY_PATH (rustc --print sysroot)"/lib:$DYLD_LIBRARY_PATH"

# Use sccache
if command -v sccache > /dev/null
  set -gx RUSTC_WRAPPER sccache
end
