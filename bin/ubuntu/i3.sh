#!/bin/bash

function f_i3_pre() {
    f_out "Installing i3 Libraries"

    $INSTALL_CMD libev-libevent-dev libdbus-1-dev libgl1-mesa-dev \
	  libxcb-present-dev libxcb-sync-dev libxcb-damage0-dev \
	  libx11-xcb-dev libev-dev uthash-dev libxdg-basedir-dev \
	  libconfig-dev libxcb-render-util0-dev libxcb-composite0-dev \
	  libxcb-image0-dev libxcb-xinerama0-dev libpixman-1-dev \
	  libpcre3-dev meson autoconf pkg-config \
	  libstartup-notification0-dev libxcb-xkb-dev libxcb-util-dev \
	  libxcb-cursor-dev libxcb-keysyms1-dev libxcb-icccm4-dev \
	  libxcb-xrm-dev libxkbcommon-x11-dev libxkbcommon-dev \
	  libyajl-dev libcairo2-dev libpango1.0-dev libxtst-dev \
	  libxcb-glx0-dev

    f_out "Installing i3 Required Programs"

    $INSTALL_CMD arandr rofi i3status feh i3lock i3lock-fancy 
}
