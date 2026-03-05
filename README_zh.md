# Gate MCP 服务器

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-协议-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

一个 [MCP (Model Context Protocol)](https://modelcontextprotocol.io) 服务器，将 Gate.io 交易 API 以工具形式提供给 AI 智能体使用。

## 功能特性

- **现货市场** — 行情、深度、K线、成交记录、币种及交易对信息
- **合约市场** — 合约信息、行情、深度、K线、成交记录
- **资金费率** — 历史资金费率查询
- **溢价指数** — 合约溢价指数 K 线
- **强平订单** — 合约强平历史记录

## 前置条件

- **Node.js** >= 18（MCP 客户端）
- **Python** >= 3.9（可选，用于本地代理）

## 快速开始

选择你使用的客户端：

### Cursor

编辑 `~/.cursor/mcp.json`：

```json
{
  "mcpServers": {
    "Gate": {
      "url": "https://api.gatemcp.ai/mcp",
      "transport": "streamable-http",
      "headers": {
        "Content-Type": "application/json",
        "Accept": "application/json, text/event-stream"
      }
    }
  }
}
```

详细配置说明请参考 [Cursor 配置指南](docs/setup-cursor-zh.md)。

### Claude CLI

```bash
# 安装 Claude Code
brew install claude-code

# 添加 Gate MCP
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp

# 验证
claude mcp list
```

### Claude Desktop

Claude Desktop 需要使用本地 stdio 代理。

1. 下载 [Python 代理文件](gate-mcp-proxy.py)
2. 编辑 `~/Library/Application Support/Claude/claude_desktop_config.json`：

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

详细配置说明请参考 [Claude Desktop 配置指南](docs/setup-claude-desktop-zh.md)。

### 其他客户端

| 客户端 | 配置指南 |
|--------|----------|
| Claude.ai | [配置说明](docs/setup-claude-ai-zh.md) |
| Codex App | [配置说明](docs/setup-codex-app-zh.md) |
| Codex CLI | [配置说明](docs/setup-codex-cli-zh.md) |
| OpenClaw | [配置说明](docs/setup-openclaw-zh.md) |

## 工具列表

### 现货市场

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

### 合约市场

| 工具 | 说明 |
|------|------|
| `list_futures_contracts` | 查询所有合约信息 |
| `get_futures_contract` | 获取单个合约详情 |
| `get_futures_tickers` | 获取合约行情 |
| `get_futures_order_book` | 获取合约市场深度 |
| `get_futures_candlesticks` | 获取合约 K 线数据 |
| `get_futures_trades` | 获取合约成交记录 |
| `get_futures_funding_rate` | 获取历史资金费率 |
| `get_futures_premium_index` | 获取合约溢价指数 K 线 |
| `list_futures_liq_orders` | 获取合约强平历史 |

## 开发

```bash
# 克隆仓库
git clone https://github.com/gateio/gate-ai-mcp.git
cd gate-ai-mcp

# 安装依赖
npm install

# 开发模式运行
npm run dev

# 运行测试
npm test
```

## 参与贡献

欢迎贡献！请阅读我们的 [贡献指南](CONTRIBUTING.md) 了解更多信息。

## 许可证

[MIT](LICENSE) © gate.com
