#!/bin/bash

function f_neovim_appimage() {
    f_check_prog "curl"

    f_out "Installing NeoVIM (nightly) from Appimage"

    curl -LSso ~/.local/bin/nvim https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod +x ~/.local/bin/nvim
}

function f_neovim_common() {
    f_check_prog "nvim"
    f_check_prog "curl"

    f_out "Setting up NeoVIM"

    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cp -r ~/.dotfiles/nvim/ ~/.config/
    nvim +PlugInstall +qall
}
