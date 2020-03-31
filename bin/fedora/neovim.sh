#!/bin/bash

function f_neovim_main() {
    f_check_prog "curl"

    f_out "Installing and setting up NeoVIM"

    sudo dnf install -y neovim python3-neovim fzf ctags
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cp -r ~/.dotfiles/nvim/ ~/.config/
    nvim +PlugInstall +qall
}
