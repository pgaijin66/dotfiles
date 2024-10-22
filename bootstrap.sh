#!/usr/bin/env bash

# Set up the configuration directory
export CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME"/.config}
if [[ ! -d "$CONFIG_HOME" ]]; then
    mkdir -p "$CONFIG_HOME"
fi

# Check if Homebrew is installed
IS_INSTALLED_BREW=$(command -v brew)

# Function to execute a command and exit on failure
function runcmd {
    echo "$@"
    "$@" || exit
}

# Function to install Homebrew
function install_brew {
    exists="$IS_INSTALLED_BREW"
    if [[ ! $exists ]]; then
        echo "No brew installation found, installing..."
        runcmd /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        runcmd brew update && brew upgrade
    else
        echo "brew is installed, nothing to do here..."
    fi
}

# Function to install Python
function install_python {
    if ! command -v python3 &> /dev/null || ! command -v pip3 &> /dev/null; then
        echo "Python or pip not found. Installing..."
        runcmd brew install python@3.9
        if ! command -v pip3 &> /dev/null; then
            echo "pip not found. Installing..."
            runcmd /bin/bash -c "curl -O https://bootstrap.pypa.io/get-pip.py"
            runcmd python3 get-pip.py
            runcmd rm get-pip.py
        fi
    else
        echo "Python and pip are already installed. Skipping..."
    fi
}

# Function to install various packages
function install_packages {
    packages=(
        bat gcc ansible koekeishiya/formulae/skhd ripgrep pipenv black neovim fzf go-task tree nvm go openjdk
        tfenv helm helmfile kubectx kubectl sops docker docker-compose colima
        docker-credential-helper aylei/tap/kubectl-debug git-delta git-absorb
        shellcheck awscli hadolint aquasecurity/trivy/trivy figlet lolcat
        mkcert nmap ansible derailed/k9s/k9s snappy awscurl jid watch wget
        telnet terraformer tfsec tree-sitter terraform-docs bats-core kubent
        mtr nettle tcpdump unbound velero
    )

    for package in "${packages[@]}"; do
        if ! brew list "$package" &>/dev/null; then
            echo "Installing $package..."
            runcmd brew install "$package"
        else
            echo "$package is already installed, skipping..."
        fi
    done
}


# Function to install Kitty
function install_kitty {
    if [ ! -d "/Applications/kitty.app" ]; then
        echo "Kitty not found. Installing..."
        runcmd /bin/bash -c "$(curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh)"
    else
        echo "Kitty is already installed. Skipping..."
    fi
}

# Function to install Terraform
function install_terraform {
    if ! command -v terraform &> /dev/null; then
        echo "Terraform not found. Installing..."
        runcmd brew tap hashicorp/tap
        runcmd brew install hashicorp/tap/terraform
    else
        echo "Terraform is already installed. Skipping..."
    fi
}

# Function to set up dotfiles
function setup_dotfiles {
    DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    # Zsh
    # Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        if ! KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
            echo "Error: Failed to install Oh My Zsh" >&2
            return 1
        fi
    fi
    if ! ln -sf "$DOTFILES"/zsh/zshrc "$HOME"/.zshrc; then
        echo "Error: Failed to create symlink for .zshrc" >&2
        return 1
    fi

    # Yabai
    if ! ln -sf "$DOTFILES"/yabai/yabairc "$HOME"/.yabairc; then
        echo "Error: Failed to create symlink for .yabairc" >&2
        return 1
    fi
    if ! chmod +x ~/.yabairc; then
        echo "Error: Failed to make .yabairc executable" >&2
        return 1
    fi

    # skhd
    if ! ln -sf "$DOTFILES"/skhd/skhdrc "$HOME"/.skhdrc; then
        echo "Error: Failed to create symlink for .skhdrc" >&2
        return 1
    fi
    if ! chmod +x ~/.skhdrc; then
        echo "Error: Failed to make .skhdrc executable" >&2
        return 1
    fi

    echo "Dotfiles setup completed successfully"
}

# Function to create required directories
function setup_directories {
    # Create all required directories
    if ! mkdir -p ~/src/personal/github ~/src/work; then
        echo "Error: Failed to create required directories" >&2
        return 1
    fi
    echo "Directories created successfully"
}

# Function to set up configuration files
function setup_config_files {
    # Neovim
    if [ -d "$HOME/.config/nvim" ]; then
        if ! rm -rf "$HOME/.config/nvim"; then
            echo "Error: Failed to remove existing Neovim config directory" >&2
            return 1
        fi
    fi
    if ! ln -s "$DOTFILES/nvim" "$HOME/.config/nvim"; then
        echo "Error: Failed to create symlink for Neovim config" >&2
        return 1
    fi

    # Kitty
    if [ -d "$HOME/.config/kitty" ]; then
        if ! rm -rf "$HOME/.config/kitty"; then
            echo "Error: Failed to remove existing Kitty config directory" >&2
            return 1
        fi
    fi
    if ! ln -s "$DOTFILES/kitty" "$HOME/.config/kitty"; then
        echo "Error: Failed to create symlink for Kitty config" >&2
        return 1
    fi

    # Git
    if ! ln -sf "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"; then
        echo "Error: Failed to create symlink for Git config" >&2
        return 1
    fi

    echo "Config files setup completed successfully"
}

# Run the installation functions
install_brew
install_packages
install_kitty
install_terraform
install_python

# Additional setup steps
setup_dotfiles
setup_directories
setup_config_files

function start_services {
    runcmd skhd --restart-service
    runcmd yabai --restart-service
}


echo "completed !!!"