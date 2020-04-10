#!/bin/bash

function f_rust_apps_common() {
	# Fedora Deps
	#   sudo dnf install clang llvm llvm-devel cmake pkg-config openssl-devel
	# Ubuntu Deps
	#   sudo apt install clang llvm llvm-dev cmake pkg-config libssl-dev
	#
	# Keep eye on:
	#   xv            `# hex viewer` \
	#
	# Not Working Deps:
	#   sudo apt install libgstreamer1.0-dev
	#   sudo apt install libqt5gstreamer-dev
	#   sudo apt install libncursesw5-dev
	#
	# Not Working:
	#   hunter (=ranger in rust) (missing gstreamer-1.0)
	#   process-viewer (ps gui) (not found)
	#   lolcate-rs (=locate) (rust error)
	#   sear: signed and encrypted archive
	#   snifflue:  tcpdump/wireshark (missing seccomp)
	#   cargo install --git https://github.com/cjbassi/ytop ytop

    if [ -e ~/.cargo/env ]; then
        source ~/.cargo/env
    fi
    f_check_prog "cargo"

    f_out "Compiling and installing Rust applications"

    _CARGO_PLUGINS=$(dialog --checklist "Which cargo plugins?" 400 400 15 \
	  "cargo-outdated" "" on \
	  "cargo-tree" "" on \
	  "cargo-modules" "" on \
	  "cargo-cache" "" on \
	  "cargo-graph" "" on \
	  "cargo-edit" "" on \
	  "cargo-geiger" "" on \
	  "cargo-bloat" "" on \
	  "cargo-thanks" "" on \
	  "cargo-audit" "" on \
	  "cargo-update" "" on \
	  "cargo-expand" "" on \
	  "cargo-deny" "" on \
	  "cargo-license" "" on \
	  "cargo-lichking" "" on \
	  "cargo-count" "" off \
        --output-fd 1)
    clear

    _RUST_DEV_TOOLS=$(dialog --checklist "Which Rust Dev Tools?" 400 400 15 \
	  "amber" "Code Search and Replace" on \
	  "clog-cli" "Change Log" on \
	  "racer" "Rust completion support" on \
	  "rusty-tags" "tags support" on \
	  "just" "modern make" on \
	  "tokei" "Fast Line Count" on \
        --output-fd 1)
    clear

    _RUST_CORE_TOOLS=$(dialog --checklist "Which Rust core tools?" 400 400 15 \
	  "exa"      "fancy ls" on \
	  "fd-find"  "modern find" on \
	  "ripgrep"  "modern grep" on \
	  "cw"       "wc clone" on \
	  "bat"      "pretty cat" on \
	  "lsd"      "fancy ls" on \
	  "diffr"    "diff clone" on \
	  "sd"       "sed clone" on \
	  "procs"    "ps clone" on \
	  "xcp"      "cp clone" on \
	  "rm-improved" "" on   \
	  "tree-rs"  "tree clone " on \
	  "rargs" "xargs and awk type tool" on \
	  "runiq" "uniq clone" on \
        --output-fd 1)
    clear

    _RUST_DISK_TOOLS=$(dialog --checklist "Which Rust disk tools?" 400 400 15 \
	  "du-dust" "du clone" on \
	  "diskus"  "Disk Usage info" on \
	  "dutree"  "du clone" on \
	  "tin-summer" "sn" on \
	  "dua-cli" "" on \
	  "dirstat-rs" "" on \
        --output-fd 1)
    clear

    _RUST_MISC_TOOLS=$(dialog --checklist "Which Rust misc tools?" 400 400 25 \
	  "hyperfine"      "Benchmarking" on \
	  "skim"           "fzf clone" on \
	  "mdbook"         "write books in MD" on \
	  "toast"          "Build using Docker" on \
	  "starship"       "shell prompt" on \
	  "mdcat"          "cat for markdown" on \
	  "topgrade"       "upgrade everything" on \
	  "bingrep" "" on \
	  "strace-analyzer" "" on \
	  "mprober"        "Kernel prob utility" on \
	  "battop"         "Battery Top" on \
	  "gptman" "" on \
	  "broot"          "interactive tree" on \
	  "dupe-krill"    "file deduplicator" on \
	  "xcompress"      "Compression utility" on \
	  "ruplacer"       "find and replace" on \
	  "fastmod"        "find and replace" on \
	  "ttdl"           "todo list" on \
	  "genact"         "activity generator" on \
	  "grex"           "regex builder" on \
	  "bandwhich"      "bandwidth monitor" on \
	  "ffsend" 	"firefox send from cli" on \
	  "pastel"         "Get color info in your terminal" on \
	  "miniserve"      "Mini HTTP server" on \
	  "tealdeer"       "tldr" on \
        --output-fd 1)
    clear

    _RUST_TOP_TOOLS=$(dialog --checklist "Which Rust top-like tools?" 400 400 25 \
	  "bottom"         "top like tui" on \
        --output-fd 1)
    clear

    _RUST_DATA_TOOLS=$(dialog --checklist "Which Rust data tools?" 400 400 25 \
	  "jql"            "json handling" on \
	  "xsv"            "csv handling" on \
	  "hexyl"          "Hex Viewer" on \
	  "hx"             "Hex Viewer" on \
        --output-fd 1)
    clear

    cargo install "$_CARGO_PLUGINS[@]" || true
    cargo install "$_RUST_DEV_TOOLS[@]" || true
    cargo install "$_RUST_CORE_TOOLS[@]" || true
    cargo install "$_RUST_DISK_TOOLS[@]" || true
    cargo install "$_RUST_MISC_TOOLS[@]" || true
    cargo install "$_RUST_TOP_TOOLS[@]" || true
    cargo install "$_RUST_DATA_TOOLS[@]" || true
}

function f_rust_main {
    f_check_prog "curl"

    f_out "Installing and setting up Rust"

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.cargo/env
    rustup default nightly
    rustup component add rust-src
}


