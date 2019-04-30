#!/bin/bash

set -e

mkdir -pv "${HOME}/{.bin,bin,.local/bin,.build,Projects,.tmp}"

# Install Deps and Software
sudo apt install -y \
    zsh \
    fonts-font-awesome fonts-firacode \
    curl \
    zsh \
    git \
    vim-gtk \
    python-pip \
    vlc \
    tilix \
    git \
    flatpak \
    snapd \
    dconf-cli \
    build-essential gcc make pkg-config cmake automake libssl-dev

# clone dotifles if they don't exist yet
if [ ! -d "${HOME}/.dotfiles" ]; then
    git clone https://github.com/kbknapp/dotfiles .dotfiles
fi

# change the default shell
sudo chsh -s "$(command -v zsh)" kevin

# Install Rust
if [ ! -d "${HOME}/.cargo" ]; then
    curl https://sh.rustup.rs -sSf | sh
fi

# Set default Rust toolchain
# shellcheck source=../../.cargo/env
source "${HOME}/.cargo/env"
rustup default nightly

pip install --user rtv

# Load Tilix settings
dconf load /com/gexperts/Tilix/ < "${HOME}/.dotfiles/tilix/tilix.dconf"

# Flatpaks
bash "${HOME}/.dotfiles/flatpak/install_flathub"
bash "${HOME}/.dotfiles/flatpak/install_apps"

# Rust Apps
bash "${HOME}/.dotfiles/rust/cargo_install/install_apps"

# Snaps
sudo snap install lxd
sudo snap install freemind
sudo snap install clion --classic

# Remove software we don't care about
sudo apt remove thunderbird fonts-noto-cjk
