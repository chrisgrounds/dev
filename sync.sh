#!/bin/bash

### variables ###
linux_home="/home/chrisgrounds"
windows_home="/mnt/c/Users/chris.grounds"

remove_dir() {
	echo "Removing $1"
	rm -rf $1
}

remove_file() {
	echo "Removing $1"
	rm $1
}

copy() {
	echo "Copying $1 => $2"
	cp -r $1 $2
}

### nvim ###
nvim_path="$linux_home/.config/nvim"
remove_dir "$nvim_path"
copy nvim "$nvim_path"

### wezterm ###
w11_wezterm_path="$windows_home/.wezterm.lua"
remove_file "$w11_wezterm_path"
copy wezterm/.wezterm.lua "$w11_wezterm_path"

