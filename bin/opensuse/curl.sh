#!/bin/bash

function f_curl_main() {
    f_out "Installing curl"

    sudo zypper install -y curl
}
