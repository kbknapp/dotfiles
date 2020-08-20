#!/bin/bash

function f_get_common_components() {
    _COMPONENTS=$(dialog --checklist "Which Common Components?" 400 400 36 \
       home_dirs "Common Home Dirs" on \
       vscode "VSCode" on \
       curl "curl" on \
       git "git" on \
       build_tools "Built Tools" on \
       ansible "Ansible" off \
       fish "Fish Shell" off \
       intel_undervolt "Intel-Undervolt" off \
       steam "Steam" off \
       virt "Virtualization" off \
       fonts "Fonts" on \
       zsh "ZSH" on \
       wireguard "Wireguard" on \
       pip3 "Python3 pip" on \
       vlc "VLC" on \
       nmap "Nmap" on \
       shellcheck "ShellCheck" on \
       ranger "Ranger" on \
       emacs "Emacs" on \
       vim "VIM" on \
       neovim "NeoVIM" on \
       rust "Rust" on \
       rm_unneeded "Remove Unneeded" on \
       flameshot "Flameshot" on \
       misc_small "Misc Small Tools" on \
       nvidia "Nvidia" off \
       amdgpu "AMD GPU" off \
       alacritty "Alacritty" on \
       docker "Docker" on \
       rtv "Reddit Terminal Viewer" on \
       flatpak "Flatpak" on \
       flatpak_apps "FlatPak Apps" on \
       snapd "Snapd" on \
       snap_apps "Snap Apps" on \
       rust_apps "Compile Rust Apps" on \
        --output-fd 1)
    clear

    readonly _COMPONENTS
}
