#!/bin/bash

function f_polybar_post() {
	f_out "Configuring Polybar"

	cp -r ~/.dotfiles/polybar ~/.config
}
