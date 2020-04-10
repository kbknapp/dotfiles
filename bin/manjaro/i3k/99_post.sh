#!/bin/bash

function f_de_post() {
    f_out "Finalizing i3 (KDE) Setup"

    sudo cp ~/.dotfiles/i3/common/usr/bin/* /usr/bin
    cp -r ~/.dotfiles/i3/common/home/.local/* ~/.local/
    cp -r ~/.dotfiles/i3/common/home/.config/fontconfig/ ~/.config/
    cp -r ~/.dotfiles/i3/common/home/.xprofile ~/
    cp -r ~/.dotfiles/i3/common/home/.Xresources ~/
    sudo cp ~/.dotfiles/i3/kde/usr/bin/* /usr/bin/
    sudo cp ~/.dotfiles/i3/kde/etc/* /etc
    cp -r ~/.dotfiles/i3/kde/home/.config/* ~/.config/
}
