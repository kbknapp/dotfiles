#!/bin/bash

function f_emacs_common() {
    f_check_prog "git"

    f_out "Setting up Doom-Emacs"

    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d || true
    ~/.emacs.d/bin/doom install

    cp ~/.dotfiles/doom-emacs/* ~/.doom.d/
    ~/.emacs.d/bin/doom sync
    ~/.emacs.d/bin/doom build
}
