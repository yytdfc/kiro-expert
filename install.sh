#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing Kiro Expert...${NC}"

# GitHub repository details
REPO_URL="https://raw.githubusercontent.com/yytdfc/kiro-expert/main"

# Installation directories
POWER_DIR="$HOME/.kiro/powers/installed/kiro-expert"
AGENT_DIR="$HOME/.kiro/agents"

# Create directories if they don't exist
echo -e "${BLUE}Creating directories...${NC}"
mkdir -p "$POWER_DIR"
mkdir -p "$AGENT_DIR"

# Download power files
echo -e "${BLUE}Downloading power files...${NC}"
curl -fsSL "$REPO_URL/kiro-expert-power/POWER.md" -o "$POWER_DIR/POWER.md"
curl -fsSL "$REPO_URL/kiro-expert-power/mcp.json" -o "$POWER_DIR/mcp.json"

# Download agent configuration
echo -e "${BLUE}Downloading agent configuration...${NC}"
curl -fsSL "$REPO_URL/.kiro/agents/kiro-expert.json" -o "$AGENT_DIR/kiro-expert.json"

echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo -e "${GREEN}Kiro Expert has been installed successfully!${NC}"
echo ""
echo "Usage:"
echo "  • Kiro IDE: The power is now available in your Powers panel"
echo "  • Kiro CLI: Run 'kiro chat --agent kiro-expert'"
echo ""
echo "Files installed:"
echo "  • Power: $POWER_DIR"
echo "  • Agent: $AGENT_DIR/kiro-expert.json"
