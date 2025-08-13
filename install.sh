#!/bin/bash

dependencies=(
  "ripgrep"
  "fzf"
  "bat"
  "neovim"
  "zsh"
  "clang"
)

update_apt() {
  sudo apt update && sudo apt upgrade
}

install_packages() {
  local packages=("$@")
  sudo apt update && sudo apt install -y "${packages[@]}"
}

install_oh_my_zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

main() {
  echo "Updating apt"
  update_apt

  echo "Installing dependencies: ${dependencies[*]}"
  install_packages "${dependencies[@]}"

  echo "Installing ohmyzsh"
  install_oh_my_zsh

  echo "Installation complete!"
}

main "$@"
