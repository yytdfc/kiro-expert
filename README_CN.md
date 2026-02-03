# Kiro Expert

Kiro 文档专家助手。使用 AI 语义搜索官方 Kiro 文档，提供准确答案并附带来源引用。

## 安装

一键安装：

```bash
curl -fsSL https://raw.githubusercontent.com/yytdfc/kiro-expert/main/install.sh | bash
```

安装完成后，**请重启 Kiro IDE** 以激活 Power。

安装内容：
- Power 文件：`~/.kiro/powers/installed/kiro-expert/`
- Agent 配置：`~/.kiro/agents/kiro-expert.json`

### 手动安装（开发者）

如需自定义或调试：

1. 克隆仓库：
   ```bash
   git clone https://github.com/yytdfc/kiro-expert.git
   ```

2. 从本地目录安装 Power：
   - 打开 Kiro IDE
   - 打开 Powers 面板（命令面板 → "Open Kiro Powers"）
   - 点击 "Add Custom Power"
   - 选择 "Local Directory"
   - 浏览到 `kiro-expert/kiro-expert-power/` 目录
   - 点击 "Add"

3. 复制 Agent 配置：
   ```bash
   mkdir -p ~/.kiro/agents
   cp kiro-expert/.kiro/agents/kiro-expert.json ~/.kiro/agents/
   ```

## 使用方法

安装后，Kiro Expert 可以帮助你搜索 Kiro 文档并获取准确答案（附带来源引用）。

直接用自然语言提问关于 Kiro 的问题，助手会搜索文档并提供准确答案。

**Kiro IDE：**
- Power 会自动出现在 Powers 面板中

**Kiro CLI：**
```bash
kiro chat --agent kiro-expert
```

## 依赖

- Kiro IDE 或 CLI
- 网络连接（使用远程 MCP 服务器）

## 许可证

MIT
