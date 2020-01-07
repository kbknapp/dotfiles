#!/bin/bash

# exit on error
set -e

# Set this!
MACHINE=

if [ -z "${MACHINE}" ]; then
    echo "No '$MACHINE' set"
    exit 1
fi

# Deps?
#
# libxtst-dev libx11-dev libxtst-dev  \
#    libxcb-image0-dev \
#   libxcb-randr0-dev libxcb-shape0-dev  \
#   libxcb-composite0-devb \
#   libxcb-ewmh2 libxcb-randr0-dev libev-dev libxcb-xinerama0-dev \


BUILD_DIR=$HOME/.build
NPROC=4
DOT_I3_XUBUNTU=$HOME/.dotfiles/i3/xubuntu/
COMMON_HOME="${DOT_I3_XUBUNTU}/common/home"
MACHINE_HOME="${DOT_I3_XUBUNTU}/${MACHINE}/home"

sudo apt install -y git

# clone dotifles if they don't exist yet
if [ ! -d "${HOME}/.dotfiles" ]; then
    git clone https://github.com/kbknapp/dotfiles .dotfiles
fi

bash "${HOME}"/.dotfiles/bin/baseline_xubuntu.sh

# Use an active fork of Compton
sudo apt install libev-libevent-dev libdbus-1-dev libgl1-mesa-dev \
  libxcb-present-dev libxcb-sync-dev libxcb-damage0-dev \
  libx11-xcb-dev libev-dev uthash-dev libxdg-basedir-dev \
  libconfig-dev libxcb-render-util0-dev libxcb-composite0-dev \
  libxcb-image0-dev libxcb-xinerama0-dev libpixman-1-dev \
  libpcre3-dev meson

cd "${BUILD_DIR}"
git clone https://github.com/yshui/compton
cd compton/
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

cp "${COMMON_HOME}/.config/compton.conf" "${HOME}/.config"

# Set default Rust toolchain
# shellcheck source=../../bin/baseline_xubuntu.sh
source "${HOME}"/.cargo/env
rustup default nightly

# Install Alacritty
sudo apt install -y libfreetype6-dev
git clone https://github.com/jwilm/alacritty "${BUILD_DIR}"/alacritty
cd "${BUILD_DIR}"/alacritty
cargo build --release
cp target/release/alacritty "${HOME}"/.local/bin

# i3-gaps
# Install Deps and Software
sudo apt install -y \
    arandr \
    rofi \
    nitrogen \
    i3status i3lock i3lock-fancy autoconf pkg-config \
    libstartup-notification0-dev libxcb-xkb-dev libxcb-util-dev \
    libxcb-cursor-dev libxcb-keysyms1-dev libxcb-icccm4-dev \
    libxcb-xrm-dev libxkbcommon-x11-dev libxkbcommon-dev \
    libyajl-dev libcairo2-dev libpango1.0-dev

mkdir -pv "${BUILD_DIR}"
git clone https://github.com/Airblader/i3 "${BUILD_DIR}"/i3-gaps
cd "${BUILD_DIR}"/i3-gaps/
autoreconf --force --install
rm -rf build
mkdir -pv build
cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j"${NPROC}"
sudo make install

# Polybar
sudo apt install -y \
	libasound2-dev libcurl4-openssl-dev libmpdclient-dev \
	libiw-dev libpulse-dev xcb-proto xcb libxcb-ewmh-dev \
	python-xcbgen libcairo2-dev libxcb-composite0-dev \
  libxcb-randr0-dev libxcb-image0-dev libxcb-icccm4-dev \
  libxcb-util0-dev

git clone https://github.com/jaagr/polybar "${BUILD_DIR}"/polybar
cd "${BUILD_DIR}"/polybar/
./build.sh -f -g --all-features

# KSuperkey
git clone https://github.com/hanschen/ksuperkey.git "${BUILD_DIR}"/ksuperkey
cd "${BUILD_DIR}"/ksuperkey
make
sudo make install

# Copy all configs
cp -r "${COMMON_HOME}"/.config "${HOME}"/
cp -r "${MACHINE_HOME}"/.config "${HOME}"/

# Fonts
  # This download is huge, 1.8G (instead we just get the few fonts we need)
  #git clone https://github.com/ryanoasis/nerd-fonts ${BUILD_DIR}/nerd-fonts
  #cd ${BUILD_DIR}/nerd-fonts
  #./install.sh
cp -r "${MACHINE_HOME}"/.local/share/fonts "${HOME}"/.local/share
fc-cache -f -v

# Install Missing ArchLabs Scripts
cp -r "${COMMON_HOME}"/bin "${HOME}"

