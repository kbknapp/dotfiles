#!/bin/bash

function f_i3_pre() {
    f_out "Installing i3 Libraries"

    sudo zypper install -y libX11-devel libXtst-devel jsoncpp-devel libmpdclient-devel \
        libcurl-devel cairo-devel  xcb-util-devel xcb-util-wm-devel xcb-util-image-devel \
        libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel \
        xcb-util-xrm-devel libXrandr-devel startup-notification-devel libev-devel \
        xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel \
        pcre-devel pango-devel uthash-devel libX11-devel libXcomposite-devel \
        libXfixes-devel libXdamage-devel libXrender-devel libXext-devel libXrandr-devel \
        libXinerama-devel libconfig-devel pcre-devel libdrm-devel Mesa-libGL-devel  \
        desktop-file-utils uthash-devel libxdg-basedir-devel fontconfig-devel \
        freetype-devel libyajl-devel dbus-1-devel

    f_out "Installing i3 Required Programs"

    sudo zypper install -y arandr rofi i3status feh
}
