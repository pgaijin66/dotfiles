# Dotfiles Setup Script

This repository contains my personal dotfiles and setup scripts for configuring a new macOS development environment. It automates the installation and configuration of my daily development tools and applications.

## Features

- **Package Management**: Automated installation via Homebrew
- **Shell Configuration**: ZSH with Oh-My-Zsh and custom plugins
- **Development Tools**: Essential CLI utilities and development packages
- **Dotfiles Management**: Uses GNU Stow for managing configuration files
- **Directory Structure**: Creates organized project directories
- **Exports System**: Modular environment variable management

## Exports management

I maintain a security-conscious approach to environment variables by separating them into dedicated files instead of storing credentials in shell configuration files that might accidentally get committed to repositories.

```
  ~/.config/exports/
  ├── paths      # PATH modifications and system paths
  ├── tools      # Tool-specific configurations (non-sensitive)
  ├── secrets    # Sensitive credentials and API keys
  └── dev        # Development-specific variables
```

Doing this, it addresses my security concerns while maintaining following:

- Separation of Concerns: Different types of exports are isolated
- Selective Sharing: Can share paths and tools without exposing secrets
- Gitignore Safety: Secrets directory is excluded from version control
- Audit Trail: Easy identification of sensitive data

## Daily Tools

### Hardware

- MacBook Pro 32G Memoery ( Work )
- Lenovo Thinkcenter Cluster ( Personal )

### Operating System
- **OS**: macOS, Debian, Rocky, Proxmox
- **Window Management**: Yabai for tiling windows
- **Keyboard Shortcuts**: skhd for custom keybindings

### Terminal Setup
- **Terminal Emulator**: Kitty
- **Shell**: Zsh with Oh-My-Zsh
- **CLI Tools**: *Defined in bootstrap.sh file*

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