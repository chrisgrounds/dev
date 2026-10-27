#!/bin/bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Dotfiles sync
#
# Every managed file/directory lives in this repo and is symlinked into
# place. Adding a new entry is a single line in the "Entries" section below.
#
# Usage:
#   ./sync.sh            # apply symlinks
#   DRY_RUN=1 ./sync.sh  # print what would change, change nothing
# ---------------------------------------------------------------------------

### paths ###
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

### OS detection ###
case "$(uname -s)" in
  Darwin*) OS="macos" ;;
  Linux*)  OS="linux" ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac
echo "Detected OS: $OS"

### platform-specific directories ###
case "$OS" in
  macos)
    ghostty_dir="$HOME/Library/Application Support/com.mitchellh.ghostty"
    zed_dir="$HOME/Library/Application Support/Zed"
    ;;
  linux)
    ghostty_dir="$HOME/.config/ghostty"
    zed_dir="$HOME/.config/zed"
    ;;
esac

claude_themes_dir="$HOME/.claude/themes"
opencode_skills_dir="$HOME/.config/opencode/skills"
codex_skills_dir="$HOME/.codex/skills"

### functions ###
install_link() {
  local src="$1" dst="$2"
  if [ -n "${DRY_RUN:-}" ]; then
    echo "(dry-run) would link $src => $dst"
    return
  fi
  mkdir -p "$(dirname -- "$dst")"
  rm -rf "$dst"
  ln -sfn "$src" "$dst"
  echo "Linked $src => $dst"
}

### entries ###
install_link "$SCRIPT_DIR/nvim"                     "$HOME/.config/nvim"
install_link "$SCRIPT_DIR/zsh/zshrc"                "$HOME/.zshrc"
install_link "$SCRIPT_DIR/wezterm/wezterm.lua"      "$HOME/.wezterm.lua"

# ghostty: config filename differs per platform; on Linux also drop the
# legacy `config` file so Ghostty never sees two configs.
install_link "$SCRIPT_DIR/ghostty/config"           "$ghostty_dir/config.ghostty"
if [ "$OS" = "linux" ]; then
  rm -f "$ghostty_dir/config"
fi

install_link "$SCRIPT_DIR/ghostty/themes/orng-dark" "$ghostty_dir/themes/orng-dark"
install_link "$SCRIPT_DIR/zed/settings.json"         "$zed_dir/settings.json"
install_link "$SCRIPT_DIR/claude/themes/orng-dark.json" "$claude_themes_dir/orng-dark.json"

# Skills are symlinked into both OpenCode and Codex so edits in the dev
# repo propagate to both tools.
for skill in "$SCRIPT_DIR"/skills/*; do
  [ -d "$skill" ] || continue
  install_link "$skill" "$opencode_skills_dir/$(basename "$skill")"
  install_link "$skill" "$codex_skills_dir/$(basename "$skill")"
done
