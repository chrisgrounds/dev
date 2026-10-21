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

### OS detection ###
case "$(uname -s)" in
  Darwin*) OS="macos" ;;
  Linux*)  OS="linux" ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

echo "Detected OS: $OS"

### nvim ###
nvim_path="$HOME/.config/nvim"
remove_dir "$nvim_path"
mkdir -p "$HOME/.config"
copy nvim "$nvim_path"

### zsh ###
copy zsh/zshrc "$HOME/.zshrc"

### herdr ###
herdr_path="$HOME/.config/herdr"
remove_dir "$herdr_path"
mkdir -p "$HOME/.config"
copy herdr "$herdr_path"

### wezterm ###
wezterm_path="$HOME/.wezterm.lua"
remove_file "$wezterm_path"
copy wezterm/wezterm.lua "$wezterm_path"

### ghostty ###
if [ "$OS" = "macos" ]; then
  ghostty_path="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
else
  ghostty_path="$HOME/.config/ghostty/config"
fi
remove_file "$ghostty_path"
mkdir -p "$(dirname "$ghostty_path")"
link ghostty/config "$ghostty_path"

### zed ###
if [ "$OS" = "macos" ]; then
  zed_dir="$HOME/Library/Application Support/Zed"
else
  zed_dir="$HOME/.config/zed"
fi
mkdir -p "$zed_dir"
remove_file "$zed_dir/settings.json"
link zed/settings.json "$zed_dir/settings.json"

### claude ###
claude_themes_dir="$HOME/.claude/themes"
mkdir -p "$claude_themes_dir"
link claude/themes/orng-dark.json "$claude_themes_dir/orng-dark.json"
