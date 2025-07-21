#!/bin/bash

### envvar check ###
if [[ -z "${LINUX_USERNAME}" ]]; then
  echo "Missing LINUX_USERNAME envvar"
  exit 1
fi

if [[ -z "${WINDOWS_USERNAME}" ]]; then
  echo "Missing WINDOWS_USERNAME envvar"
  exit 1
fi

### variables ###
linux_home="/home/$LINUX_USERNAME"
windows_home="/mnt/c/Users/$WINDOWS_USERNAME"
oai_api_key=$(cat "$linux_home/.config/openai/key")

### functions ###
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
sed -i -e "s/OAI_API_KEY/$oai_api_key/g" "$nvim_path/lua/plugins/codecompanion.lua"

### wezterm ###
w11_wezterm_path="$windows_home/.wezterm.lua"
remove_file "$w11_wezterm_path"
copy wezterm/wezterm.lua "$w11_wezterm_path"

### claude ###
copy ai/claude/CLAUDE.md "$linux_home/.claude/CLAUDE.md"

### zsh ###
copy zsh/zshrc "$linux_home/.zshrc"
