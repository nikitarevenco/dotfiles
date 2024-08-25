#!/bin/bash

# Configuration
DOTFILES_DIR="${HOME}/prime/dots"
CONFIG_DIR="${HOME}/.config"
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
SPECIAL_DIRS=("gimp" "vscode" "zoxide")

# Function to create symlinks and handle special cases
create_symlink() {
  local src_path="$1"
  local target_path="$2"

  if [ -f "$src_path" ] || [ -d "$src_path" ]; then

    if [ -L "$target_path" ]; then
      rm "$target_path"

      echo "Removed existing symlink at $target_path"
    elif [ -e "$target_path" ]; then
      mv "$target_path" "$target_path.bak-$TIMESTAMP"
      echo "Backup created for $target_path"
    fi
    ln -s "$src_path" "$target_path"
    echo "Symlink created for $target_path"
  else
    echo "Source $src_path does not exist"
  fi
}

# Function to check if an item is in the special directories array
is_special_dir() {
  local item="$1"
  for dir in "${SPECIAL_DIRS[@]}"; do
    if [[ "$dir" == "$item" ]]; then
      return 0
    fi
  done
  return 1
}

# Main logic to iterate through directories and create symlinks
main() {
  echo "Creating or updating symlinks for directories in $CONFIG_DIR..."
  mkdir -p "$CONFIG_DIR"

  for entry in "$DOTFILES_DIR"/*; do
    entry_name=$(basename "$entry")
    if is_special_dir "$entry_name"; then
      continue
    fi
    if [[ -d "$entry" && ! "$entry_name" =~ ^\..* && "$entry_name" != ".install" && "$entry_name" != ".git" && "$entry_name" != "README.md" && "$entry_name" != ".gitignore" ]]; then
      echo "Processing directory: $entry_name"
      create_symlink "$DOTFILES_DIR/$entry_name" "$CONFIG_DIR/$entry_name"
    elif [[ -f "$entry" && ! "$entry_name" =~ ^\..* && "$entry_name" != ".install" && "$entry_name" != ".git" && "$entry_name" != "README.md" && "$entry_name" != ".gitignore" ]]; then
      echo "Processing file: $entry_name"
      create_symlink "$DOTFILES_DIR/$entry_name" "$CONFIG_DIR/$entry_name"
    fi
  done

  # Handle special cases for certain directories and files
  if [ -d "$DOTFILES_DIR/zsh" ]; then
    create_symlink "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
  fi

  if [ -d "$DOTFILES_DIR/gtk-2.0" ]; then
    create_symlink "$DOTFILES_DIR/gtk-2.0/.gtkrc-2.0" "$HOME/.gtkrc-2.0"
  fi

  if [ -d "$DOTFILES_DIR/zoxide" ]; then
    create_symlink "$DOTFILES_DIR/zoxide" "$HOME/.local/share/zoxide"
  fi

  if [ -d "$DOTFILES_DIR/vscode" ]; then
    create_symlink "$DOTFILES_DIR/vscode/User/extensions.json" "$HOME/.vscode/extensions/extensions.json"
    create_symlink "$DOTFILES_DIR/vscode/User/extensions.json" "$HOME/.vscode-oss/extensions/extensions.json"
    create_symlink "$DOTFILES_DIR/vscode" "$CONFIG_DIR/Code"
    create_symlink "$DOTFILES_DIR/vscode" "$CONFIG_DIR/Code - OSS"
  fi

  if [ -d "$DOTFILES_DIR/gimp" ]; then
    create_symlink "$DOTFILES_DIR/gimp" "$CONFIG_DIR/GIMP"
  fi
}

# Execute main function
main
