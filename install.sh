#!/bin/bash

dependencies=(
  "ripgrep"
  "fzf"
)

update_apt() {
  sudo apt update && sudo apt upgrade
}

install_packages() {
  local packages=("$@")
  sudo apt update && sudo apt install -y "${packages[@]}"
}

main() {
  echo "Updating apt"
  update_apt

  echo "Installing dependencies: ${dependencies[*]}"
  install_packages "${dependencies[@]}"

  echo "Installation complete!"
}

main "$@"
