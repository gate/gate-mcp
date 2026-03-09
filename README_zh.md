# Gate MCP 服务器

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-协议-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

一个 [MCP (Model Context Protocol)](https://modelcontextprotocol.io) 服务器，将 Gate 交易 API 以工具形式提供给 AI 智能体使用。

## 功能特性

- **市场数据** — 现货/合约行情、深度、K 线、资金费率、强平历史
- **交易** — 现货/合约下单、撤单、改单
- **账户与钱包** — 余额、划转、充值提现、子账户
- **OAuth2 授权** — 所有工具均需 Gate 账号登录（含公开数据）

## 授权说明（OAuth2）

**所有访问均需 OAuth2 授权**，包括市场数据。使用前须先登录 Gate 账号。

### mcporter（推荐）

```bash
# 1. 添加 MCP 服务器（OAuth 模式）
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp --auth oauth

# 2. 授权登录（打开浏览器）
mcporter auth gate-mcp
```

### scope 说明

| scope | 用途 |
|-------|------|
| `market` | 市场数据 |
| `profile` | 账户、订单、仓位（只读） |
| `trade` | 下单、撤单、改单 |
| `wallet` | 划转、充值提现 |
| `account` | 统一账户、子账户 |

## 前置条件

- **Gate 账号**
- **MCP 端点**：`https://api.gatemcp.ai/mcp`（需 OAuth 授权）
- **Node.js** >= 18（mcporter、Trae 等客户端）
- **Python** >= 3.9（可选，Claude Desktop 代理）

## 快速开始

选择你使用的客户端：

### Cursor

编辑 `~/.cursor/mcp.json`，连接后会提示 OAuth 登录：

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

详见 [Cursor 配置指南](docs/setup-cursor-zh.md)。

### mcporter / OpenClaw（推荐）

```bash
# 先安装 mcporter
npm install -g mcporter

# 添加 MCP 并授权
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp --auth oauth
mcporter auth gate-mcp
```

### Claude CLI

```bash
brew install claude-code
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp
# 连接时会提示 OAuth 登录
claude mcp list
# 授权完成之后，需要重启
```

### Trae

编辑 Trae 设置，使用 `mcp-remote` 代理 HTTP MCP（首次连接会提示 OAuth 登录）：

```json
{
  "mcpServers": {
    "gate": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp"
      ]
    }
  }
}
```

### Qoder

编辑 Qoder MCP 配置（如 `~/.qoder/mcp.json` 或 Qoder 设置中）：

```json
{
  "mcpServers": {
    "gate": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp"
      ]
    }
  }
}
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
| Trae | 见上文 Trae 配置 |
| Qoder | 见上文 Qoder 配置 |

### 基础用法

- 「BTC/USDT 当前价格多少？」
- 「查看 ETH/USDT 的订单簿」
- 「获取 BTC 最近 7 天日 K 线」

---

## 工具列表

按 scope 分组，详见 [授权说明](#授权说明oauth2)。完整参数见 [gate-exchange 详情](gate-exchange/gate-exchange-mcp_zh.md)。

### 市场数据 (scope: `market`)

| 工具 | 描述 |
|------|------|
| `list_currencies` / `get_currency` | 币种列表/详情 |
| `list_currency_pairs` / `get_currency_pair` | 交易对列表/详情 |
| `get_spot_tickers` / `get_spot_order_book` / `get_spot_trades` / `get_spot_candlesticks` | 现货行情、深度、成交、K 线 |
| `list_futures_contracts` / `get_futures_contract` | 合约列表/详情 |
| `get_futures_tickers` / `get_futures_order_book` / `get_futures_trades` / `get_futures_candlesticks` | 合约行情、深度、成交、K 线 |
| `get_futures_funding_rate` / `get_futures_premium_index` / `list_futures_liq_orders` | 资金费率、溢价指数、强平历史 |

### 现货交易 (scope: `profile` / `trade`)

| 工具 | 描述 |
|------|------|
| `get_spot_accounts` | 现货账户余额 |
| `list_spot_orders` / `get_spot_order` | 订单查询 |
| `list_spot_my_trades` / `list_spot_account_book` | 成交、流水 |
| `get_spot_fee` / `get_spot_batch_fee` | 费率查询 |
| `create_spot_order` / `create_spot_batch_orders` | 下单（单个/批量） |
| `cancel_spot_order` / `cancel_all_spot_orders` / `cancel_spot_batch_orders` | 撤单 |
| `amend_spot_order` / `amend_spot_batch_orders` | 改单 |

### 合约交易 (scope: `profile` / `trade`)

| 工具 | 描述 |
|------|------|
| `get_futures_accounts` | 合约账户 |
| `list_futures_positions` / `get_futures_position` / `get_futures_dual_mode_position` | 仓位查询 |
| `list_futures_orders` / `get_futures_order` / `get_futures_orders_timerange` | 订单查询 |
| `list_futures_my_trades` / `get_futures_my_trades_timerange` | 成交查询 |
| `list_futures_account_book` / `get_futures_fee` | 流水、费率 |
| `list_futures_risk_limit_tiers` | 风险限额档位 |
| `create_futures_order` / `create_futures_batch_orders` | 下单 |
| `cancel_futures_order` / `cancel_all_futures_orders` / `cancel_futures_batch_orders` | 撤单 |
| `amend_futures_order` / `amend_futures_batch_orders` | 改单 |
| `update_futures_position_leverage` / `update_futures_position_margin` / `update_futures_position_cross_mode` | 仓位设置 |
| `set_futures_dual_mode` / `update_futures_dual_mode_position_margin` / `update_futures_dual_mode_position_leverage` / `update_futures_dual_mode_position_risk_limit` | 双向持仓设置 |

### 钱包与账户 (scope: `wallet` / `account`)

| 工具 | 描述 |
|------|------|
| `get_total_balance` / `create_transfer` | 总资产、划转 |
| `get_wallet_fee` / `get_transfer_order_status` | 提现费、划转状态 |
| `list_deposits` / `list_withdrawals` | 充值、提现记录 |
| `create_sub_account_transfer` / `create_sub_account_to_sub_account_transfer` | 子账户划转 |
| `get_unified_accounts` / `get_unified_mode` / `set_unified_mode` | 统一账户 |
| `list_unified_loans` / `get_unified_risk_units` / `get_unified_borrowable` | 借贷、风险单元 |
| `list_sub_accounts` / `get_sub_account` / `create_sub_account` | 子账户管理 |
| `list_sub_account_keys` / `create_sub_account_key` / `get_sub_account_key` / `update_sub_account_key` / `delete_sub_account_key` | 子账户 API Key |
| `lock_sub_account` / `unlock_sub_account` / `get_sub_account_unified_mode` | 子账户锁定 |

---

## 常见问题

### Q: 需要 Gate 账号吗？

A: **需要**。所有工具均需 OAuth2 授权，包括市场数据。请通过 mcporter（`mcporter auth gate-mcp`）或客户端的 OAuth 流程登录。

### Q: 支持交易吗？

A: 支持。提供现货、合约交易，账户管理，钱包划转，子账户等。各工具需对应 scope。

### Q: 数据更新频率？

A: 实时查询 Gate API。

---

## 隐私与安全

- 通过 Gate 账号 OAuth2 授权，不在配置中存储 API 密钥
- 所有请求使用 HTTPS
- 详见 [Gate 隐私政策](https://www.gate.com/legal/privacy-policy)

---

## 支持与反馈

- **API 文档**：[Gate API](https://www.gate.com/docs/developers/apiv4)
- **问题反馈**：请联系 Gate 客服
- **商务合作**：Gate 官方渠道

---

## 参与贡献

欢迎贡献！请阅读我们的 [贡献指南](CONTRIBUTING.md) 了解更多信息。

## 许可证

[MIT](LICENSE) © gate.com
