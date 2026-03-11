# Claude CLI 配置指南

## 前置条件

- macOS 或 Linux
- 已安装 Homebrew

## 第 1 步：安装 Claude Code

```bash
brew install claude-code
```

其他安装方法请参考[官方文档](https://code.claude.com/docs)。

## 第 2 步：添加 Gate MCP

**完整交易能力（OAuth）：**

```bash
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp/exchange
# 连接时会提示 OAuth 登录
claude mcp list
```

**仅查行情（无需认证）：**

```bash
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp
claude mcp list
```

![Claude CLI 添加 MCP](../images/claude-cli-add-mcp.png)

## 第 3 步：验证安装

```bash
claude mcp list
```

你应该能看到 Gate MCP 服务器在列表中。

![Claude CLI 列表](../images/claude-cli-list.png)

## 第 4 步：开始使用

启动 Claude CLI 对话：

```bash
claude
```

尝试以下示例查询：

- "查询 BTC/USDT 的当前价格"
- "帮我查下 Gate 有什么套利空间？"
- "帮我分析一下 SOL"
- "Gate 有没有新币值得关注？"

## 更新配置

如需更新 MCP 服务器 URL 或配置：

```bash
claude mcp remove Gate
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp/exchange
```

## 故障排除

### MCP 未找到

1. 检查 MCP 是否正确添加：`claude mcp list`
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
