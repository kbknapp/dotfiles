#!/bin/bash

function f_rpm_fusion_main {
    f_out "Setting up RPM Fusion Repositories"
    
    sudo dnf install -y \
        https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y fedora-workstation-repositories rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
    sudo dnf groupupdate -y multimedia sound-and-video
}
