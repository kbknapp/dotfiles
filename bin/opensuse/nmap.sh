#!/bin/bash

function f_nmap_main() {
	f_out "Installing nmap"

	sudo zypper install -y nmap
}
