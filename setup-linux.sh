#!/bin/bash

##########################################################
# Setup Script untuk Linux & WSL2
# Supports: Debian, Ubuntu, Fedora, Arch Linux
# Usage: bash setup-linux.sh
##########################################################

set -e

# Colors untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Detect OS
detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS=$NAME
        VERSION=$VERSION_ID
    else
        echo -e "${RED}[ERROR]${NC} Sistem operasi tidak terdeteksi"
        exit 1
    fi
}

# Print header
print_header() {
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════╗"
    echo "║  Lacak-Lokasi Installation Script for Linux       ║"
    echo "║  Platform: $OS $VERSION                           ║"
    echo "╚═══════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Check for required tools
check_requirements() {
    echo -e "${YELLOW}[*]${NC} Checking requirements..."
    
    # Check for git
    if ! command -v git &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} Git not found. Installing..."
        install_git
    else
        echo -e "${GREEN}[✓]${NC} Git found: $(git --version)"
    fi
    
    # Check for python3
    if ! command -v python3 &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} Python3 not found. Installing..."
        install_python
    else
        echo -e "${GREEN}[✓]${NC} Python3 found: $(python3 --version)"
    fi
    
    # Check for pip
    if ! command -v pip3 &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} pip3 not found. Installing..."
        install_pip
    else
        echo -e "${GREEN}[✓]${NC} pip3 found: $(pip3 --version)"
    fi
}

# Install Git
install_git() {
    case "$OS" in
        *Ubuntu*|*Debian*)
            sudo apt update
            sudo apt install -y git
            ;;
        *Fedora*)
            sudo dnf install -y git
            ;;
        *Arch*)
            sudo pacman -Sy git
            ;;
    esac
}

# Install Python
install_python() {
    case "$OS" in
        *Ubuntu*|*Debian*)
            sudo apt update
            sudo apt install -y python3.8 python3-dev python3-venv
            ;;
        *Fedora*)
            sudo dnf install -y python3 python3-devel
            ;;
        *Arch*)
            sudo pacman -Sy python
            ;;
    esac
}

# Install pip
install_pip() {
    case "$OS" in
        *Ubuntu*|*Debian*)
            sudo apt install -y python3-pip
            ;;
        *Fedora*)
            sudo dnf install -y python3-pip
            ;;
        *Arch*)
            sudo pacman -Sy python-pip
            ;;
    esac
}

# Update system packages
update_system() {
    echo -e "${YELLOW}[*]${NC} Updating system packages..."
    
    case "$OS" in
        *Ubuntu*|*Debian*)
            sudo apt update
            sudo apt upgrade -y
            ;;
        *Fedora*)
            sudo dnf upgrade -y
            ;;
        *Arch*)
            sudo pacman -Syu
            ;;
    esac
    
    echo -e "${GREEN}[✓]${NC} System packages updated"
}

# Setup Python environment
setup_venv() {
    echo -e "${YELLOW}[*]${NC} Setting up Python virtual environment..."
    
    if [[ -d "venv" ]]; then
        echo -e "${YELLOW}[!]${NC} Virtual environment already exists. Skipping..."
    else
        python3 -m venv venv
        echo -e "${GREEN}[✓]${NC} Virtual environment created"
    fi
    
    # Activate venv
    source venv/bin/activate
    echo -e "${GREEN}[✓]${NC} Virtual environment activated"
    
    # Upgrade pip
    pip install --upgrade pip setuptools wheel
    echo -e "${GREEN}[✓]${NC} pip upgraded"
}

# Install dependencies
install_dependencies() {
    echo -e "${YELLOW}[*]${NC} Installing Python dependencies..."
    
    if [[ -f "requirements.txt" ]]; then
        pip install -r requirements.txt
        echo -e "${GREEN}[✓]${NC} Dependencies installed"
    else
        echo -e "${YELLOW}[!]${NC} requirements.txt not found. Installing common packages..."
        pip install Flask requests geoip2
    fi
}

# Verify installation
verify_installation() {
    echo -e "${YELLOW}[*]${NC} Verifying installation..."
    
    python3 -c "import sys; print(f'Python: {sys.version}')"
    pip --version
    
    if [[ -f "Ghost-Phishing-Lokasi.py" ]]; then
        echo -e "${GREEN}[✓]${NC} Main application file found"
    else
        echo -e "${RED}[✗]${NC} Main application file not found!"
    fi
}

# Quick start instructions
print_completion() {
    echo -e "\n${BLUE}"
    echo "╔═══════════════════════════════════════════════════╗"
    echo "║  Installation Complete!                          ║"
    echo "╚═══════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo -e "${GREEN}Next steps:${NC}"
    echo "1. Activate virtual environment:"
    echo -e "   ${YELLOW}source venv/bin/activate${NC}"
    echo ""
    echo "2. Start the application:"
    echo -e "   ${YELLOW}python Ghost-Phishing-Lokasi.py${NC}"
    echo ""
    echo "3. Open browser and visit:"
    echo -e "   ${YELLOW}http://localhost:8000${NC}"
    echo ""
    echo -e "${GREEN}Documentation:${NC}"
    echo "- README.md      - Project overview"
    echo "- INSTALL.md     - Detailed installation guide"
    echo "- CONTRIBUTING.md - How to contribute"
    echo ""
}

# Main execution
main() {
    print_header
    detect_os
    check_requirements
    update_system
    setup_venv
    install_dependencies
    verify_installation
    print_completion
}

# Run main
main
