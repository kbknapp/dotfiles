#!/bin/bash

BUILD_DIR=$HOME/.build
NPROC=4

mkdir -pv $HOME/{.bin,bin,.local/bin,.build,Projects,.tmp}

#@TODO 
    # * Check for existing ~/.dotfiles
    # * Copy configs from dotfiles
    # * Check which style of machine


# Install Deps and Software
sudo apt install -y \
    zsh \
    fonts-font-awesome fonts-firacode \
    curl \
    zsh \
    git \
    vim-gtk \
    python-pip \
    arandr \
    vlc \
    tilix \
    git \
    rofi \
    nitrogen \
    i3status i3lock i3lock-fancy \
    build-essential gcc make pkg-config cmake automake libssl-dev \
    libx11-dev libxtst-dev libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-shape0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2 libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev 

sudo chsh -s $(which zsh) kevin

# Rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup default nightly

# Install Alacritty
git clone https://github.com/jwilm/alacritty ${BUILD_DIR}/alacritty
cd ${BUILD_DIR}/alacritty
cargo build --release

dconf load /com/gexperts/Tilix/ < $HOME/.dotfiles/tilix/tilix.dconf

pip install --user rtv

# i3
mkdir -pv ${BUILD_DIR}
git clone https://github.com/Airblader/i3 ${BUILD_DIR}/i3-gaps
cd ${BUILD_DIR}/i3-gaps/
autoreconf --force --install
rm -rf build
mkdir -pv build
cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j${NPROC}
sudo make install

# Polybar
git clone https://github.com/jaagr/polybar ${BUILD_DIR}/polybar
cd ${BUILD_DIR}/polybar/
./build.sh

# KSuperkey
git clone https://github.com/hanschen/ksuperkey.git ${BUILD_DIR}/ksuperkey
cd ${BUILD_DIR}/ksuperkey
make
sudo make install

# @TODO this download is huge, make option to only download the three we need
# can be downloaded from ArchLabs bitbucket
git clone https://github.com/ryanoasis/nerd-fonts ${BUILD_DIR}/nerd-fonts
cd ${BUILD_DIR}/nerd-fonts
./install.sh
fc-cache -f -v

# Install Missing ArchLabs Scripts
cd ${BUILD_DIR}
git clone https://github.com/batmanm0b1E/dots
cp -r ${BUILD_DIR}/dots/extra-config/bin/* $HOME/bin


# @TODO install al-info and friends from ArchLabs Bitbucket pipemenus repo


# Snaps
sudo snap install lxd
sudo snap install freemind
sudo snap install clion --classic

# Flatpaks
bash $HOME/.dotfiles/flatpak/install_flathub
bash $HOME/.dotfiles/flatpak/install_apps

# Rust Apps
bash $HOME/.dotfiles/rust/cargo_install/install_apps

# Remove software we don't care about
sudo apt remove thunderbird fonts-noto-cjk
