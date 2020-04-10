#!/bin/bash

function f_misc_small_main() {
    f_out "Installing various common programs"

    $INSTALL_CMD exfat-utils p7zip pv unrar youtube-dl meld \
        sshfs wavemon borg iotop nload ncdu xfsprogs
}
