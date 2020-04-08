#!/bin/bash

function f_nvidia_main {
    f_out "Setting up Nvidia Drivers"

    $INSTALL_CMD nvidia-driver-440 nvidia-prime
}
