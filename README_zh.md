# Gate AI MCP 服务器

[English](README.md) | [中文](README_zh.md)

一个 [MCP (Model Context Protocol)](https://modelcontextprotocol.io) 服务器，将 Gate.io 交易 API 以工具形式提供给 AI 智能体使用。

## 功能特性

- **现货市场** — 行情、深度、K线、成交记录、币种及交易对信息
- **合约市场** — 合约信息、行情、深度、K线、成交记录
- **资金费率** — 历史资金费率查询
- **溢价指数** — 合约溢价指数 K 线
- **强平订单** — 合约强平历史记录

👉 [查看完整工具详情与文档](gate-mcp-server.md)

## 快速开始

### 在 Cursor 中配置

**第 1 步：** Cursor Settings → Tools & MCP → Add Custom MCP

![Cursor 添加 MCP](images/cursor-add-mcp.png)

**第 2 步：** 编辑 `mcp.json`：

```json
{
  "mcpServers": {
    "Gate": {
      "url": "https://api.gatemcp.ai/gate-mcp/mcp",
      "transport": "streamable-http",
      "headers": {
         "Content-Type": "application/json",
        "Accept": "application/json, text/event-stream"
      }
    }
  }
}
```

![Cursor MCP JSON 配置](images/cursor-mcp-json.png)

**第 3 步：** 在 Cursor AI 对话中使用 MCP，如 "查询 BTC/USDT 的价格"

![Cursor 使用示例](images/cursor-usage.png)

### 在 Claude.ai 中配置

**第 1 步：** Settings → Connectors → Add custom connector

![Claude.ai 添加 Connector](images/claude-ai-connector.png)

### 在 Claude CLI 中配置

**第 1 步：** 安装 Claude Code

参考：https://code.claude.com/docs/zh-CN/overview#homebrew

```bash
brew install claude-code
```

**第 2 步：** 添加 Gate MCP

```bash
claude mcp add --transport http Gate https://api.gatemcp.ai/gate-mcp/mcp
```

![Claude CLI 添加 MCP](images/claude-cli-add-mcp.png)

**第 3 步：** 验证是否生效

```bash
claude mcp list
```

![Claude CLI 列表](images/claude-cli-list.png)

**第 4 步：** 在 Claude CLI 对话中使用，例如：

- 查询 BTC/USDT 的价格
- 帮我查下 Gate 有什么套利空间？
- 帮我分析一下 SOL
- Gate 有没有新币值得关注？

![Claude CLI 使用示例](images/claude-cli-usage.png)

### 在 Claude Desktop 中配置

Claude Desktop 仅支持本地 stdio 方式运行，需要使用本地 MCP 代理。

**第 1 步：** 下载 Python 代理文件 [gate-mcp-proxy.py](gate-mcp-proxy.py) 到本地

**第 2 步：** 修改 Claude 配置文件

![Claude Desktop 配置](images/claude-desktop-config.png)

- **macOS：** `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Windows：** `%APPDATA%\Claude\claude_desktop_config.json`

将 `args` 参数设为第 1 步中代理文件的路径：

```json
{
  "mcpServers": {
    "Gate": {
      "command": "python3",
      "args": ["/path/to/gate-mcp-proxy.py"]
    }
  }
}
```

**第 3 步：** 重启 Claude Desktop 并验证，如 "列出 gate mcp 的可用工具"

![Claude Desktop 验证](images/claude-desktop-verify.png)

**第 4 步：** 在 Claude Desktop 对话中使用，如 "查询 BTC/USDT 的价格"

![Claude Desktop 使用示例](images/claude-desktop-usage.png)

### 在 Codex App 中配置

**第 1 步：** 打开 Codex 设置

![Codex App 设置](images/codex-app-settings.png)

**第 2 步：** MCP 服务器 → 添加服务器

![Codex App 添加服务器](images/codex-app-add-server.png)

**第 3 步：** 配置自定义 MCP 并保存

![Codex App 配置](images/codex-app-config.png)

**第 4 步：** 在 Codex App 对话中使用，如 "查询 BTC/USDT 的价格"

![Codex App 使用示例](images/codex-app-usage.png)

### 在 Codex CLI 中配置

**第 1 步：** 添加 Gate MCP

```bash
codex mcp add gate --url https://api.gatemcp.ai/gate-mcp/mcp
```

![Codex CLI 添加 MCP](images/codex-cli-add-mcp.png)

**第 2 步：** 验证是否生效

```bash
codex mcp list
```

![Codex CLI 列表](images/codex-cli-list.png)

**第 3 步：** 在 Codex CLI 对话中使用，如 "查询 BTC/USDT 的价格"

![Codex CLI 使用示例](images/codex-cli-usage.png)

### 在 OpenClaw 中配置

**第 1 步：** 在 OpenClaw → Skills 中搜索 `mcporter` 并启用

![OpenClaw 启用 mcporter](images/openclaw-enable-mcporter.png)

**第 2 步：** 本地安装 mcporter

```bash
npm i -g mcporter
# 或
npx mcporter --version
```

**第 3 步：** 配置 Gate MCP

```bash
mcporter config add gate https://api.gatemcp.ai/gate-mcp/mcp --scope home
```

**第 4 步：** 验证配置是否生效

```bash
mcporter config get gate
mcporter list gate --schema
```

> 能返回工具列表就说明连通成功。

**第 5 步：** 在 OpenClaw 中重新建立会话，使用 MCP，如 "查询 BTC/USDT 的价格"

![OpenClaw 使用示例](images/openclaw-usage.png)

## 工具列表

| 工具 | 说明 |
|------|------|
| `list_currencies` | 查询所有币种信息 |
| `get_currency` | 获取单个币种详情 |
| `list_currency_pairs` | 查询所有交易对 |
| `get_currency_pair` | 获取单个交易对详情 |
| `get_spot_tickers` | 获取现货行情 |
| `get_spot_order_book` | 获取现货市场深度 |
| `get_spot_candlesticks` | 获取现货 K 线数据 |
| `get_spot_trades` | 获取现货成交记录 |
| `list_futures_contracts` | 查询所有合约信息 |
| `get_futures_contract` | 获取单个合约详情 |
| `get_futures_tickers` | 获取合约行情 |
| `get_futures_order_book` | 获取合约市场深度 |
| `get_futures_candlesticks` | 获取合约 K 线数据 |
| `get_futures_trades` | 获取合约成交记录 |
| `get_futures_funding_rate` | 获取历史资金费率 |
| `get_futures_premium_index` | 获取合约溢价指数 K 线 |
| `list_futures_liq_orders` | 获取合约强平历史 |

## 许可证

MIT
