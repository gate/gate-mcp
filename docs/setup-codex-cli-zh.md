# Codex CLI 配置指南

## 前置条件

- 拥有 Codex 访问权限的 OpenAI API 密钥
- Node.js >= 18

## 第 1 步：安装 Codex CLI

全局安装 OpenAI Codex CLI：

```bash
npm install -g @openai/codex
```

或使用 npx（无需安装）：

```bash
npx @openai/codex --version
```

## 第 2 步：配置 OpenAI API 密钥

设置你的 OpenAI API 密钥：

```bash
export OPENAI_API_KEY="your-api-key-here"
```

或将其添加到 shell 配置文件（`~/.bashrc`、`~/.zshrc` 等）：

```bash
echo 'export OPENAI_API_KEY="your-api-key-here"' >> ~/.zshrc
source ~/.zshrc
```

## 第 3 步：添加 Gate MCP

**完整交易能力（OAuth）：**

```bash
codex mcp add gate --url https://api.gatemcp.ai/mcp/exchange
```

**仅查行情（无需认证）：**

```bash
codex mcp add gate --url https://api.gatemcp.ai/mcp
```

![Codex CLI 添加 MCP](../images/codex-cli-add-mcp.png)

## 第 4 步：验证安装

列出所有配置的 MCP 服务器：

```bash
codex mcp list
```

你应该能在列表中看到 Gate MCP 服务器。

![Codex CLI 列表](../images/codex-cli-list.png)

## 第 5 步：开始使用

启动 Codex CLI：

```bash
codex
```

尝试以下示例查询：

- "查询 BTC/USDT 的当前价格"
- "帮我查下 Gate 有什么套利空间？"
- "帮我分析一下 SOL"
- "Gate 有没有新币值得关注？"

![Codex CLI 使用示例](../images/codex-cli-usage.png)

## 更新 MCP 服务器

如需更新 MCP 服务器 URL 或配置：

```bash
codex mcp remove gate
codex mcp add gate --url https://api.gatemcp.ai/mcp/exchange
```

## 故障排除

### "OPENAI_API_KEY not set" 错误

确保你已设置 OpenAI API 密钥：

```bash
export OPENAI_API_KEY="your-api-key-here"
```

### MCP 服务器未找到

1. 检查 MCP 是否正确添加：`codex mcp list`
2. 尝试移除并重新添加 MCP
3. 检查网络连接

### 连接错误

1. 验证 URL 是否正确：`https://api.gatemcp.ai/mcp/exchange`（交易）或 `https://api.gatemcp.ai/mcp`（行情）
2. 检查是否需要代理或 VPN
3. 稍后再试（服务器可能暂时不可用）

## 下一步

- 探索所有[可用工具](../README_zh.md#工具列表)
- 了解[合约工具](../README_zh.md#public-mcpmcp--无需认证)
- 查看 [API 文档](https://www.gate.com/docs/developers/apiv4/)
