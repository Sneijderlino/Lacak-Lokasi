#!/bin/bash

##########################################################
# Setup Script untuk Termux (Android)
# Usage: bash setup-termux.sh
##########################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Print header
print_header() {
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════╗"
    echo "║  Lacak-Lokasi Installation Script for Termux      ║"
    echo "║  Platform: Android (Termux)                       ║"
    echo "╚═══════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Check Termux environment
check_termux() {
    if [[ -z "$TERMUX_VERSION" ]]; then
        echo -e "${YELLOW}[!]${NC} Warning: TERMUX_VERSION not detected"
        echo -e "${YELLOW}[!]${NC} Make sure you're running this in Termux"
    else
        echo -e "${GREEN}[✓]${NC} Termux detected: $TERMUX_VERSION"
    fi
}

# Check requirements
check_requirements() {
    echo -e "${YELLOW}[*]${NC} Checking requirements..."
    
    # Check for pkg
    if ! command -v pkg &> /dev/null; then
        echo -e "${RED}[ERROR]${NC} pkg not found in PATH"
        exit 1
    else
        echo -e "${GREEN}[✓]${NC} pkg found"
    fi
}

# Update Termux packages
update_termux() {
    echo -e "${YELLOW}[*]${NC} Updating Termux packages..."
    apt update
    apt upgrade -y
    echo -e "${GREEN}[✓]${NC} Termux packages updated"
}

# Install dependencies
install_dependencies() {
    echo -e "${YELLOW}[*]${NC} Installing Termux dependencies..."
    
    # Install git
    if ! command -v git &> /dev/null; then
        echo -e "${YELLOW}[*]${NC} Installing git..."
        apt install -y git
    fi
    
    # Install python
    if ! command -v python &> /dev/null; then
        echo -e "${YELLOW}[*]${NC} Installing python..."
        apt install -y python
    fi
    
    # Install python headers for some packages
    echo -e "${YELLOW}[*]${NC} Installing python development files..."
    apt install -y python-dev
    
    # Install required build tools
    echo -e "${YELLOW}[*]${NC} Installing build tools..."
    apt install -y build-essential clang
    
    # Verify installations
    echo -e "${GREEN}[✓]${NC} All Termux dependencies installed"
}

# Setup Python environment
setup_venv() {
    echo -e "${YELLOW}[*]${NC} Setting up Python virtual environment..."
    
    if [[ -d "venv" ]]; then
        echo -e "${YELLOW}[!]${NC} Virtual environment already exists. Skipping..."
    else
        python -m venv venv
        echo -e "${GREEN}[✓]${NC} Virtual environment created"
    fi
    
    # Activate venv
    source venv/bin/activate
    echo -e "${GREEN}[✓]${NC} Virtual environment activated"
    
    # Upgrade pip
    pip install --upgrade pip setuptools wheel
    echo -e "${GREEN}[✓]${NC} pip upgraded"
}

# Install Python dependencies
install_python_deps() {
    echo -e "${YELLOW}[*]${NC} Installing Python dependencies..."
    
    # Install packages individually for Termux compatibility
    pip install Flask
    pip install requests
    pip install geoip2
    
    echo -e "${GREEN}[✓]${NC} Python dependencies installed"
}

# Termux-specific setup
setup_storage_permission() {
    echo -e "${YELLOW}[*]${NC} Checking storage permissions..."
    
    if [[ ! -d "$HOME/storage" ]]; then
        echo -e "${YELLOW}[!]${NC} Requesting storage access..."
        echo "Please run this command in Termux:"
        echo -e "   ${YELLOW}termux-setup-storage${NC}"
        echo ""
        echo "Then run this script again."
        exit 1
    else
        echo -e "${GREEN}[✓]${NC} Storage access available"
    fi
}

# Verify installation
verify_installation() {
    echo -e "${YELLOW}[*]${NC} Verifying installation..."
    
    python --version
    pip --version
    
    # Check if Flask can be imported
    python -c "import flask; print(f'Flask: {flask.__version__}')" && echo -e "${GREEN}[✓]${NC} Flask installed"
    python -c "import requests; print(f'Requests: {requests.__version__}')" && echo -e "${GREEN}[✓]${NC} Requests installed"
    
    if [[ -f "Ghost-Phishing-Lokasi.py" ]]; then
        echo -e "${GREEN}[✓]${NC} Main application file found"
    else
        echo -e "${RED}[✗]${NC} Main application file not found!"
    fi
}

# Print completion
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
    echo "3. Access via browser:"
    echo -e "   ${YELLOW}http://localhost:8000${NC}"
    echo ""
    echo -e "${YELLOW}[*]${NC} Termux Tips:"
    echo "- Use 'termux-open' to open URLs in browser"
    echo "- Use 'apt search' to find packages"
    echo "- Run 'termux-setup-storage' for file access"
    echo ""
}

# Main execution
main() {
    print_header
    check_termux
    check_requirements
    update_termux
    install_dependencies
    setup_storage_permission
    setup_venv
    install_python_deps
    verify_installation
    print_completion
}

# Run main
main
