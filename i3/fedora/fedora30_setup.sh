#!/bin/bash

set -e

BUILD_DIR=$HOME/.build

# Dev Tools
sudo dnf install -y @development-tools

# Compton (yshui fork)
sudo dnf install -y gcc libX11-devel libXcomposite-devel libXfixes-devel libXdamage-devel libXrender-devel libXext-devel libXrandr-devel libXinerama-devel libconfig-devel pcre-devel libdrm-devel mesa-libGL-devel dbus-devel asciidoc desktop-file-utils meson uthash-devel libxdg-basedir-devel cmake

mkdir -p "${BUILD_DIR}"/compton
git clone https://github.com/yshui/compton "${BUILD_DIR}"/compton/yshui-compton
cd "${BUILD_DIR}"/compton/yshui-compton

# i3-gaps
sudo dnf install -y gcc asciidoc automake bison cairo-devel flex libev-devel libX11-devel libxcb-devel libXcursor-devel libxkbcommon-x11-devel libxkbfile-devel pango-devel pcre-devel perl-generators startup-notification-devel xcb-proto xcb-util-cursor-devel xcb-util-devel xcb-util-keysyms-devel xcb-util-wm-devel xcb-util-xrm-devel xmlto yajl-devel

mkdir -p "${BUILD_DIR}"/i3
cd "${BUILD_DIR}"/i3
git clone https://github.com/Airblader/i3 "${BUILD_DIR}"/i3/i3-gaps
cd "${BUILD_DIR}"/i3/i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build/
cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j8
sudo make install

# Extras
sudo dnf install arandr rofi nitrogen i3status i3lock

# Polybar
sudo dnf install -y alsa-lib-devel binutils cairo-devel clang cmake cmake-data git jsoncpp-devel libcurl-devel libmpdclient-devel libxcb-devel pulseaudio-libs-devel python2 wireless-tools-devel xcb-proto xcb-util-image-devel xcb-util-wm-devel xcb-util-xrm-devel

git clone https://github.com/jaagr/polybar "${BUILD_DIR}"/polybar

cd "${BUILD_DIR}"/polybar
./build.sh -f -g --all-features

# KSuperKey
sudo dnf install -y libXtst-devel
git clone https://github.com/hanschen/ksuperkey.git "${BUILD_DIR}"/ksuperkey
cd "${BUILD_DIR}"/ksuperkey
make
sudo make install

# Alacritty

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

