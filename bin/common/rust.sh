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

    if [ -e ~/.cargo/env ]; then
        source ~/.cargo/env
    fi
    f_check_prog "cargo"

    f_out "Compiling and installing Rust applications"

    _RUST_WRAPPERS=$(dialog --checklist "Which Rust Wrappers?" 400 400 15 \
	  "sccache" "Cache Build Artifacts" on \
        --output-fd 1)
    clear

    _CARGO_PLUGINS=$(dialog --checklist "Which cargo plugins?" 400 400 19 \
	  "cargo-outdated" "Display out of date dependencies" on \
	  "cargo-tree" "" on \
	  "cargo-about" "more info about deps" on \
	  "cargo-modules" "" off \
	  "cargo-cache" "" on \
	  "cargo-crev" "Dependency Audit and Review" on \
	  "cargo-graph" "Generate dependency graphs" off \
	  "cargo-deps" "Generate dependency graphs" off \
	  "cargo-edit" "Edit dependencies from the CLI" on \
	  "cargo-geiger" "Unsafe statistics about deps" on \
	  "cargo-bloat" "" on \
	  "cargo-udeps" "Find unused deps" on \
	  "cargo-thanks" "Star your deps" off \
	  "cargo-audit" "Security Notifications" on \
	  "cargo-update" "Update cargo-install'ed binaries" on \
	  "cargo-expand" "Expand macros" on \
	  "cargo-deny" "Dep graph lints" on \
	  "cargo-license" "" on \
	  "cargo-lichking" "Display license info for deps" on \
	  "cargo-count" "Count lines of code" off \
	  "cargo-sweep" "Clean out old build artifacts" off \
	  "cargo-call-stack" "Generate Call Graphs" on \
        --output-fd 1)
    clear

    _RUST_DEV_TOOLS=$(dialog --checklist "Which Rust Dev Tools?" 400 400 15 \
	  "amber" "Code Search and Replace" on \
	  "clog-cli" "Change Log" on \
	  "racer" "Rust completion support" on \
	  "rusty-tags" "tags support" on \
	  "just" "modern make" on \
	  "gitui" "A TUI for git" on \
	  "git-absorb" "Auto fixup and rebase in git" on \
	  "tokei" "Fast Line Count" on \
	  "watchexec" "Run command on file change" on \
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
	  "starship"       "shell prompt" off \
	  "mdcat"          "cat for markdown" on \
	  "topgrade"       "upgrade everything" on \
	  "handlr"         "xdg-utils alternative" on \
	  "bingrep"        "" on \
	  "strace-analyzer" "" on \
	  "mprober"        "Kernel prob utility" on \
	  "battop"         "Battery Top" on \
	  "gptman"         "" on \
	  "broot"          "interactive tree" on \
	  "dupe-krill"    "file deduplicator" on \
	  "xcompress"      "Compression utility" on \
	  "ruplacer"       "find and replace" on \
	  "fastmod"        "find and replace" on \
	  "ttdl"           "todo list" on \
	  "genact"         "activity generator" off \
	  "grex"           "regex builder" on \
	  "bandwhich"      "bandwidth monitor" on \
	  "ffsend" 	       "firefox send from cli" on \
	  "pastel"         "Get color info in your terminal" on \
	  "miniserve"      "Mini HTTP server" on \
	  "wasm-pack"      "" on \
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

    _RUST_TOOLS_GIT=$(dialog --checklist "Which Rust from git repos?" 400 400 25 \
	  "cjbassi/ytop"       "top like TUI" on \
	  "denisidoro/navi"    "command search" on \
	  "getzola/zola"       "static site generator" on \
        --output-fd 1)
    clear

    cargo install $_RUST_WRAPPERS || true
    # If sccache was installed we need to set the env vars
    # so that all the other cargo-installed and built packages
    # take advantage of it
    if [[ " ${_RUST_WRAPPERS[@]} " =~ " sccache " ]]; then
      export RUSTC_WRAPPER=sccache
    fi
    cargo install $_CARGO_PLUGINS || true
    cargo install $_RUST_DEV_TOOLS || true
    cargo install $_RUST_CORE_TOOLS || true
    cargo install $_RUST_DISK_TOOLS || true
    cargo install $_RUST_MISC_TOOLS || true
    cargo install $_RUST_TOP_TOOLS || true
    cargo install $_RUST_DATA_TOOLS || true

    for TOOL in "${_RUST_TOOLS_GIT[@]}"; do
      cargo install --git https://github.com/${TOOL} || true
    done
}

function f_rust_main {
    f_check_prog "curl"

    f_out "Installing and setting up Rust"

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.cargo/env
    rustup default nightly
    rustup component add rust-src
}


