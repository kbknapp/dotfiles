#!/bin/bash

function f_flatpak_main() {
	f_out "Installing flatpak"

	$INSTALL_CMD flatpak

	f_flatpak_common
}
