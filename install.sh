#!/bin/bash

dependencies=(
  "ripgrep"
  "fzf"
  "bat"
  "neovim"
  "zsh"
  "clang"
  "build-essential"
  "procps"
  "file"
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

install_brew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_rustup() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

main() {
  echo "Updating apt"
  update_apt

  echo "Installing dependencies: ${dependencies[*]}"
  install_packages "${dependencies[@]}"

  install_oh_my_zsh
  install_rustup
  install_brew

  echo "Installation complete!"
}

main "$@"
