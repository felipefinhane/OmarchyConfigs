# Omarchy Configuration Structure

This document explains the organization and purpose of each directory and file in the OmarchyConfigs repository.

## Directory Structure

```
OmarchyConfigs/
├── README.md              # Main documentation
├── STRUCTURE.md            # This file - explains the structure
├── dotfiles/               # User configuration files (dotfiles)
│   ├── shell/              # Shell configurations
│   │   ├── .bashrc         # Bash runtime configuration
│   │   └── .bash_profile   # Bash login shell configuration
│   ├── git/                # Git configurations
│   │   ├── .gitconfig      # Git user and alias configurations
│   │   └── .gitignore_global # Global gitignore patterns
│   ├── vim/                # Vim/Neovim configurations
│   │   └── .vimrc          # Vim configuration
│   ├── x11/                # X11 and display configurations
│   │   ├── .xinitrc        # X11 initialization script
│   │   └── .Xresources     # X11 resource settings
│   └── misc/               # Miscellaneous dotfiles
│       └── .inputrc        # Readline configuration
├── system/                 # System-level configurations
│   └── etc-pacman.conf     # Pacman package manager configuration
├── packages/               # Package lists and installation configs
│   ├── essential.txt       # Essential packages for base system
│   └── aur.txt            # AUR packages list
└── scripts/                # Setup and utility scripts
    ├── setup.sh            # Main setup script (links dotfiles)
    └── install-packages.sh # Package installation script
```

## File Descriptions

### Dotfiles (`dotfiles/`)

These are user-specific configuration files that customize the behavior of various applications:

- **Shell configurations** (`shell/`): Bash setup with aliases, environment variables, and prompt customization
- **Git configurations** (`git/`): User information, aliases, colors, and global ignore patterns
- **Vim configurations** (`vim/`): Text editor settings, key mappings, and plugins setup
- **X11 configurations** (`x11/`): Display server initialization and appearance settings
- **Miscellaneous** (`misc/`): Other utility configurations like readline settings

### System Configurations (`system/`)

System-level configuration files that may need to be copied to system directories:

- **pacman.conf**: Arch Linux package manager configuration with optimized settings

### Package Lists (`packages/`)

Text files containing lists of packages to install:

- **essential.txt**: Core packages needed for a functional system
- **aur.txt**: Additional packages from the Arch User Repository (AUR)

### Scripts (`scripts/`)

Automation scripts for setting up and maintaining the configuration:

- **setup.sh**: Main setup script that creates symlinks for dotfiles
- **install-packages.sh**: Installs packages from the package lists

## Usage

1. **Initial Setup**: Run `./scripts/setup.sh` to link all dotfiles
2. **Package Installation**: Run `./scripts/install-packages.sh` to install packages
3. **Customization**: Edit files in their respective directories and re-run setup if needed

## Customization

Each directory can be extended with additional configuration files. The setup script will automatically handle new files added to the dotfiles structure.

For local customizations that shouldn't be committed to the repository, use `.local` suffixed files (e.g., `.bashrc.local`, `.vimrc.local`) which are sourced by the main configuration files when they exist.