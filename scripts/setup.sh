#!/bin/bash
#
# setup.sh - Main setup script for Omarchy configs
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_step() {
    echo -e "${BLUE}==> $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"

print_step "Starting Omarchy configuration setup"
echo "Configuration directory: $CONFIG_DIR"
echo

# Check if running on Arch Linux
if [[ ! -f /etc/arch-release ]]; then
    print_error "This script is designed for Arch Linux"
    exit 1
fi

# Create backup directory
BACKUP_DIR="$HOME/.config/omarchy-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
print_success "Created backup directory: $BACKUP_DIR"

# Function to backup and link files
backup_and_link() {
    local source="$1"
    local target="$2"
    
    if [[ -e "$target" ]]; then
        print_warning "Backing up existing $target"
        mv "$target" "$BACKUP_DIR/"
    fi
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Create symlink
    ln -sf "$source" "$target"
    print_success "Linked $source -> $target"
}

# Link dotfiles
print_step "Setting up dotfiles"
backup_and_link "$CONFIG_DIR/dotfiles/shell/.bashrc" "$HOME/.bashrc"
backup_and_link "$CONFIG_DIR/dotfiles/shell/.bash_profile" "$HOME/.bash_profile"
backup_and_link "$CONFIG_DIR/dotfiles/git/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$CONFIG_DIR/dotfiles/git/.gitignore_global" "$HOME/.gitignore_global"
backup_and_link "$CONFIG_DIR/dotfiles/vim/.vimrc" "$HOME/.vimrc"

# Install packages
print_step "Installing essential packages"
if command -v pacman &> /dev/null; then
    print_warning "Please review and install packages from packages/essential.txt manually"
    print_warning "You can use: pacman -S --needed \$(cat $CONFIG_DIR/packages/essential.txt | grep -v '^#' | tr '\n' ' ')"
else
    print_error "pacman not found"
fi

# Check for AUR helper
print_step "Checking for AUR helper"
if command -v yay &> /dev/null; then
    print_success "yay is already installed"
    print_warning "Please review and install packages from packages/aur.txt manually"
    print_warning "You can use: yay -S --needed \$(cat $CONFIG_DIR/packages/aur.txt | grep -v '^#' | tr '\n' ' ')"
else
    print_warning "yay not found. Install it manually from AUR to install AUR packages"
fi

print_step "Setup completed!"
print_success "Dotfiles have been linked"
print_warning "Please restart your shell or run 'source ~/.bashrc' to apply changes"
print_warning "Review and install packages from the packages/ directory"
echo
echo "Backup directory: $BACKUP_DIR"