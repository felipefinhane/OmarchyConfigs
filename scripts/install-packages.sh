#!/bin/bash
#
# install-packages.sh - Install packages for Omarchy setup
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}==> $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"

print_step "Installing Omarchy packages"

# Check if running on Arch Linux
if [[ ! -f /etc/arch-release ]]; then
    print_error "This script is designed for Arch Linux"
    exit 1
fi

# Install essential packages
print_step "Installing essential packages"
if [[ -f "$CONFIG_DIR/packages/essential.txt" ]]; then
    # Filter out comments and empty lines
    PACKAGES=$(grep -v '^#' "$CONFIG_DIR/packages/essential.txt" | grep -v '^$' | tr '\n' ' ')
    
    if [[ -n "$PACKAGES" ]]; then
        print_step "Installing: $PACKAGES"
        sudo pacman -S --needed $PACKAGES
        print_success "Essential packages installed"
    else
        print_error "No packages found in essential.txt"
    fi
else
    print_error "Essential packages file not found"
    exit 1
fi

# Install AUR packages if yay is available
if command -v yay &> /dev/null; then
    print_step "Installing AUR packages"
    if [[ -f "$CONFIG_DIR/packages/aur.txt" ]]; then
        # Filter out comments and empty lines
        AUR_PACKAGES=$(grep -v '^#' "$CONFIG_DIR/packages/aur.txt" | grep -v '^$' | tr '\n' ' ')
        
        if [[ -n "$AUR_PACKAGES" ]]; then
            print_step "Installing AUR packages: $AUR_PACKAGES"
            yay -S --needed $AUR_PACKAGES
            print_success "AUR packages installed"
        else
            print_error "No packages found in aur.txt"
        fi
    else
        print_error "AUR packages file not found"
    fi
else
    print_error "yay not found. Please install yay first to install AUR packages"
    echo "You can install yay manually:"
    echo "git clone https://aur.archlinux.org/yay.git"
    echo "cd yay"
    echo "makepkg -si"
fi

print_success "Package installation completed!"