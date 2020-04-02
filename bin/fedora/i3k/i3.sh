#!/bin/bash

function f_i3_gaps_post() {
    f_out "Configuring i3 Gaps"

    sudo cp ~/.dotfiles/i3/kde/usr/bin/* /usr/bin/
    sudo cp ~/.dotfiles/i3/kde/etc/* /etc
    cp -r ~/.dotfiles/i3/common/home/.local/* ~/.local/
    cp -r ~/.dotfiles/i3/common/home/.config/fontconfig/ ~/.config/
    cp -r ~/.dotfiles/i3/kde/home/.config/i3/ ~/.config/
    cp -r ~/.dotfiles/i3/kde/home/.config/rofi ~/.config/
    cp -r ~/.dotfiles/i3/common/home/.xprofile ~/
    cp -r ~/.dotfiles/i3/common/home/.Xresources ~/
}
