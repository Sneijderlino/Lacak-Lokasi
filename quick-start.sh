#!/bin/bash

##########################################################
# Quick Start Script - Lacak-Lokasi
# Usage: bash quick-start.sh
##########################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Print welcome
print_welcome() {
    clear
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════╗"
    echo "║                                                   ║"
    echo "║  Welcome to Lacak-Lokasi Quick Start Guide        ║"
    echo "║                                                   ║"
    echo "║  This guide will set up the application in       ║"
    echo "║  just a few steps!                               ║"
    echo "║                                                   ║"
    echo "╚═══════════════════════════════════════════════════╝"
    echo -e "${NC}"
    sleep 2
}

# Check if venv exists
check_venv() {
    echo -e "${YELLOW}[*]${NC} Checking Python environment..."
    
    if [[ -d "venv" ]]; then
        echo -e "${GREEN}[✓]${NC} Virtual environment found"
        return 0
    else
        echo -e "${YELLOW}[!]${NC} Virtual environment not found"
        return 1
    fi
}

# Create venv
create_venv() {
    echo -e "${YELLOW}[*]${NC} Creating virtual environment..."
    
    if command -v python3 &> /dev/null; then
        python3 -m venv venv
    elif command -v python &> /dev/null; then
        python -m venv venv
    else
        echo -e "${RED}[ERROR]${NC} Python not found!"
        echo "Please install Python 3.8 or higher"
        exit 1
    fi
    
    echo -e "${GREEN}[✓]${NC} Virtual environment created"
}

# Activate venv
activate_venv() {
    echo -e "${YELLOW}[*]${NC} Activating virtual environment..."
    
    if [[ -f "venv/bin/activate" ]]; then
        source venv/bin/activate
        echo -e "${GREEN}[✓]${NC} Virtual environment activated"
    else
        echo -e "${RED}[ERROR]${NC} Cannot activate venv"
        exit 1
    fi
}

# Install dependencies
install_deps() {
    echo -e "${YELLOW}[*]${NC} Installing dependencies..."
    
    pip install --upgrade pip
    
    if [[ -f "requirements.txt" ]]; then
        pip install -r requirements.txt
    else
        # Fallback: install common packages
        pip install Flask requests
    fi
    
    echo -e "${GREEN}[✓]${NC} Dependencies installed"
}

# Check main file
check_main_file() {
    echo -e "${YELLOW}[*]${NC} Checking application file..."
    
    if [[ ! -f "Ghost-Phishing-Lokasi.py" ]]; then
        echo -e "${RED}[ERROR]${NC} Ghost-Phishing-Lokasi.py not found!"
        echo "Make sure you're in the project directory"
        exit 1
    fi
    
    echo -e "${GREEN}[✓]${NC} Application file found"
}

# Run application
run_application() {
    echo -e "\n${BLUE}"
    echo "╔═══════════════════════════════════════════════════╗"
    echo "║  Starting Application...                          ║"
    echo "╚═══════════════════════════════════════════════════╝"
    echo -e "${NC}\n"
    
    python Ghost-Phishing-Lokasi.py
}

# Error handler
error_handler() {
    echo -e "\n${RED}"
    echo "╔═══════════════════════════════════════════════════╗"
    echo "║  Error occurred during setup                      ║"
    echo "╚═══════════════════════════════════════════════════╝"
    echo -e "${NC}\n"
    
    echo -e "${YELLOW}Troubleshooting tips:${NC}"
    echo "1. Make sure you're in the project directory"
    echo "2. Check that Python 3.8+ is installed"
    echo "3. Check INSTALL.md for detailed instructions"
    echo "4. Report issues at: https://github.com/Sneijderlino/Lacak-Lokasi/issues"
    
    exit 1
}

# Main execution
main() {
    trap error_handler ERR
    
    print_welcome
    
    # Check if venv exists
    if ! check_venv; then
        read -p "$(echo -e ${YELLOW}Create virtual environment? (y/n)${NC} )" -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            create_venv
        else
            echo -e "${RED}Aborted${NC}"
            exit 0
        fi
    fi
    
    activate_venv
    install_deps
    check_main_file
    
    echo -e "\n${GREEN}All checks passed!${NC}\n"
    
    read -p "$(echo -e ${YELLOW}Start application now? (y/n)${NC} )" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        run_application
    else
        echo -e "${GREEN}To start the application manually, run:${NC}"
        echo -e "${YELLOW}source venv/bin/activate${NC}"
        echo -e "${YELLOW}python Ghost-Phishing-Lokasi.py${NC}"
    fi
}

# Run main
main
