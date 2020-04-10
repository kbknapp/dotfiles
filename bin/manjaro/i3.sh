#!/bin/bash

function f_i3_pre() {
    f_out "Installing i3 Libraries"

    $INSTALL_CMD libx11 libxtst pulseaudio-qt libpulse jsoncpp alsa-lib \
	    wireless_tools libmpdclient libcurl-compat cairo xcb-proto xcb-util \
	    xcb-util-wm xcb-util-image libxcb xcb-util-keysyms xcb-util-xrm \
            yajl libxrandr startup-notification libev xcb-util-cursor \
            libxinerama libxkbcommon libxkbcommon-x11 pcre pango uthash \
	    libxcomposite libxfixes libxdamage libxrender libxext libconfig \
	    libdrm mesa dbus asciidoc desktop-file-utils libxdg-basedir \
            fontconfig freetype2 meson

    f_out "Installing i3 Required Programs"

    $INSTALL_CMD arandr rofi i3status feh
}
