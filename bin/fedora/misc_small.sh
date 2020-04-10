#!/bin/bash

function f_misc_small_main() {
    f_out "Installing various common programs"

    sudo dnf install -y ffmpeg fuse-exfat openssh-askpass p7zip \
        p7zip-plugins python3-devel unar arc-theme youtube-dl meld \
        exfat-utils fuse-sshfs lm_sensors pv util-linux-user wavemon \
        borgbackup iotop nload ncdu xfsprogs
}
