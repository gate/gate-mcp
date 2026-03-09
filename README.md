# Gate MCP Server

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-Protocol-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

---

A Gate MCP (Model Context Protocol) server that enables AI agents to interact with the Gate cryptocurrency exchange for market data, trading, and account management.

## Features

- 🔍 **Spot & Futures Market** - Tickers, order books, trades, K-line, funding rate, liquidation history
- 💹 **Trading** - Create/cancel/amend spot and futures orders
- 💼 **Account & Wallet** - Balances, transfers, deposits, withdrawals, sub-accounts
- 🔐 **OAuth2** - Secure authorization via Gate account login (all tools require auth)

## Authorization (OAuth2)

**All access requires OAuth2 authorization**, including public market data. You must log in with your Gate account before using any tool.

### Using mcporter (Recommended)

```bash
# 1. Add MCP server with OAuth auth
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp --auth oauth

# 2. Authorize (opens browser to log in)
mcporter auth gate-mcp
```

### Scopes

| Scope | Use |
|-------|-----|
| `market` | Market data (tickers, order book, K-line, funding rate, etc.) |
| `profile` | Account info, orders, positions (read-only) |
| `trade` | Create/cancel/amend orders |
| `wallet` | Transfers, deposits, withdrawals |
| `account` | Unified account, sub-accounts |

## Quick Start

### Prerequisites

- Gate account
- MCP-compatible client (Cursor, Claude CLI, Trae, OpenClaw, etc.)
- **MCP Endpoint**: `https://api.gatemcp.ai/mcp` (OAuth required)

### Cursor

Edit `~/.cursor/mcp.json` (OAuth prompt on connect):

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

See [Cursor setup](docs/setup-cursor.md).

### mcporter / OpenClaw (Recommended)

```bash
# Install mcporter first
npm install -g mcporter

# Add MCP with OAuth, then authorize
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp --auth oauth
mcporter auth gate-mcp
```

### Claude CLI

```bash
brew install claude-code
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp
claude mcp list
```

### Trae

Edit Trae settings. Uses `mcp-remote` to proxy HTTP MCP (OAuth prompt on first connect):

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

Edit Qoder MCP settings (e.g. `~/.qoder/mcp.json` or in Qoder settings):

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

Claude Desktop requires a local stdio proxy. See [Claude Desktop setup](docs/setup-claude-desktop.md).

### Other Clients

| Client | Guide |
|--------|-------|
| Claude.ai | [setup](docs/setup-claude-ai.md) |
| Codex App | [setup](docs/setup-codex-app.md) |
| Codex CLI | [setup](docs/setup-codex-cli.md) |
| OpenClaw | [setup](docs/setup-openclaw.md) |
| Trae | See Trae config above |
| Qoder | See Qoder config above |

### Basic Usage

**Query Price**
> What's the current price of BTC/USDT?

**Get Order Book**
> Show me the order book for ETH/USDT

**K-line Data**
> Get the daily K-line data for BTC over the last 7 days

---

## Available Tools

Tools are grouped by scope. See [Authorization](#authorization-oauth2) for scope details.

### Market Data (scope: `market`)

| Tool | Description |
|------|-------------|
| `list_currencies` | All supported currencies |
| `get_currency` | Single currency info |
| `list_currency_pairs` | All trading pairs |
| `get_currency_pair` | Single trading pair details |
| `get_spot_tickers` | Spot tickers (price, volume, change) |
| `get_spot_order_book` | Spot order book depth |
| `get_spot_trades` | Spot trade history |
| `get_spot_candlesticks` | Spot K-line data |
| `list_futures_contracts` | All perpetual contracts |
| `get_futures_contract` | Single contract details |
| `get_futures_tickers` | Futures tickers |
| `get_futures_order_book` | Futures order book |
| `get_futures_trades` | Futures trade history |
| `get_futures_candlesticks` | Futures K-line |
| `get_futures_funding_rate` | Funding rate history |
| `get_futures_premium_index` | Premium index K-line |
| `list_futures_liq_orders` | Liquidation history |

### Spot Trading (scope: `profile` / `trade`)

| Tool | Description |
|------|-------------|
| `get_spot_accounts` | Spot account balances |
| `list_spot_orders` / `get_spot_order` | Order queries |
| `list_spot_my_trades` / `list_spot_account_book` | Trades, account book |
| `get_spot_fee` / `get_spot_batch_fee` | Fee rates |
| `create_spot_order` / `create_spot_batch_orders` | Place order(s) |
| `cancel_spot_order` / `cancel_all_spot_orders` / `cancel_spot_batch_orders` | Cancel orders |
| `amend_spot_order` / `amend_spot_batch_orders` | Amend order(s) |

### Futures Trading (scope: `profile` / `trade`)

| Tool | Description |
|------|-------------|
| `get_futures_accounts` | Futures account |
| `list_futures_positions` / `get_futures_position` / `get_futures_dual_mode_position` | Position queries |
| `list_futures_orders` / `get_futures_order` / `get_futures_orders_timerange` | Order queries |
| `list_futures_my_trades` / `get_futures_my_trades_timerange` | Personal trades |
| `list_futures_account_book` / `get_futures_fee` | Account book, fee |
| `list_futures_risk_limit_tiers` | Risk limit tiers |
| `create_futures_order` / `create_futures_batch_orders` | Place order(s) |
| `cancel_futures_order` / `cancel_all_futures_orders` / `cancel_futures_batch_orders` | Cancel orders |
| `amend_futures_order` / `amend_futures_batch_orders` | Amend order(s) |
| `update_futures_position_leverage` / `update_futures_position_margin` / `update_futures_position_cross_mode` | Position settings |
| `set_futures_dual_mode` / `update_futures_dual_mode_position_margin` / `update_futures_dual_mode_position_leverage` / `update_futures_dual_mode_position_risk_limit` | Dual-mode position settings |

### Wallet & Account (scope: `wallet` / `account`)

| Tool | Description |
|------|-------------|
| `get_total_balance` | Total account balance |
| `create_transfer` | Internal transfer |
| `get_wallet_fee` / `get_transfer_order_status` | Fee, transfer status |
| `list_deposits` / `list_withdrawals` | Deposit/withdrawal records |
| `create_sub_account_transfer` / `create_sub_account_to_sub_account_transfer` | Sub-account transfers |
| `get_unified_accounts` / `get_unified_mode` / `set_unified_mode` | Unified account |
| `list_unified_loans` / `get_unified_risk_units` / `get_unified_borrowable` | Loans, risk units |
| `list_sub_accounts` / `get_sub_account` / `create_sub_account` | Sub-account management |
| `list_sub_account_keys` / `create_sub_account_key` / `get_sub_account_key` / `update_sub_account_key` / `delete_sub_account_key` | Sub-account API keys |
| `lock_sub_account` / `unlock_sub_account` / `get_sub_account_unified_mode` | Sub-account lock/unlock |

For full tool parameters, see [Gate API Docs](https://www.gate.com/docs/developers/apiv4) or [gate-exchange-mcp](gate-exchange/gate-exchange-mcp.md).

---

## FAQ

### Q: Do I need a Gate account?

A: Yes. **All tools require OAuth2 authorization**, including market data. Log in with your Gate account via mcporter (`mcporter auth gate-mcp`) or your client's OAuth flow.

### Q: Does it support trading?

A: Yes. The server supports spot and futures trading, account management, wallet transfers, and sub-accounts. Each tool requires the appropriate scope (e.g. `trade`, `wallet`).

### Q: How often is the data updated?

A: Data is queried in real-time from Gate's API.

---

## Privacy & Security

- OAuth2 authorization via Gate account (no API keys stored in config)
- All API calls use HTTPS
- See [Gate Privacy Policy](https://www.gate.com/legal/privacy-policy)

---

## Support & Feedback

- **API Documentation**: [Gate API Docs](https://www.gate.com/docs/developers/apiv4)
- **Issue Reporting**: Please contact Gate support
- **Business Inquiries**: Contact Gate official channels

---


## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

[MIT](LICENSE) © gate.com

