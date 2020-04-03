#!/bin/bash

function f_get_common_components() {
    _COMPONENTS=$(dialog --checklist "Which Common Components?" 400 400 32 \
       ansible "Ansible" off \
       fish "Fish Shell" off \
       intel_undervolt "Intel-Undervolt" off \
       steam "Steam" off \
       virt "Virtualization" off \
       home_dirs "Common Home Dirs" on \
       fonts "Fonts" on \
       curl "curl" on \
       zsh "ZSH" on \
       wireguard "Wireguard" on \
       pip3 "Python3 pip" on \
       vlc "VLC" on \
       git "git" on \
       nmap "Nmap" on \
       shellcheck "ShellCheck" on \
       ranger "Ranger" on \
       emacs "Emacs" on \
       vim "VIM" on \
       neovim "NeoVIM" on \
       build_tools "Built Tools" on \
       rust "Rust" on \
       rm_unneeded "Remove Unneeded" on \
       flameshot "Flameshot" on \
       misc_small "Misc Small Tools" on \
       nvidia "Nvidia" on \
       alacritty "Alacritty" on \
       docker "Docker" on \
       flatpak "Flatpak" on \
       flatpak_apps "FlatPak Apps" on \
       snapd "Snapd" on \
       snap_apps "Snap Apps" on \
       rust_apps "Compile Rust Apps" on \
        --output-fd 1)
    clear

    readonly _COMPONENTS
}
