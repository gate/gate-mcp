# Gate MCP Server

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-Protocol-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

---

A Gate MCP (Model Context Protocol) server that enables AI agents to interact with the Gate cryptocurrency exchange for market data, trading, and account management.

## Features

- 🔍 **Public Market Data** - Spot & futures tickers, order books, trades, K-line, funding rate, liquidation history (**no auth required**)
- 💹 **Trading** - Create/cancel/amend spot and futures orders
- 💼 **Account & Wallet** - Balances, transfers, deposits, withdrawals, sub-accounts
- 🔐 **OAuth2** - Secure authorization for trading and private tools

## MCP Endpoints

The service exposes two MCP endpoints:

| Endpoint | Auth | Tools |
|----------|------|-------|
| `https://api.gatemcp.ai/mcp` | None | Market data only (17 public tools: spot + futures) |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | Trading & account tools (66 tools: spot/futures trading, wallet, unified account, sub-accounts) |

- **Market data only** → Use `/mcp` (no Gate account needed)
- **Trading, balances, transfers** → Use `/mcp/exchange` (OAuth2 required)

Transport: Streamable HTTP (with SSE fallback).

## Authorization (OAuth2)

**Only `/mcp/exchange` requires OAuth2.** The public endpoint `/mcp` does not require any authentication.

### Using mcporter (Recommended)

> **Prerequisites**: Node.js >= 18, npm. See [Quick Start - mcporter](#mcporter--openclaw-recommended) for full installation steps.

```bash
# Add Private MCP (trading, requires OAuth)
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp/exchange --auth oauth

# Authorize (opens browser to log in)
mcporter auth gate-mcp
```

### Scopes (for `/mcp/exchange`)

| Scope | Use |
|-------|-----|
| `market` | Public market data (tickers, order books, K-line, etc.) |
| `profile` | Account info, orders, positions (read-only) |
| `trade` | Create/cancel/amend orders |
| `wallet` | Transfers, deposits, withdrawals |
| `account` | Unified account, sub-accounts |

## Quick Start

### Prerequisites

- **Gate account** (required only for `/mcp/exchange`)
- MCP-compatible client (Cursor, Claude CLI, Trae, OpenClaw, etc.)
- **Node.js** >= 18 (for mcporter, Trae, Qoder, and other npm-based clients)
- **Python** >= 3.9 (optional, for Claude Desktop proxy)

### Cursor

**For full trading (OAuth on connect):**

Edit `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "Gate": {
      "url": "https://api.gatemcp.ai/mcp/exchange",
      "transport": "streamable-http",
      "headers": {
        "Content-Type": "application/json",
        "Accept": "application/json, text/event-stream"
      }
    }
  }
}
```

**For market data only (no auth):**

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

#### Prerequisites (before installing mcporter)

- **Node.js** >= 18 (mcporter requires npm)
- **npm** (comes with Node.js) — verify with: `node -v` and `npm -v`
- **Gate account** (for OAuth login when using `/mcp/exchange`)

#### Install mcporter

```bash
# Global install
npm install -g mcporter

# Verify installation
mcporter --version
```

Alternatively, run without installing: `npx mcporter <command>` (uses current Node.js/npm).

#### Add MCP and authorize

```bash
# Add Private MCP (trading, OAuth)
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp/exchange --auth oauth

# Authorize (opens browser to log in)
mcporter auth gate-mcp
```

See [OpenClaw setup](docs/setup-openclaw.md) for detailed steps.

### Claude CLI

```bash
brew install claude-code
# Full trading (OAuth)
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp/exchange
claude mcp list
# Restart Claude CLI after authorization is complete
```

### Trae

Edit Trae settings. Uses `mcp-remote` to proxy HTTP MCP (OAuth prompt on first connect for `/mcp/exchange`):

```json
{
  "mcpServers": {
    "gate": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/exchange"
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
        "https://api.gatemcp.ai/mcp/exchange"
      ]
    }
  }
}
```

### Claude Desktop

Claude Desktop requires a local stdio proxy.

1. Download the [Python proxy file](gate-mcp-proxy.py)
2. Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

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

See [Claude Desktop setup](docs/setup-claude-desktop.md) for detailed instructions.

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

All tools use the `cex_` prefix. Tools are split between Public MCP (no auth) and Private MCP (OAuth2).

### Public MCP (`/mcp` — no auth)

| Tool | Description |
|------|-------------|
| `cex_spot_list_currencies` | All supported currencies |
| `cex_spot_get_currency` | Single currency info |
| `cex_spot_list_currency_pairs` | All trading pairs |
| `cex_spot_get_currency_pair` | Single trading pair details |
| `cex_spot_get_spot_tickers` | Spot tickers (price, volume, change) |
| `cex_spot_get_spot_order_book` | Spot order book depth |
| `cex_spot_get_spot_trades` | Spot trade history |
| `cex_spot_get_spot_candlesticks` | Spot K-line data |
| `cex_fx_list_fx_contracts` | All perpetual contracts |
| `cex_fx_get_fx_contract` | Single contract details |
| `cex_fx_get_fx_tickers` | Futures tickers |
| `cex_fx_get_fx_order_book` | Futures order book |
| `cex_fx_get_fx_trades` | Futures trade history |
| `cex_fx_get_fx_candlesticks` | Futures K-line |
| `cex_fx_get_fx_funding_rate` | Funding rate history |
| `cex_fx_get_fx_premium_index` | Premium index K-line |
| `cex_fx_list_fx_liq_orders` | Liquidation history |

### Private MCP (`/mcp/exchange` — OAuth2)

> **Note**: The private endpoint does not include public market data tools. Use `/mcp` for market data queries.

#### Spot Trading (scope: `profile` / `trade`)

| Tool | Description |
|------|-------------|
| `cex_spot_get_spot_accounts` | Spot account balances |
| `cex_spot_list_spot_orders` / `cex_spot_get_spot_order` | Order queries |
| `cex_spot_list_spot_my_trades` / `cex_spot_list_spot_account_book` | Trades, account book |
| `cex_spot_get_spot_fee` / `cex_spot_get_spot_batch_fee` | Fee rates |
| `cex_spot_create_spot_order` / `cex_spot_create_spot_batch_orders` | Place order(s) |
| `cex_spot_cancel_spot_order` / `cex_spot_cancel_all_spot_orders` / `cex_spot_cancel_spot_batch_orders` | Cancel orders |
| `cex_spot_amend_spot_order` / `cex_spot_amend_spot_batch_orders` | Amend order(s) |

#### Futures Trading (scope: `profile` / `trade`)

| Tool | Description |
|------|-------------|
| `cex_fx_get_fx_accounts` | Futures account |
| `cex_fx_list_fx_positions` / `cex_fx_get_fx_position` / `cex_fx_get_fx_dual_position` | Position queries |
| `cex_fx_list_fx_orders` / `cex_fx_get_fx_order` | Order queries |
| `cex_fx_list_fx_my_trades` / `cex_fx_get_fx_my_trades_timerange` | Personal trades |
| `cex_fx_list_fx_account_book` / `cex_fx_get_fx_fee` | Account book, fee |
| `cex_fx_list_fx_risk_limit_tiers` | Risk limit tiers |
| `cex_fx_create_fx_order` / `cex_fx_create_fx_batch_orders` | Place order(s) |
| `cex_fx_cancel_fx_order` / `cex_fx_cancel_all_fx_orders` / `cex_fx_cancel_fx_batch_orders` | Cancel orders |
| `cex_fx_amend_fx_order` / `cex_fx_amend_fx_batch_orders` | Amend order(s) |
| `cex_fx_update_fx_position_leverage` / `cex_fx_update_fx_position_margin` / `cex_fx_update_fx_position_cross_mode` | Position settings |
| `cex_fx_set_fx_dual` / `cex_fx_update_fx_dual_position_margin` / `cex_fx_update_fx_dual_position_leverage` / `cex_fx_update_fx_dual_position_risk_limit` | Dual-mode position settings |
| `cex_fx_update_fx_dual_position_cross_mode` / `cex_fx_update_fx_position_risk_limit` | Cross mode, risk limit |

#### Wallet & Account (scope: `wallet` / `account`)

| Tool | Description |
|------|-------------|
| `cex_wallet_get_total_balance` | Total account balance |
| `cex_wallet_create_transfer` | Internal transfer |
| `cex_wallet_get_wallet_fee` / `cex_wallet_get_transfer_order_status` | Trading fee, transfer status |
| `cex_wallet_list_deposits` / `cex_wallet_list_withdrawals` | Deposit/withdrawal records |
| `cex_wallet_create_sa_transfer` / `cex_wallet_create_sa_to_sa_transfer` | Sub-account transfers |
| `cex_unified_get_unified_accounts` / `cex_unified_get_unified_mode` / `cex_unified_set_unified_mode` | Unified account |
| `cex_unified_list_unified_loans` / `cex_unified_get_unified_risk_units` / `cex_unified_get_unified_borrowable` | Loans, risk units |
| `cex_sa_list_sas` / `cex_sa_get_sa` / `cex_sa_create_sa` | Sub-account management |
| `cex_sa_list_sa_keys` / `cex_sa_create_sa_key` / `cex_sa_get_sa_key` / `cex_sa_update_sa_key` / `cex_sa_delete_sa_key` | Sub-account API keys |
| `cex_sa_lock_sa` / `cex_sa_unlock_sa` / `cex_sa_get_sa_unified_mode` | Sub-account lock/unlock |

For full tool parameters, see [Gate API Docs](https://www.gate.com/docs/developers/apiv4) or [gate-exchange-mcp](gate-exchange/gate-exchange-mcp.md).

### MCP Resources

Both endpoints also expose MCP Resources for static reference data:

| Resource URI | Description |
|---|---|
| `gate://spot/currency_pairs` | All spot trading pairs |
| `gate://spot/currencies` | All supported currencies |
| `gate://futures/contracts/usdt` | USDT-settled futures contracts |
| `gate://futures/contracts/btc` | BTC-settled futures contracts |
| `gate://futures/contracts/{settle}` | Futures contracts by settlement currency |

---

## FAQ

### Q: Do I need a Gate account?

A: **Only for trading and private tools.** For `/mcp`, you can query market data (tickers, order books, K-line, etc.) without any account. For `/mcp/exchange` (trading, balances, transfers), you must log in with your Gate account via OAuth2 (e.g. `mcporter auth gate-mcp`).

### Q: Does it support trading?

A: Yes. Connect to `https://api.gatemcp.ai/mcp/exchange` with OAuth2. The server supports spot and futures trading, account management, wallet transfers, and sub-accounts. Each tool requires the appropriate scope (e.g. `trade`, `wallet`).

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
