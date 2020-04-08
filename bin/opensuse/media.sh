#!/bin/bash

function f_media_main {
    f_out "Setting up Packman Repositories"

    sudo zypper ar -f http://opensuse-guide.org/repo/openSUSE_Tumbleweed/ libdvdcss || true
    sudo zypper ref
    sudo zypper install --allow-vendor-change -f libxine2-codecs ffmpeg-4  dvdauthor gstreamer-plugins-bad \
    gstreamer-plugins-bad-orig-addon gstreamer-plugins-base  gstreamer-plugins-good \
    gstreamer-plugins-good-extra gstreamer-plugins-libav gstreamer-plugins-ugly \
    gstreamer-plugins-ugly-orig-addon vlc smplayer x264 x265 vlc-codecs \
    vlc-codec-gstreamer ogmtools libavcodec58 gstreamer-plugins-vaapi

}
