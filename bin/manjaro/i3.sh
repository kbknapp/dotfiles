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

function f_i3_gaps_aur_pre() {
    f_out "Installing i3 Required Programs"

    $INSTALL_CMD arandr rofi i3status feh
}

function f_i3_gaps_aur_main() {
	f_out "Installing i3 Gaps from AUR"

	if command -v rua 2>/dev/null ;then
		rua install i3-gaps-next-git
		return
	fi
	if command -v yay 2>/dev/null ;then
		yay -a -S i3-gaps-next-git
		return
	fi
	if command -v aura 2>/dev/null ;then
		sudo aura -A i3-gaps-next-git
	fi
}


function f_i3_post() {
    f_out "Configuring i3 Gaps"

}
