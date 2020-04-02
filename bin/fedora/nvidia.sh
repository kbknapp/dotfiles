#!/bin/bash

function f_nvidia_main {
    f_out "Setting up Nvidia Drivers"

    sudo dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
    sudo dnf install -y xorg-x11-drv-nvidia akmod-nvidia xorg-x11-drv-nvidia-cuda \
      vulkan xorg-x11-drv-nvidia-cuda-libs vdpauinfo libva-vdpau-driver libva-utils
}
