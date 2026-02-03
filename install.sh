#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing Kiro Expert...${NC}"

# GitHub repository details
REPO_URL="https://raw.githubusercontent.com/yytdfc/kiro-expert/main"
REPO_CLONE_URL="https://github.com/yytdfc/kiro-expert.git"

# Generate repo ID using timestamp in milliseconds
REPO_ID="local-$(date +%s)000"

# Installation directories
POWER_DIR="$HOME/.kiro/powers/installed/kiro-expert"
AGENT_DIR="$HOME/.kiro/agents"
REGISTRY_FILE="$HOME/.kiro/powers/registry.json"
REPO_CLONE_DIR="$HOME/.kiro/powers/repos/kiro-expert"
LOCAL_REPO_DIR="$HOME/.kiro/powers/repos/$REPO_ID"
POWER_SOURCE_DIR="$REPO_CLONE_DIR/kiro-expert-power"

# Create directories if they don't exist
echo -e "${BLUE}Creating directories...${NC}"
mkdir -p "$POWER_DIR"
mkdir -p "$AGENT_DIR"
mkdir -p "$LOCAL_REPO_DIR"
mkdir -p "$(dirname "$REGISTRY_FILE")"

# Clone repository
echo -e "${BLUE}Cloning repository...${NC}"
if [ -d "$REPO_CLONE_DIR" ]; then
    echo -e "${BLUE}Repository already exists, pulling latest...${NC}"
    git -C "$REPO_CLONE_DIR" pull
else
    git clone --depth 1 "$REPO_CLONE_URL" "$REPO_CLONE_DIR"
fi

# Copy power files to installed directory
echo -e "${BLUE}Installing power files...${NC}"
cp "$POWER_SOURCE_DIR/POWER.md" "$POWER_DIR/POWER.md"
cp "$POWER_SOURCE_DIR/mcp.json" "$POWER_DIR/mcp.json"

# Copy power files to local repo directory (for version management)
cp "$POWER_SOURCE_DIR/POWER.md" "$LOCAL_REPO_DIR/POWER.md"
cp "$POWER_SOURCE_DIR/mcp.json" "$LOCAL_REPO_DIR/mcp.json"

# Install agent configuration
echo -e "${BLUE}Installing agent configuration...${NC}"
cp "$REPO_CLONE_DIR/.kiro/agents/kiro-expert.json" "$AGENT_DIR/kiro-expert.json"

# Parse POWER.md frontmatter
echo -e "${BLUE}Updating registry...${NC}"

# Extract frontmatter from POWER.md
POWER_MD="$POWER_DIR/POWER.md"
NAME=$(grep '^name:' "$POWER_MD" | sed 's/name: *"\(.*\)"/\1/')
DISPLAY_NAME=$(grep '^displayName:' "$POWER_MD" | sed 's/displayName: *"\(.*\)"/\1/')
DESCRIPTION=$(grep '^description:' "$POWER_MD" | sed 's/description: *"\(.*\)"/\1/')
AUTHOR=$(grep '^author:' "$POWER_MD" | sed 's/author: *"\(.*\)"/\1/')
KEYWORDS=$(grep '^keywords:' "$POWER_MD" | sed 's/keywords: *//' | tr -d '[]' | sed 's/"//g')

# Extract MCP servers from mcp.json
MCP_SERVERS=$(python3 -c "
import json
import sys
try:
    with open('$POWER_DIR/mcp.json', 'r') as f:
        data = json.load(f)
        servers = list(data.get('mcpServers', {}).keys())
        print(json.dumps(servers))
except:
    print('[]')
")

# Get current timestamp in ISO format (macOS compatible)
INSTALLED_AT=$(python3 -c "from datetime import datetime; print(datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S.') + f'{datetime.utcnow().microsecond // 1000:03d}Z')")

# Create or update registry.json
if [ ! -f "$REGISTRY_FILE" ]; then
    echo '{"version": "1.0.0", "powers": {}}' > "$REGISTRY_FILE"
fi

# Update registry using Python for proper JSON handling
python3 << EOF
import json
import sys
from datetime import datetime

registry_file = "$REGISTRY_FILE"
power_name = "$NAME"
power_source_dir = "$POWER_SOURCE_DIR"
repo_id = "$REPO_ID"

# Read existing registry
try:
    with open(registry_file, 'r') as f:
        registry = json.load(f)
except:
    registry = {"version": "1.0.0", "powers": {}, "repoSources": {}}

# Ensure required keys exist
if "powers" not in registry:
    registry["powers"] = {}
if "repoSources" not in registry:
    registry["repoSources"] = {}

# Parse keywords
keywords_str = "$KEYWORDS"
keywords = [k.strip() for k in keywords_str.split(',') if k.strip()]

# Parse MCP servers
mcp_servers = json.loads('$MCP_SERVERS')

# Generate timestamp
timestamp = "$INSTALLED_AT"

# Create power entry
registry["powers"][power_name] = {
    "name": "$NAME",
    "description": "$DESCRIPTION",
    "mcpServers": mcp_servers,
    "author": "$AUTHOR",
    "keywords": keywords,
    "displayName": "$DISPLAY_NAME",
    "installed": True,
    "installedAt": timestamp,
    "installPath": "$POWER_DIR",
    "source": {
        "type": "repo",
        "repoId": repo_id,
        "repoName": power_source_dir
    },
    "sourcePath": power_source_dir
}

# Create or update repoSource entry
registry["repoSources"][repo_id] = {
    "name": power_source_dir,
    "type": "local",
    "enabled": True,
    "addedAt": timestamp,
    "powerCount": 1,
    "path": power_source_dir,
    "lastSync": timestamp
}

# Write back to registry
with open(registry_file, 'w') as f:
    json.dump(registry, f, indent=2)

print("Registry updated successfully")
EOF

echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo -e "${GREEN}Kiro Expert has been installed successfully!${NC}"
echo ""
echo -e "${YELLOW}⚠ Please restart Kiro IDE to activate the power.${NC}"
echo ""
echo "Usage:"
echo "  • Kiro IDE: The power is now available in your Powers panel"
echo "  • Kiro CLI: Run 'kiro chat --agent kiro-expert'"
echo ""
echo "Files installed:"
echo "  • Power: $POWER_DIR"
echo "  • Repository: $REPO_CLONE_DIR"
echo "  • Local cache: $LOCAL_REPO_DIR"
echo "  • Agent: $AGENT_DIR/kiro-expert.json"
echo "  • Registry: $REGISTRY_FILE"
