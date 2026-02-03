# Kiro Expert

[中文文档](README_CN.md)

Expert assistant for Kiro documentation queries. Searches official Kiro docs using AI-powered semantic search and provides accurate answers with source citations.

## Installation

One-line installation:

```bash
curl -fsSL https://raw.githubusercontent.com/yytdfc/kiro-expert/main/install.sh | bash
```

This will install:
- Power to `~/.kiro/powers/installed/kiro-expert/`
- Agent configuration to `~/.kiro/agents/kiro-expert.json`

### Manual Installation (for developers)

If you want to customize or debug:

1. Clone this repository:
   ```bash
   git clone https://github.com/yytdfc/kiro-expert.git
   ```

2. Install power from local folder:
   - Open Kiro IDE
   - Open Powers panel (Command Palette → "Open Kiro Powers")
   - Click "Add Custom Power"
   - Select "Local Directory"
   - Browse to `kiro-expert/kiro-expert-power/` directory
   - Click "Add"

3. Copy agent configuration:
   ```bash
   mkdir -p ~/.kiro/agents
   cp kiro-expert/.kiro/agents/kiro-expert.json ~/.kiro/agents/
   ```

## Usage

Once installed, the Kiro Expert power will help you search Kiro documentation and get accurate answers with source citations.

Simply ask questions about Kiro naturally, and the agent will search the documentation and provide accurate answers.

**For Kiro IDE:**
- The power is automatically available in your Powers panel

**For Kiro CLI:**
```bash
kiro chat --agent kiro-expert
```

## Requirements

- Kiro IDE or CLI
- Internet connection (uses remote MCP server)

## License

MIT
