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

link() {
  echo "Linking $2 => $PWD/$1"
  ln -sfn "$PWD/$1" "$2"
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
link ghostty/config "$ghostty_path"

### zed ###
zed_dir="$HOME/.config/zed"
mkdir -p "$zed_dir"
remove_file "$zed_dir/settings.json"
link zed/settings.json "$zed_dir/settings.json"

### claude ###
claude_themes_dir="$HOME/.claude/themes"
mkdir -p "$claude_themes_dir"
link claude/themes/orng-dark.json "$claude_themes_dir/orng-dark.json"
