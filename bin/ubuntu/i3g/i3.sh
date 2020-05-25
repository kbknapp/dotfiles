#!/bin/bash

function f_i3_gaps_post() {
    f_out "Configuring i3 Gaps"

    sudo cp ~/.dotfiles/i3/regolith/usr/bin/* /usr/bin/
    sudo cp ~/.dotfiles/i3/regolith/etc/* /etc
    cp -r ~/.dotfiles/i3/regolith/home/.config/* ~/.config
    cp -r ~/.dotfiles/i3/common/home/.local/* ~/.local/
    cp -r ~/.dotfiles/i3/common/home/.config/fontconfig/ ~/.config/
}
