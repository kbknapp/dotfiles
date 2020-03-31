#!/bin/bash

function f_emacs_main() {
    f_out "Installing and setting up Emacs"

    sudo dnf install -y emacs 
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install

    cp ~/.dotfiles/doom-emacs/* ~/.doom.d/
    ~/.emacs.d/bin/doom sync
    ~/.emacs.d/bin/doom build
}
