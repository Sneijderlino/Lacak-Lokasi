#!/bin/bash

##########################################################
# Push ke GitHub - Lacak-Lokasi
# Usage: bash push-github.sh
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
    echo "║  Lacak-Lokasi - Push to GitHub                    ║"
    echo "╚═══════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Configure Git
configure_git() {
    echo -e "${YELLOW}[*]${NC} Configuring Git..."
    
    # Check if git is configured
    if ! git config --global user.name &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} Git user.name not configured"
        read -p "Enter your GitHub username: " github_user
        git config --global user.name "$github_user"
        echo -e "${GREEN}[✓]${NC} Username configured"
    fi
    
    if ! git config --global user.email &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} Git user.email not configured"
        read -p "Enter your GitHub email: " github_email
        git config --global user.email "$github_email"
        echo -e "${GREEN}[✓]${NC} Email configured"
    fi
}

# Initialize repository
init_repo() {
    echo -e "${YELLOW}[*]${NC} Initializing Git repository..."
    
    if [[ -d ".git" ]]; then
        echo -e "${GREEN}[✓]${NC} Git repository already exists"
    else
        git init
        echo -e "${GREEN}[✓]${NC} Git repository initialized"
    fi
}

# Add remote
add_remote() {
    echo -e "${YELLOW}[*]${NC} Adding remote origin..."
    
    REMOTE_URL="https://github.com/Sneijderlino/Lacak-Lokasi.git"
    
    if git remote | grep -q origin; then
        echo -e "${YELLOW}[!]${NC} Remote already exists, updating..."
        git remote remove origin
    fi
    
    git remote add origin "$REMOTE_URL"
    echo -e "${GREEN}[✓]${NC} Remote added: $REMOTE_URL"
}

# Stage files
stage_files() {
    echo -e "${YELLOW}[*]${NC} Staging files..."
    
    git add .
    
    # Show status
    echo -e "${GREEN}[✓]${NC} Files staged"
    echo ""
    git status
}

# Create initial commit
create_commit() {
    echo -e "${YELLOW}[*]${NC} Creating initial commit..."
    
    git commit -m "chore: initial repository setup with documentation and scripts"
    
    echo -e "${GREEN}[✓]${NC} Commit created"
}

# Push to GitHub
push_to_github() {
    echo -e "${YELLOW}[*]${NC} Pushing to GitHub..."
    echo -e "${YELLOW}[!]${NC} Make sure you have:"
    echo "    1. GitHub SSH key configured, OR"
    echo "    2. GitHub Personal Access Token ready"
    echo ""
    
    read -p "Continue with push? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}[!]${NC} Push cancelled"
        return 1
    fi
    
    # Try SSH first, then HTTPS
    if git push -u origin main 2>/dev/null; then
        echo -e "${GREEN}[✓]${NC} Pushed to GitHub successfully (SSH)"
    elif git push -u origin main; then
        echo -e "${GREEN}[✓]${NC} Pushed to GitHub successfully (HTTPS)"
    else
        echo -e "${RED}[ERROR]${NC} Push failed!"
        echo "Troubleshooting:"
        echo "1. Check if main branch exists: git branch -a"
        echo "2. If not, create it: git branch -M main"
        echo "3. Try push again: git push -u origin main"
        return 1
    fi
}

# Print instructions
print_instructions() {
    echo -e "\n${BLUE}"
    echo "╔═══════════════════════════════════════════════════╗"
    echo "║  Setup Complete!                                  ║"
    echo "╚═══════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo -e "${GREEN}Next Steps:${NC}"
    echo ""
    echo "1. If you haven't set up GitHub SSH:"
    echo -e "   ${YELLOW}ssh-keygen -t ed25519 -C \"your_email@example.com\"${NC}"
    echo "   Upload public key to GitHub Settings → SSH Keys"
    echo ""
    echo "2. For HTTPS, create Personal Access Token:"
    echo "   Go to GitHub → Settings → Developer Settings → Personal Access Tokens"
    echo "   Use token as password when pushing"
    echo ""
    echo "3. Check repository status:"
    echo -e "   ${YELLOW}git status${NC}"
    echo ""
    echo "4. View commits:"
    echo -e "   ${YELLOW}git log --oneline${NC}"
    echo ""
    echo "5. Make changes and commit:"
    echo -e "   ${YELLOW}git add .${NC}"
    echo -e "   ${YELLOW}git commit -m \"your message\"${NC}"
    echo -e "   ${YELLOW}git push${NC}"
    echo ""
}

# Main execution
main() {
    print_header
    
    configure_git
    init_repo
    add_remote
    stage_files
    
    read -p "$(echo -e ${YELLOW}Create commit and push to GitHub? (y/n)${NC} )" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        create_commit
        push_to_github
        print_instructions
    else
        echo -e "${YELLOW}[!]${NC} Setup completed without push"
        echo ""
        echo "To push later, run:"
        echo -e "${YELLOW}git push -u origin main${NC}"
    fi
}

# Run main
main
