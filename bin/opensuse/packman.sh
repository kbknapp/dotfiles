#!/bin/bash

function f_packman_main {
    f_out "Setting up Packman Repositories"
    
    sudo zypper ar -cfp 89 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman || true
    sudo zypper ref
}
