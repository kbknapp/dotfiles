#!/bin/bash

function f_get_common_components() {
    _COMPONENTS=$(dialog --checklist "Which Common Components?" 400 400 32 \
       home_dirs "Common Home Dirs" on \
       fonts "Fonts" on \
       curl "curl" on \
       ansible "Ansible" off \
       zsh "ZSH" on \
       wireguard "Wireguard" on \
       fish "Fish Shell" off \
       pip3 "Python3 pip" on \
       vlc "VLC" on \
       git "git" on \
       flatpak "Flatpak" on \
       snapd "Snapd" on \
       shellcheck "ShellCheck" on \
       ranger "Ranger" on \
       emacs "Emacs" on \
       vim "VIM" on \
       neovim "NeoVIM" on \
       rust "Rust" on \
       build_tools "Built Tools" on \
       rm_unneeded "Remove Unneeded" on \
       flameshot "Flameshot" on \
       misc_small "Misc Small Tools" on \
       rust_apps "Compile Rust Apps" on \
       flatpak_apps "FlatPak Apps" on \
       steam "Steam" off \
       nvidia "Nvidia" on \
       alacritty "Alacritty" on \
       virt "Virtualization" off \
       intel_undervolt "Intel-Undervolt" off \
       docker "Docker" on \
       snap_apps "Snap Apps" on \
        --output-fd 1)

    readonly _COMPONENTS
}
