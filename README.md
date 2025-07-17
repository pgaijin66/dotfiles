# Dotfiles Setup Script

This repository contains my personal dotfiles and setup scripts for configuring a new macOS development environment. It automates the installation and configuration of my daily development tools and applications.

## Features

- **Package Management**: Automated installation via Homebrew
- **Shell Configuration**: ZSH with Oh-My-Zsh and custom plugins
- **Development Tools**: Essential CLI utilities and development packages
- **Dotfiles Management**: Uses GNU Stow for managing configuration files
- **Directory Structure**: Creates organized project directories
- **Exports System**: Modular environment variable management

## Daily Tools

### Operating System
- **OS**: macOS
- **Window Management**: Yabai for tiling windows
- **Keyboard Shortcuts**: skhd for custom keybindings

### Terminal Setup
- **Terminal Emulator**: Kitty
- **Shell**: Zsh with Oh-My-Zsh
- **CLI Tools**:
  - bat (better cat)
  - gcc
  - ansible
  - ripgrep (better grep)
  - pipenv
  - black
  - fzf (fuzzy finder)
  - go-task
  - tree
  - eza (better ls)
  - git-delta
  - git-absorb
  - shellcheck
  - hadolint
  - trivy
  - figlet
  - lolcat
  - mkcert
  - nmap
  - snappy
  - awscurl
  - jid
  - watch
  - wget
  - telnet
  - mtr
  - nettle
  - tcpdump
  - unbound
  - htop
  - fd (better find)
  - thefuck (command correction)
  - navi
  - dust
  - tldr

### Development
- **Editor**: Neovim / VSCode
- **Languages**:
  - Python with pip
  - Go
  - Node.js via nvm
  - Java via OpenJDK
  - Tree-sitter
  - asdf

### Container & Cloud Tools
- **Containers**: Docker/Podman with Colima
- **Kubernetes**:
  - kubectl
  - kubectx
  - k9s
  - kubectl-debug
  - kubent
  - velero
- **Infrastructure**: 
  - Terraform
  - tfenv
  - terraformer
  - tfsec
  - terraform-docs
  - AWS CLI
  - Helm/Helmfile
  - sops
  - bats-core

## Running script

To get started, clone the repository and run the setup script:

```bash
git clone git@github.com:pgaijin66/dotfiles.git
cd dotfiles
bash bootstrap.sh
```