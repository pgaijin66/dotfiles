# Dotfiles Setup Script

This repository contains a script to set up your development environment by installing necessary packages and configuring dotfiles. The setup script handles the installation of Homebrew, various packages, and the configuration of several tools and applications.

## Features

- **Homebrew Installation**: Installs Homebrew if not already installed.
- **Package Installation**: Installs a list of useful packages for development.
- **Configuration**: Sets up configurations for Zsh, Yabai, skhd, Neovim, Kitty, and Git.
- **Directory Setup**: Creates necessary directories for your projects.
- **Service Management**: Starts and restarts services for skhd and yabai.

## Running script

To get started, clone the repository and run the setup script:

```bash
git clone git@github.com:pgaijin66/dotfiles.git
cd dotfiles
/bin/bash bootstrap.sh
```

## Script Breakdown

### Configuration Directory
Sets up the configuration directory:

```bash
export CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME"/.config}
if [[ ! -d "$CONFIG_HOME" ]]; then
    mkdir -p "$CONFIG_HOME"
fi
```

### Homebrew
Checks if Homebrew is installed and installs it if not:

```bash
function install_brew {
    if [[ ! $(command -v brew) ]]; then
        echo "No brew installation found, installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew update && brew upgrade
    else
        echo "brew is installed, nothing to do here..."
    fi
}
```

### Package Installation

Installs a list of useful packages:

```bash
function install_packages {
    brew install bat gcc ripgre..
}
```

### Additional Tools

Installs and configures additional tools like skhd, Kitty, Terraform, Python, and Ansible:

```bash
function install_kitty {
    /bin/bash -c "$(curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh)"
}

function install_terraform {
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
}

function install_python {
    brew install python@3.9
    curl -O https://bootstrap.pypa.io/get-pip.py
}
```

### Dotfiles Setup
Sets up dotfiles for Zsh, Yabai, and skhd:

```bash
function setup_dotfiles {
    DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    ln -sf "$DOTFILES"/zsh/zshrc "$HOME"/.zshrc
    ln -sf "$DOTFILES"/yabai/yabairc "$HOME"/.yabairc
    chmod +x ~/.yabairc
    ln -sf "$DOTFILES"/skhd/skhdrc "$HOME"/.skhdrc
    chmod +x ~/.skhdrc
}
```

### Directory Setup

Creates required directories:

```bash
function setup_directories {
    mkdir -p ~/src/personal/{github,books,docs,experiments,personal,projects,work} \
             ~/src/work/{books,docs,experiments,personal,projects,work}
}
```

### Configuration Files Setup
Sets up configuration files for Neovim, Kitty, and Git:

```bash
function setup_config_files {
    rm -rf "$HOME"/.config/nvim
    ln -s "$DOTFILES"/nvim "$HOME"/.config/nvim
    rm -rf "$HOME"/.config/kitty
    ln -s "$DOTFILES"/kitty "$HOME"/.config/kitty
    ln -sf "$DOTFILES"/git/gitconfig "$HOME"/.gitconfig
}
```

### Start Services
Restarts services for skhd and yabai:

```bash
function start_services {
    skhd --restart-service
    yabai --restart-service
}
```