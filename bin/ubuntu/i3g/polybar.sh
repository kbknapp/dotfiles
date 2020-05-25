#!/bin/bash

function f_polybar_pre() {
    f_out "Installing Polybar Build Deps"

    # @TODO this only works on ubuntu, needs to factored into a
    # f_polbar_pre function that is OS relative
    $INSTALL_CMD libcairo2-dev libasound2-dev libcurl4-openssl-dev \
      libmpdclient-dev libiw-dev libpulse-dev libxcb-composite0-dev \
      xcb-proto libxcb-icccm4-dev libxcb-ewmh-dev libxcb-util-dev \
      python3-xcbgen libjsoncpp-dev
}
