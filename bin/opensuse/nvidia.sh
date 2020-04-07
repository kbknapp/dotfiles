#!/bin/bash

function f_nvidia_main {
    f_out "Setting up Nvidia Drivers"

    sudo zypper addrepo --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA
    sudo zypper ref
    sudo zypper install -y x11-video-nvidiaG05
}
