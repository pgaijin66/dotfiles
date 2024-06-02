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

# Function to install skhd
function install_skhd {
    runcmd brew install koekeishiya/formulae/skhd
    runcmd skhd --start-service
    # runcmd brew services restart skhd
}

# Function to install Ansible
function install_ansible {
    runcmd brew install ansible
}

# Function to install Python
function install_python {
    runcmd brew install python@3.9
    runcmd /bin/bash -c "curl -O https://bootstrap.pypa.io/get-pip.py"
}

# Function to install various packages
function install_packages {
    runcmd brew install bat \
                            gcc \
                            ripgrep \
                            pipenv \
                            black \
                            neovim \
                            fzf \
                            go-task \
                            tree \
                            nvm \
                            go \
                            openjdk \
                            tfenv \
                            helm \
                            helmfile \
                            kubectx \
                            kubectl \
                            sops \
                            docker \
                            docker-compose \
                            colima \
                            docker-credential-helper \
                            aylei/tap/kubectl-debug \
                            git-delta \
                            git-absorb \
                            shellcheck \
                            awscli \
                            hadolint \
                            aquasecurity/trivy/trivy \
                            figlet \
                            lolcat \
                            mkcert \
                            nmap \
                            ansible \
                            derailed/k9s/k9s \
                            snappy \
                            awscurl \
                            jid \
                            watch \
                            wget \
                            telnet \
                            terraformer \
                            tfsec \
                            tree-sitter \
                            terraform-docs \
                            bats-core \
                            eksup \
                            kubent \
                            mtr \
                            nettle \
                            tcpdump \
                            unbound \
                            velero
}

# Function to install Terraform
function install_kitty {
    runcmd /bin/bash -c "$(curl -fsSL  https://sw.kovidgoyal.net/kitty/installer.sh)"
}

# Function to install Terraform
function install_terraform {
    runcmd brew tap hashicorp/tap
    runcmd brew install hashicorp/tap/terraform
}

# Function to set up dotfiles
function setup_dotfiles {
    DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    # Zsh
    # Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    ln -sf "$DOTFILES"/zsh/zshrc "$HOME"/.zshrc

    # Yabai
    ln -sf "$DOTFILES"/yabai/yabairc "$HOME"/.yabairc
    chmod +x ~/.yabairc

    # skhd
    ln -sf "$DOTFILES"/skhd/skhdrc "$HOME"/.skhdrc
    chmod +x ~/.skhdrc
}

# Function to create required directories
function setup_directories {
    # Create all required directories
    mkdir -p ~/src/personal/github ~/src/work
}

# Function to set up configuration files
function setup_config_files {
    # Neovim
    rm -rf "$HOME"/.config/nvim
    ln -s "$DOTFILES"/nvim "$HOME"/.config/nvim

    # Kitty
    rm -rf "$HOME"/.config/kitty
    ln -s "$DOTFILES"/kitty "$HOME"/.config/kitty

    # Git
    ln -sf "$DOTFILES"/git/gitconfig "$HOME"/.gitconfig
}

# Run the installation functions
install_brew
install_packages
install_skhd
install_kitty
install_terraform
install_python
install_ansible


# Additional setup steps
setup_dotfiles
setup_directories
setup_config_files

function start_services {
    runcmd skhd --restart-service
    runcmd yabai --restart-service
}


echo "completed"