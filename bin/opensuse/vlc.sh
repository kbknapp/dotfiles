#!/bin/bash

function f_vlc_main() {
    f_out "Installing VLC"

    sudo zypper install --allow-vendor-change vlc vlc-codecs vlc-codec-gstreamer 
}
