#!/bin/bash

# =====================================
# setup.sh
# Made By: Gianmarco Raimondi
# Date: 18/11/2026
# This script automatically installs the necessary tools for the Pharos project.
# =====================================

# Terminal color palette
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

set -e

echo -e "${BLUE}Starting initial setup...${NC}\n"

if ! command -v just &> /dev/null; then
    echo -e "${YELLOW}Just not found. Installing...${NC}"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install just
        else
            echo "Homebrew not found. Executing official installation script..."
            curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/bin
            export PATH="$PATH:$HOME/bin"
        fi
    else
        # Linux
        curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/bin
        export PATH="$PATH:$HOME/bin"
    fi
    echo -e "${GREEN}✓ Just successfully installed.${NC}\n"
else
    echo -e "${GREEN}✓ Just is already installed.${NC}\n"
fi

if ! command -v prek &> /dev/null; then
    echo -e "${YELLOW}prek not found. Installing...${NC}"
    if command -v brew &> /dev/null; then
        brew install prek
    else
        curl --proto '=https' --tlsv1.2 -LsSf https://github.com/j178/prek/releases/download/v0.5.11/prek-installer.sh | sh
        export PATH="$PATH:$HOME/.local/bin"
    fi
    echo -e "${GREEN}✓ prek successfully installed.${NC}\n"
else
    echo -e "${GREEN}✓ prek is already installed.${NC}\n"
fi

echo -e "${BLUE}Initializing git hooks...${NC}"
if [ -f ".pre-commit-config.yaml" ]; then
    prek install
    echo -e "${GREEN}✓ Git hooks successfully installed.${NC}"
else
    echo -e "${YELLOW}Warning: .pre-commit-config.yaml not found. Please ensure you are in the project root.${NC}"
fi