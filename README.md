# Gate MCP Server

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-Protocol-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

---

A Gate MCP (Model Context Protocol) server that enables AI agents to interact with the Gate cryptocurrency exchange for market data, trading, and account management.

## Features

- 🔍 **Public Market Data** - Spot, futures, margin, options, delivery, earn, alpha tickers, order books, K-line, funding rate, liquidation history (**no auth required**)
- 💹 **Trading** - Create/cancel/amend spot, futures, options, delivery orders; price-triggered orders; trail orders
- 💼 **Account & Wallet** - Balances, transfers, deposits, withdrawals, sub-accounts, unified account
- 📊 **Margin & Earn** - Margin loans, earn products, flash swap
- 🌍 **TradFi, CrossEx, OTC, P2P** - Traditional finance, cross-exchange, OTC, P2P trading
- 🌐 **DEX** - On-chain wallet, swap (single-chain & cross-chain), token info, market data across 20+ chains
- 📰 **Info** - Coin info, market snapshots, technical analysis, on-chain data, compliance checks
- 📢 **News** - Real-time crypto news, exchange announcements, social sentiment
- 🔐 **OAuth2** - Secure authorization for trading and private tools

## MCP Endpoints

The service exposes five MCP endpoints:

| Endpoint | Auth | Tools |
|----------|------|-------|
| `https://api.gatemcp.ai/mcp` | None | Public market data (51 tools: spot, futures, margin, options, delivery, earn, alpha) |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | CEX trading & account (300+ tools: spot/futures/options/delivery/margin trading, wallet, unified account, sub-accounts, earn, flash swap, rebate, TradFi, CrossEx, OTC, P2P, Alpha) |
| `https://api.gatemcp.ai/mcp/dex` | Google OAuth | DEX wallet & swap (25 tools: on-chain wallet, swap, token info, market data across 20+ chains) |
| `https://api.gatemcp.ai/mcp/info` | None | Coin info & analysis (10 tools: market snapshots, technical analysis, on-chain data, compliance) |
| `https://api.gatemcp.ai/mcp/news` | None | News & sentiment (3 tools: news search, exchange announcements, social sentiment) |

- **Market data only** → Use `/mcp` (no Gate account needed)
- **CEX trading, balances, transfers** → Use `/mcp/exchange` (Gate OAuth2 required)
- **DEX wallet, swap, on-chain** → Use `/mcp/dex` (Google OAuth required)
- **Coin info, technical analysis** → Use `/mcp/info` (no auth)
- **News, announcements** → Use `/mcp/news` (no auth)

Transport: Streamable HTTP (with SSE fallback).

## Authorization (OAuth2)

**`/mcp/exchange` requires Gate OAuth2; `/mcp/dex` requires Google OAuth.** The endpoints `/mcp`, `/mcp/info`, and `/mcp/news` do not require any authentication.

### Using mcporter

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

#### Method 1: One-click Install (Recommended)

Just paste the following into the Cursor AI chat — the agent will auto-install all Gate MCP servers and Skills:

> Help me auto install Gate Skills and MCPs: https://github.com/gateio/gate-skills

See [gate-skills](https://github.com/gate/gate-skills) for details.

#### Method 2: Manual Configuration

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

**For DEX (on-chain wallet, swap):**

```json
{
  "mcpServers": {
    "Gate-Dex": {
      "url": "https://api.gatemcp.ai/mcp/dex",
      "headers": {
        "x-api-key": "MCP_AK_8W2N7Q",
        "Authorization": "Bearer ${GATE_MCP_TOKEN}"
      }
    }
  }
}
```

**For Info & News (no auth):**

```json
{
  "mcpServers": {
    "Gate-Info": {
      "url": "https://api.gatemcp.ai/mcp/info"
    },
    "Gate-News": {
      "url": "https://api.gatemcp.ai/mcp/news"
    }
  }
}
```

See [Cursor setup](docs/setup-cursor.md).

### mcporter / OpenClaw

#### Method 1: One-click Install (Recommended)

Just paste the following into the OpenClaw AI chat — the agent will auto-install all Gate MCP servers and Skills:

> Help me auto install Gate Skills and MCPs: https://github.com/gate/gate-skills

See [gate-skills](https://github.com/gate/gate-skills) for details.

#### Method 2: Manual Configuration

##### Prerequisites (before installing mcporter)

- **Node.js** >= 18 (mcporter requires npm)
- **npm** (comes with Node.js) — verify with: `node -v` and `npm -v`
- **Gate account** (for OAuth login when using `/mcp/exchange`)

##### Install mcporter

```bash
# Global install
npm install -g mcporter

# Verify installation
mcporter --version
```

Alternatively, run without installing: `npx mcporter <command>` (uses current Node.js/npm).

##### Add MCP and authorize

```bash
# Add Private MCP (trading, OAuth)
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp/exchange --auth oauth

# Authorize (opens browser to log in)
mcporter auth gate-mcp

# Add DEX MCP
mcporter config add gate-dex --url https://api.gatemcp.ai/mcp/dex

# Add Info MCP (no auth)
mcporter config add gate-info --url https://api.gatemcp.ai/mcp/info

# Add News MCP (no auth)
mcporter config add gate-news --url https://api.gatemcp.ai/mcp/news
```

See [OpenClaw setup](docs/setup-openclaw.md) for detailed steps.

### Claude CLI

#### Method 1: One-click Install (Recommended)

Just paste the following into Claude CLI — the agent will auto-install all Gate MCP servers and Skills:

> Help me auto install Gate Skills and MCPs: https://github.com/gate/gate-skills

See [gate-skills](https://github.com/gate/gate-skills) for details.

#### Method 2: Manual Configuration

```bash
brew install claude-code
# Full trading (OAuth)
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp/exchange
# Restart Claude CLI after authorization is complete

# Info (no auth)
claude mcp add --transport http Gate-Info https://api.gatemcp.ai/mcp/info

# News (no auth)
claude mcp add --transport http Gate-News https://api.gatemcp.ai/mcp/news

claude mcp list
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
    },
    "gate-info": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/info"
      ]
    },
    "gate-news": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/news"
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
    },
    "gate-info": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/info"
      ]
    },
    "gate-news": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/news"
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

### Alternative: gate-local-mcp (local stdio with API keys)

For local development without OAuth, use [gate-local-mcp](https://github.com/gateio/gate-local-mcp) (npm: `gate-mcp`) — an stdio MCP server that uses `GATE_API_KEY` / `GATE_API_SECRET`. Configure it as a command-based MCP server in your client (e.g. `"command": "npx", "args": ["-y", "gate-mcp"]`).

Full tool list: [gate-local-mcp-tools.md](gate-exchange/gate-local-mcp-tools.md).

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

### Public MCP (`/mcp` — no auth, 51 tools)

| Business | Tools | Description |
|----------|-------|-------------|
| **Spot** | 9 | `cex_spot_list_currencies`, `cex_spot_get_currency`, `cex_spot_list_currency_pairs`, `cex_spot_get_currency_pair`, `cex_spot_get_spot_tickers`, `cex_spot_get_spot_order_book`, `cex_spot_get_spot_trades`, `cex_spot_get_spot_candlesticks`, `cex_spot_get_system_time` |
| **Futures** | 13 | Contracts, order book, trades, candlesticks, tickers, funding rate, premium index, liquidation, contract stats, insurance ledger, index constituents, batch funding rates |
| **Margin** | 3 | `cex_margin_list_uni_currency_pairs`, `cex_margin_get_uni_currency_pair`, `cex_margin_get_market_margin_tier` |
| **Options** | 12 | Underlyings, expirations, contracts, settlements, order book, tickers, candlesticks, trades |
| **Delivery** | 8 | Contracts, order book, trades, candlesticks, tickers, insurance ledger, risk limit tiers |
| **Earn** | 3 | `cex_earn_list_dual_investment_plans`, `cex_earn_list_structured_products`, `cex_earn_list_uni_currencies` |
| **Alpha** | 3 | `cex_alpha_list_alpha_currencies`, `cex_alpha_list_alpha_tickers`, `cex_alpha_list_alpha_tokens` |

### Private MCP (`/mcp/exchange` — OAuth2, 300+ tools)

> **Note**: The private endpoint does not include public market data tools. Use `/mcp` for market data queries.

| Business | Scope | Key Tools |
|----------|-------|-----------|
| **Spot** | profile / trade | Accounts, orders, trades, batch orders, price-triggered orders, countdown cancel, cross liquidate |
| **Futures** | profile / trade | Accounts, positions, orders, trades, dual positions, trail orders, price-triggered, BBO orders |
| **Margin** | profile / trade | Margin accounts, loans, auto-repay, uni loans |
| **Options** | profile / trade | Account, positions, orders, MMP settings |
| **Delivery** | profile / trade | Accounts, positions, orders, price-triggered orders |
| **Wallet** | wallet | Total balance, transfers, deposits, withdrawals, deposit address, SA balances, small balance convert |
| **Unified** | account | Unified accounts, mode, loans, risk units, borrowable, collateral, leverage config |
| **Sub-account** | account | Create/list/lock/unlock SA, API keys |
| **Account** | account | Account detail, main keys, rate limit, debit fee, STP groups |
| **Rebate** | profile | Agency/partner/broker commission history, user info |
| **Flash Swap** | profile / trade | `cex_fc_list_fc_currency_pairs`, `cex_fc_list_fc_orders`, `cex_fc_create_fc_order`, etc. |
| **Earn** | profile / trade | Dual/structured/uni products, orders, ETH2 swap, lend records |
| **Alpha** | profile / trade | Alpha accounts, orders, quote/place |
| **TradFi** | profile / trade | Categories, symbols, MT5 account, assets, orders, positions |
| **CrossEx** | profile / trade | Rule symbols, account, positions, orders, transfers, convert |
| **OTC** | profile / trade | Bank list, OTC orders, stable coin orders, quote/place/cancel |
| **P2P** | profile / trade | User info, ads, chats, transactions, confirm payment/receipt |

For full tool parameters, see [Gate API Docs](https://www.gate.com/docs/developers/apiv4) or [gate-exchange-mcp](gate-exchange/gate-exchange-mcp.md).

### DEX — Authentication

| Tool | Description |
|------|-------------|
| `auth_google_login_start` | Start Google OAuth login flow |
| `auth_google_login_poll` | Poll login status, returns mcp_token on success |
| `auth_login_google_wallet` | Login with Google OAuth authorization code |
| `auth_logout` | Revoke current MCP session |

### DEX — Wallet

| Tool | Description |
|------|-------------|
| `wallet_get_addresses` | Get wallet addresses per chain (EVM, SOL) |
| `wallet_get_token_list` | Get token balances with prices |
| `wallet_get_total_asset` | Get total portfolio value and 24h change |
| `wallet_sign_message` | Sign a message with wallet private key |
| `wallet_sign_transaction` | Sign a raw transaction with wallet private key |

### DEX — Chain & Transactions

| Tool | Description |
|------|-------------|
| `chain_config` | Get chain configuration (networkKey, chainID, endpoint) |
| `tx_gas` | Estimate gas price and gas limit |
| `tx_transfer_preview` | Preview transfer details before signing |
| `tx_get_sol_unsigned` | Build unsigned Solana SOL transfer |
| `tx_send_raw_transaction` | Broadcast signed transaction on-chain |
| `tx_quote` | Get swap quote with route and price impact |
| `tx_swap` | One-shot swap: Quote → Build → Sign → Submit |
| `tx_swap_detail` | Query swap order status by order ID |
| `tx_list` / `tx_detail` / `tx_history_list` | Transaction & swap history |

### DEX — Market Data & Token Info

| Tool | Description |
|------|-------------|
| `market_get_kline` | K-line (candlestick) data |
| `market_get_tx_stats` | Trading volume and trader statistics |
| `market_get_pair_liquidity` | Liquidity pool add/remove events |
| `token_get_coin_info` | Token info: price, market cap, holders |
| `token_ranking` | 24h top gainers / top losers |
| `token_get_coins_range_by_created_at` | Discover new tokens by creation time |
| `token_get_risk_info` | Security audit: honeypot, tax, blacklist |

For full DEX tool parameters, see [gate-dex-mcp](gate-dex/gate-dex-mcp.md).

### Info — Coin & Market

| Tool | Description |
|------|-------------|
| `info_coin_get_coin_info` | Get coin info by name, symbol, or contract address |
| `info_marketsnapshot_get_market_snapshot` | Market overview: price, K-line summary, market cap, FDV, fear & greed |

### Info — Market Trend & Technical Analysis

| Tool | Description |
|------|-------------|
| `info_markettrend_get_kline` | OHLCV K-line data with optional indicators |
| `info_markettrend_get_indicator_history` | Historical indicator series (RSI, MACD, MA, EMA) |
| `info_markettrend_get_technical_analysis` | Multi-timeframe technical signals |

### Info — On-chain Data

| Tool | Description |
|------|-------------|
| `info_onchain_get_address_info` | On-chain address: labels, risk level, token balances |
| `info_onchain_get_address_transactions` | Address transaction history |
| `info_onchain_get_transaction` | Full transaction details by tx hash |
| `info_onchain_get_token_onchain` | Token on-chain data: holders, activity, smart money |

### Info — Compliance

| Tool | Description |
|------|-------------|
| `info_compliance_check_token_security` | Token security check: risk tier, taxes, open source, holders |

For full Info tool parameters, see [gate-info-mcp](gate-info/gate-info-mcp.md).

### News — Search & Announcements

| Tool | Description |
|------|-------------|
| `news_feed_search_news` | Search news by keyword, coin, time range, platform type |
| `news_feed_get_exchange_announcements` | Exchange announcements: listings, delistings, maintenance |
| `news_feed_get_social_sentiment` | Post detail: author, content, interactions, sentiment |

For full News tool parameters, see [gate-news-mcp](gate-news/gate-news-mcp.md).

### MCP Resources

The `/mcp` and `/mcp/exchange` endpoints also expose MCP Resources for static reference data:

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

A: **Only for CEX trading and DEX wallet.** `/mcp`, `/mcp/info`, and `/mcp/news` are fully public — no account needed. `/mcp/exchange` (CEX trading, balances, transfers) requires Gate OAuth2. `/mcp/dex` (on-chain wallet, swap) requires Google OAuth.

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
