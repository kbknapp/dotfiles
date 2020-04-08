#!/bin/bash

function f_misc_small_main() {
    f_out "Installing various common programs"

    $INSTALL_CMD exfat-fuse p7zip-full \
        pv python3-dev unar youtube-dl meld \
        exfat-utils sshfs wavemon \
        borgbackup iotop nload ncdu xfsprogs
}
