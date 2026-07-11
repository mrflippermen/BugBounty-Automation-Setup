#!/usr/bin/env bash
#
# Bug Bounty Environment Setup - Enterprise Grade
# ================================================
#
# Automated setup of bug bounty hunting environment with latest tools.
# Supports multiple Linux distributions and safe idempotent execution.
#
# Author: Esteban Jiménez
# License: MIT

set -euo pipefail

# Configuration
TOOLS_DIR="${HOME}/.bugbounty-tools"
LOG_FILE="${HOME}/.bugbounty-setup.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging
log() {
    echo -e "${2:-}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}" | tee -a "${LOG_FILE}"
}

log_info() { log "$1" "${GREEN}"; }
log_warn() { log "$1" "${YELLOW}"; }
log_error() { log "$1" "${RED}"; }
log_step() { log "$1" "${BLUE}"; }

# Detect OS
detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
    else
        log_error "Cannot detect OS"
        exit 1
    fi
    
    log_info "Detected OS: ${OS} ${VER}"
}

# Update system packages
update_system() {
    log_step "Updating system packages..."
    
    case "${OS}" in
        debian|ubuntu|kali)
            sudo apt update -y
            sudo apt upgrade -y
            ;;
        arch|manjaro)
            sudo pacman -Syu --noconfirm
            ;;
        fedora|rhel|centos)
            sudo dnf update -y
            ;;
        *)
            log_warn "Unknown OS, skipping system update"
            ;;
    esac
}

# Install base packages
install_base_packages() {
    log_step "Installing base packages..."
    
    local packages="curl wget git zsh python3 python3-pip golang"
    
    case "${OS}" in
        debian|ubuntu|kali)
            sudo apt install -y ${packages}
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm ${packages}
            ;;
        fedora|rhel|centos)
            sudo dnf install -y ${packages}
            ;;
    esac
}

# Install modern CLI tools
install_cli_tools() {
    log_step "Installing modern CLI tools..."
    
    mkdir -p "${TOOLS_DIR}/bin"
    
    # Install lsd (modern ls)
    if ! command -v lsd &> /dev/null; then
        log_info "Installing lsd..."
        local lsd_version="1.0.0"
        wget -q "https://github.com/lsd-rs/lsd/releases/download/v${lsd_version}/lsd_${lsd_version}_amd64.deb" -O /tmp/lsd.deb
        sudo dpkg -i /tmp/lsd.deb 2>/dev/null || sudo apt install -f -y
        rm /tmp/lsd.deb
    fi
    
    # Install bat (modern cat)
    if ! command -v bat &> /dev/null; then
        log_info "Installing bat..."
        local bat_version="0.24.0"
        wget -q "https://github.com/sharkdp/bat/releases/download/v${bat_version}/bat_${bat_version}_amd64.deb" -O /tmp/bat.deb
        sudo dpkg -i /tmp/bat.deb 2>/dev/null || sudo apt install -f -y
        rm /tmp/bat.deb
    fi
}

# Install ZSH plugins
install_zsh_plugins() {
    log_step "Installing ZSH plugins..."
    
    # Install Oh My Zsh
    if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # Install Powerlevel10k theme
    if [[ ! -d "${HOME}/powerlevel10k" ]]; then
        log_info "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${HOME}/powerlevel10k"
        echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> "${HOME}/.zshrc"
    fi
    
    # Install plugins
    local plugin_dir="${HOME}/.zsh/plugins"
    mkdir -p "${plugin_dir}"
    
    if [[ ! -d "${plugin_dir}/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "${plugin_dir}/zsh-autosuggestions"
    fi
    
    if [[ ! -d "${plugin_dir}/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${plugin_dir}/zsh-syntax-highlighting"
    fi
    
    # Configure ZSH
    cat >> "${HOME}/.zshrc" << 'EOF'

# Bug Bounty Environment Configuration
export PATH="${HOME}/.bugbounty-tools/bin:${PATH}"
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# Aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias ls='lsd -lha --group-dirs=first'

# Load plugins
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
EOF
}

# Install bug bounty tools
install_bugbounty_tools() {
    log_step "Installing bug bounty tools..."
    
    # Go tools directory
    export GOPATH="${HOME}/go"
    export PATH="${PATH}:${GOPATH}/bin"
    mkdir -p "${GOPATH}"
    
    # Install subfinder
    if ! command -v subfinder &> /dev/null; then
        log_info "Installing subfinder..."
        go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    fi
    
    # Install httpx
    if ! command -v httpx &> /dev/null; then
        log_info "Installing httpx..."
        go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    fi
    
    # Install nuclei
    if ! command -v nuclei &> /dev/null; then
        log_info "Installing nuclei..."
        go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
    fi
    
    # Install amass
    if ! command -v amass &> /dev/null; then
        log_info "Installing amass..."
        go install -v github.com/owasp-amass/amass/v4/...@master
    fi
    
    # Install ffuf
    if ! command -v ffuf &> /dev/null; then
        log_info "Installing ffuf..."
        go install github.com/ffuf/ffuf/v2@latest
    fi
    
    # Install waybackurls
    if ! command -v waybackurls &> /dev/null; then
        log_info "Installing waybackurls..."
        go install github.com/tomnomnom/waybackurls@latest
    fi
    
    # Install gau
    if ! command -v gau &> /dev/null; then
        log_info "Installing gau..."
        go install github.com/lc/gau/v2/cmd/gau@latest
    fi
    
    # Clone SecLists
    if [[ ! -d "${TOOLS_DIR}/SecLists" ]]; then
        log_info "Cloning SecLists..."
        git clone https://github.com/danielmiessler/SecLists.git "${TOOLS_DIR}/SecLists"
    fi
}

# Set ZSH as default shell
set_default_shell() {
    log_step "Setting ZSH as default shell..."
    
    if [[ "${SHELL}" != *"zsh"* ]]; then
        sudo chsh -s $(which zsh) $(whoami)
        log_info "ZSH set as default shell (restart shell to apply)"
    else
        log_info "ZSH is already default shell"
    fi
}

# Main installation
main() {
    log_info "=========================================="
    log_info "Bug Bounty Environment Setup"
    log_info "=========================================="
    
    detect_os
    update_system
    install_base_packages
    install_cli_tools
    install_zsh_plugins
    install_bugbounty_tools
    set_default_shell
    
    log_info "=========================================="
    log_info "Installation completed successfully!"
    log_info "=========================================="
    log_info "To apply changes, run: exec zsh"
    log_info "Log file: ${LOG_FILE}"
}

main "$@"
