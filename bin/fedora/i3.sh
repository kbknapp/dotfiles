#!/bin/bash

function f_i3_pre() {
    f_out "Installing i3 Libraries"

    sudo dnf install -y libX11-devel libXtst-devel pulseaudio-libs-devel \
        jsoncpp-devel alsa-lib-devel wireless-tools-devel libmpdclient-devel \
        libcurl-devel cairo-devel xcb-proto xcb-util-devel xcb-util-wm-devel \
        xcb-util-image-devel libxcb-devel xcb-util-keysyms-devel xcb-util-xrm-devel \
	yajl-devel startup-notification-devel libev-devel xcb-util-cursor-devel \
        libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel \
        pango-devel uthash-devel libX11-devel libXcomposite-devel libXfixes-devel \
        libXdamage-devel libXrender-devel libXext-devel libXrandr-devel \
        libconfig-devel libdrm-devel mesa-libGL-devel dbus-devel asciidoc \
	desktop-file-utils libxdg-basedir-devel fontconfig-devel freetype-devel meson

    f_out "Installing i3 Required Programs"

    sudo dnf install -y arandr rofi i3status feh
}
