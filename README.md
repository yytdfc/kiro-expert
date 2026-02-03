# Kiro Expert

Expert assistant for Kiro documentation queries. Searches official Kiro docs using AI-powered semantic search and provides accurate answers with source citations.

## Installation

### Method 1: Via GitHub Repository (Power for Kiro IDE)

1. Open Kiro IDE
2. Open Powers panel (Command Palette → "Open Kiro Powers")
3. Click "Add Custom Power"
4. Select "GitHub Repository"
5. Enter: `https://github.com/yytdfc/kiro-expert`
6. Click "Add"

### Method 2: Local Directory (Power for Kiro IDE)

1. Clone this repository:
   ```bash
   git clone https://github.com/yytdfc/kiro-expert.git
   ```
2. Open Kiro IDE
3. Open Powers panel
4. Click "Add Custom Power"
5. Select "Local Directory"
6. Browse to the cloned `kiro-expert` directory
7. Click "Add"

### Method 3: Sub-Agent Configuration (Kiro CLI)

1. Clone this repository:
   ```bash
   git clone https://github.com/yytdfc/kiro-expert.git
   ```

2. Copy the agent configuration to your workspace:
   ```bash
   cp kiro-expert/.kiro/agents/kiro-expert.json .kiro/agents/
   ```

3. Use the agent:
   ```bash
   kiro chat --agent kiro-expert
   ```

## Usage

Once installed, the Kiro Expert power will help you search Kiro documentation and get accurate answers with source citations.

Simply ask questions about Kiro naturally, and the agent will search the documentation and provide accurate answers.

## Requirements

- Kiro IDE or CLI
- Internet connection (uses remote MCP server)

## License

MIT
