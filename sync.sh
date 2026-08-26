#!/bin/bash

### functions ###
remove_dir() {
  echo "Removing $1"
  rm -rf "$1"
}

remove_file() {
  echo "Removing $1"
  rm -f "$1"
}

copy() {
  echo "Copying $1 => $2"
  cp -r "$1" "$2"
}

### nvim ###
nvim_path="$HOME/.config/nvim"
remove_dir "$nvim_path"
copy nvim "$nvim_path"

### zsh ###
copy zsh/zshrc "$HOME/.zshrc"

### herdr ###
herdr_path="$HOME/.config/herdr"
remove_dir "$herdr_path"
copy herdr "$herdr_path"

### wezterm ###
wezterm_path="$HOME/.wezterm.lua"
remove_file "$wezterm_path"
copy wezterm/wezterm.lua "$wezterm_path"

### ghostty ###
ghostty_path="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
remove_file "$ghostty_path"
mkdir -p "$(dirname "$ghostty_path")"
copy ghostty/config "$ghostty_path"

### zed ###
zed_path="$HOME/.config/zed/settings.json"
remove_file "$zed_path"
mkdir -p "$(dirname "$zed_path")"
copy zed/settings.json "$zed_path"
