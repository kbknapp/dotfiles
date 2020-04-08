#!/bin/bash

function f_de_post() {
    f_out "Finalizing i3 (Gnome) Setup"

    sudo cp ~/.dotfiles/i3/common/usr/bin/* /usr/bin
    cp -r ~/.dotfiles/i3/common/home/.local/* ~/.local
    cp -r ~/.dotfiles/i3/common/home/.config/* ~/.config/
    cp -r ~/.dotfiles/i3/regolith/home/.config/* ~/.config/
}
