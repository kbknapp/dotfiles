#!/bin/bash

function f_rm_unneeded_kde_main() {
    f_out "Removing unneeded KDE programs"

    sudo zypper remove -y konversation 
}
