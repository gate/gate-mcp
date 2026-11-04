# Gate MCP Server

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-Protocol-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

---

A Gate MCP (Model Context Protocol) server that enables AI agents to interact with the Gate cryptocurrency exchange for market data, trading, and account management.

## Features

- **Public data** — Spot/futures standard and RPI depth, options, delivery, margin, Earn, Alpha, CFD, stocks, collateral-loan parameters, unified-account simulation and Square (no OAuth)
- **Trading and strategies** — Spot/futures/options/delivery orders, POV, Chase, trigger orders, Trail and strategy bots
- **Account and wallet** — Balances, account transfers, deposit/withdrawal history, deposit addresses, unified accounts and wallet-level sub-account balances/transfers
- **Earn and allocation** — Auto investment, ordinary/stock dual investment, fixed-term and flexible lending, multi-collateral loans, flash swap and portfolio optimization
- **CFD and stocks** — Market information and authorized account, order, position and fund operations as separate domains
- 🌐 **DEX** - On-chain wallet, swap (single-chain & cross-chain), token info, market data across 20+ chains
- 📰 **Info** - Coin discovery, market snapshots, technical/platform metrics, on-chain and macro data
- 📢 **News** - Crypto news, social insights, market events, prediction markets
- 📚 **Docs** - Research reports, papers, and documentation search
- 🔐 **OAuth2** - Secure authorization for trading and private tools

## MCP Endpoints

The service exposes the following MCP endpoints:

| Endpoint | Auth | Tools |
|----------|------|-------|
| `https://api.gatemcp.ai/mcp` | None | CEX public data and simulation (83 tools; see business table below) |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | CEX private trading/account tools (source registration ceiling 310; filtered by authorization and operational policies) |
| `https://api.gatemcp.ai/mcp/dex` | Google / Gate OAuth | DEX wallet & swap (33 tools: auth, wallet, chain config, transfer, swap, market data, token info, agentic, RPC across 20+ chains) |
| `https://api.gatemcp.ai/mcp/info` | None | Coin info & analysis (32 tools: coins, snapshots, trends, on-chain, platform metrics, macro, market detail) |
| `https://api.gatemcp.ai/mcp/open/info` | None | Gate Info submission surface (exactly 7 tools: coin profile, market overview/snapshots, kline, order book, recent trades) |
| `https://api.gatemcp.ai/mcp/news` | None | News & research (18 tools: news/UGC/X/web, announcements, sentiment, events, prediction markets) |
| `https://api.gatemcp.ai/mcp/docs` | None | Docs research (3 tools: research search, coin research, papers) |

- **Market data only** → Use `/mcp` (no Gate account needed)
- **CEX trading, balances, transfers** → Use `/mcp/exchange` (Gate OAuth2 required)
- **DEX wallet, swap, on-chain** → Use `/mcp/dex` (Google / Gate OAuth required)
- **Coin info, technical analysis** → Use `/mcp/info` (no auth)
- **ChatGPT / OpenAI Apps Gate Info listing** → Use `/mcp/open/info` (7-tool allowlist; no auth)
- **News, announcements** → Use `/mcp/news` (no auth)
- **Research docs & papers** → Use `/mcp/docs` (no auth)

Transport: Streamable HTTP (with SSE fallback).

## Authorization (OAuth2)

**`/mcp/exchange` requires Gate OAuth2; `/mcp/dex` requires Google or Gate OAuth.** The endpoints `/mcp`, `/mcp/info`, `/mcp/open/info`, `/mcp/news`, and `/mcp/docs` do not require any authentication.

### Using mcporter

> **Prerequisites**: Node.js >= 18, npm. See [Quick Start - mcporter](#mcporter--openclaw) for full installation steps.

```bash
# Add Private MCP (trading, requires OAuth)
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp/exchange --auth oauth

# Authorize (opens browser to log in)
mcporter auth gate-mcp
```

### Scopes (for `/mcp/exchange`)

Requirements for `base`, `spot_trade`, `futures_trade`, `earn`, `cfd`, `stock` depend on the tool and account type. In ordinary matching, `base` includes `read` and `asset` and is not read-only. Ordinary tokens retain per-tool OR compatibility with legacy scopes; Agentic accounts have separate read/write overrides and denied operations. `mcp:tools` does not replace a business scope.

See the [per-tool permissions](gate-exchange/gateapi-mcp-service-tools.md) and [authorization/PKCE resource reference](gate-exchange/gate-exchange-mcp.md#authorization). The connected endpoint's `tools/list` determines visibility; default scope advertisement does not establish application choices in every environment.

## Quick Start

### Prerequisites

- **Gate account** (required only for `/mcp/exchange`)
- MCP-compatible client (Cursor, Claude CLI, Trae, OpenClaw, etc.)
- **Node.js** >= 18 (for mcporter, Trae, Qoder, and other npm-based clients)
- **Python** >= 3.9 (optional, for Claude Desktop proxy)

### Cursor

#### Method 1: One-click Install (Recommended)

Just paste the following into the Cursor AI chat — the agent will auto-install all Gate MCP servers and Skills:

> Help me auto install Gate Skills and MCPs: https://github.com/gate/gate-skills

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

Claude Desktop supports remote custom connectors; a local proxy is not mandatory. Connect to `https://api.gatemcp.ai/mcp` for public data or use `https://api.gatemcp.ai/mcp/exchange` with Gate OAuth2 for authorized private tools.

The repository's Python stdio proxy is an optional public-data compatibility path, without OAuth or SSE parsing. See [Claude Desktop setup](docs/setup-claude-desktop.md).

### Alternative: gate-local-mcp (local stdio with API keys)

For local development without OAuth, use [gate-local-mcp](https://github.com/gate/gate-local-mcp) (npm: `gate-mcp`) — a stdio MCP server that uses `GATE_API_KEY` / `GATE_API_SECRET` (optional for public market data only). Configure it as a command-based MCP server (e.g. `"command": "npx", "args": ["-y", "gate-mcp"]`). By default it registers **384 tools** across **22 modules** (spot, futures, delivery, margin, wallet, account, options, earn, flash_swap, unified, sub_account, multi_collateral_loan, p2p, tradfi, crossex, alpha, rebate, activity, coupon, launch, square, welfare). Reduce the set with `GATE_MODULES` or `--modules=spot,futures`, or enable read-only mode with `GATE_READONLY=true` / `--readonly`.

**Important:** Wire-level tool names use abbreviations (`futures`→`fx`, `delivery`→`dc`, `sub_account`→`sa`, etc.); they differ from the remote `api.gatemcp.ai` naming. Always use the names returned by `tools/list`.

Full tool list: [gate-local-mcp-tools.md](gate-exchange/gate-local-mcp-tools.md).

#### LobeHub (desktop)

On the [LobeHub MCP marketplace](https://lobehub.com/zh/mcp/gate-gate-mcp) this server appears as identifier `gate-gate-mcp`. The **npm package name is `gate-mcp`** — run `npx -y gate-mcp`, not `gate-gate-mcp`.

Per [LobeHub custom MCP](https://lobehub.com/zh/docs/usage/community/custom-mcp), stdio servers work on the **desktop** app only; inject **environment variables** for Gate API authentication. Use **Import JSON** when adding a custom skill.

**Public endpoints only:**

```json
{
  "mcpServers": {
    "gate-mcp": {
      "command": "npx",
      "args": ["-y", "gate-mcp"],
      "type": "stdio"
    }
  }
}
```

**With API key authentication:**

```json
{
  "mcpServers": {
    "gate-mcp": {
      "command": "npx",
      "args": ["-y", "gate-mcp"],
      "type": "stdio",
      "env": {
        "GATE_API_KEY": "your-api-key",
        "GATE_API_SECRET": "your-api-secret"
      }
    }
  }
}
```

You can add `GATE_MODULES`, `GATE_READONLY`, or `GATE_BASE_URL` inside `env` as needed. Click **Test connection** before saving.

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

<a id="cex-public"></a>
### Public MCP (`/mcp` — no OAuth, 83 tools)

Inventory reference: service version `v1.16.7`, checked on 2026-11-04. The public name set was checked against the live directory on that date. Counts below separate the two endpoints; private does not include public tools.

| Business | Public `/mcp` | Private `/mcp/exchange` |
|---|---:|---:|
| Spot | 10 | 27 |
| Futures | 18 | 54 |
| Margin | 3 | 17 |
| Options | 12 | 17 |
| Delivery | 8 | 21 |
| Wallet | 1 | 22 |
| Unified account | 5 | 22 |
| Account management | 0 | 10 |
| Rebate | 0 | 10 |
| Flash swap | 1 | 8 |
| Earn | 7 | 42 |
| Alpha | 3 | 6 |
| CFD / TradFi | 4 | 16 |
| Stock | 5 | 11 |
| Multi-collateral loan | 4 | 8 |
| Strategy bots / AIHub | 0 | 12 |
| Portfolio optimization / AssetSwap | 0 | 7 |
| Square | 2 | 0 |
| **Total** | **83** | **310** |

<a id="cex-private"></a>
### Private MCP (`/mcp/exchange` — OAuth2, source ceiling 310 tools)

Token permissions, account type and operational policies determine visibility; not every user sees 310 tools. Remote sub-account/API-key administration, CrossEx, P2P, activity, coupon, welfare and Launch products are retired. Wallet-level sub-account balances/transfers remain separate from retired administration.

See the [remote tool catalogue](gate-exchange/gateapi-mcp-service-tools.md) for names/permissions and [CEX reference](gate-exchange/gate-exchange-mcp.md) for inputs, examples, Trail responses and errors.

### DEX — Authentication

| Tool | Description |
|------|-------------|
| `dex_auth_google_login_start` | Start Google OAuth login flow, returns verification URL |
| `dex_auth_google_login_poll` | Poll login status, returns mcp_token on success |
| `dex_auth_login_google_wallet` | Login with Google OAuth authorization code |
| `dex_auth_gate_login_start` | Start Gate OAuth login flow, returns verification URL |
| `dex_auth_gate_login_poll` | Poll Gate OAuth login status, returns mcp_token on success |
| `dex_auth_login_gate_wallet` | Login directly with Gate OAuth authorization code |
| `dex_auth_logout` | Revoke current session |

### DEX — Wallet

| Tool | Description |
|------|-------------|
| `dex_wallet_get_addresses` | Get wallet addresses for each chain (EVM, Solana) |
| `dex_wallet_get_token_list` | Token balances with prices and pagination |
| `dex_wallet_get_total_asset` | Total portfolio value and 24h change |
| `dex_wallet_sign_message` | Sign a message with wallet private key (EVM / Solana) |
| `dex_wallet_sign_transaction` | Sign a raw transaction with wallet private key |

### DEX — Chain & Transactions

| Tool | Description |
|------|-------------|
| `dex_chain_config` | Chain configuration (chain ID, capabilities) |
| `dex_tx_gas` | Estimate gas price and gas limit |
| `dex_tx_transfer_preview` | Preview transfer details before signing |
| `dex_tx_approve_preview` | Token approval preview: build ERC20/SPL approve transaction |
| `dex_tx_get_sol_unsigned` | Build unsigned Solana SOL transfer with latest blockhash |
| `dex_tx_send_raw_transaction` | Broadcast signed transaction on-chain |
| `dex_tx_quote` | Swap quote with route, price impact and gas estimation |
| `dex_tx_swap` | One-click swap: quote → build → sign → submit |
| `dex_tx_swap_detail` | Query swap order status by order ID |
| `dex_tx_list` / `dex_tx_detail` / `dex_tx_history_list` | Transaction & swap / bridge history |

### DEX — Market Data & Token Info

| Tool | Description |
|------|-------------|
| `dex_market_get_kline` | K-line (candlestick) data: 1m, 5m, 1h, 4h, 1d |
| `dex_market_get_tx_stats` | Trading volume and trader statistics (5m / 1h / 4h / 24h) |
| `dex_market_get_pair_liquidity` | Liquidity pool add / remove events |
| `dex_token_list_swap_tokens` | Available tokens for swap on a given chain |
| `dex_token_list_cross_chain_bridge_tokens` | Bridgeable tokens for cross-chain transfers |
| `dex_token_get_coin_info` | Token info: price, market cap, supply, holder distribution |
| `dex_token_ranking` | 24h top gainers / top losers |
| `dex_token_get_coins_range_by_created_at` | Discover new tokens by creation time range |
| `dex_token_get_risk_info` | Security audit: honeypot, buy/sell tax, blacklist, permissions |

### DEX — Agentic & RPC

| Tool | Description |
|------|-------------|
| `dex_agentic_report` | Report agentic wallet addresses to wallet service |
| `dex_rpc_call` | Execute JSON-RPC call to blockchain node |

For full DEX tool parameters, see [gate-dex-mcp](gate-dex/gate-dex-mcp.md). For the Agentic Wallet subset (auth, wallet, market data, resources), see [gate-agentic-wallet-mcp](gate-dex/gate-agentic-wallet-mcp.md).

### Info (`/mcp/info` — 32 tools, no auth)

Public, read-only market research. Categories (full parameter tables: [gate-info-mcp](gate-info/gate-info-mcp.md)):

| Category | Tools |
|----------|--------|
| Coin | `info_coin_get_coin_info`, `info_coin_search_coins`, `info_coin_get_coin_rankings` |
| Market snapshot | `info_marketsnapshot_get_market_snapshot`, `info_marketsnapshot_batch_market_snapshot`, `info_marketsnapshot_get_market_overview`, `info_marketsnapshot_get_institutional_metrics` |
| Market trend | `info_markettrend_get_kline`, `info_markettrend_get_indicator_history`, `info_markettrend_get_technical_analysis` |
| On-chain | `info_onchain_get_address_info`, `info_onchain_get_address_transactions`, `info_onchain_get_transaction`, `info_onchain_get_token_onchain` |
| Compliance | `info_compliance_check_token_security` |
| Platform metrics | `info_platformmetrics_get_platform_info`, `info_platformmetrics_search_platforms`, `info_platformmetrics_get_defi_overview`, `info_platformmetrics_get_stablecoin_info`, `info_platformmetrics_get_bridge_metrics`, `info_platformmetrics_get_yield_pools`, `info_platformmetrics_get_platform_history`, `info_platformmetrics_get_exchange_reserves`, `info_platformmetrics_get_liquidation_heatmap`, `info_platformmetrics_get_cex_orderbook_depth`, `info_platformmetrics_get_chain_activity` |
| Macro | `info_macro_get_macro_indicator`, `info_macro_get_economic_calendar`, `info_macro_get_macro_summary` |
| Market detail | `info_marketdetail_get_orderbook`, `info_marketdetail_get_recent_trades`, `info_marketdetail_get_kline` |

### Open Info (`/mcp/open/info` — 7 tools, no auth)

ChatGPT / OpenAI Apps submission allowlist only. Full parameter tables: [gate-open-info-mcp](gate-open-info/gate-open-info-mcp.md).

| Category | Tools |
|----------|--------|
| Coin | `info_coin_get_coin_info` |
| Market snapshot | `info_marketsnapshot_get_market_overview`, `info_marketsnapshot_get_market_snapshot`, `info_marketsnapshot_batch_market_snapshot` |
| Market detail | `info_marketdetail_get_kline`, `info_marketdetail_get_orderbook`, `info_marketdetail_get_recent_trades` |

### News (`/mcp/news` — 18 tools, no auth)

Public, read-only news and social research. Categories (full parameter tables: [gate-news-mcp](gate-news/gate-news-mcp.md)):

| Category | Tools |
|----------|--------|
| News feed | `news_feed_search_news`, `news_feed_web_search`, `news_feed_search_x`, `news_feed_search_ugc`, `news_feed_get_exchange_announcements`, `news_feed_get_social_sentiment`, `news_feed_get_mention_burst`, `news_feed_get_hot_topics` |
| Events | `news_events_get_latest_events`, `news_events_get_event_detail`, `news_events_explain_market_move`, `news_events_get_market_move_report`, `news_events_list_market_move_reports` |
| Prediction | `news_prediction_get_volume_delta_ranking`, `news_prediction_get_fastest_rising_ranking`, `news_prediction_get_market_orderbook`, `news_prediction_search_events`, `news_prediction_get_event_signal` |

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

A: **Only for CEX trading and DEX wallet.** `/mcp`, `/mcp/info`, `/mcp/open/info`, `/mcp/news`, and `/mcp/docs` are fully public — no account needed. `/mcp/exchange` (CEX trading, balances, transfers) requires Gate OAuth2. `/mcp/dex` (on-chain wallet, swap) requires Google or Gate OAuth.

### Q: Does it support trading?

A: Yes. Connect to `/mcp/exchange` with Gate OAuth2 for authorized spot, futures, CFD, stock, Earn and strategy operations. Connect separately to `/mcp` for public data. Sub-account administration is retired; wallet-level sub-account balances/transfers have their own permissions.

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

Report documentation issues through this repository's [Issues](https://github.com/gate/gate-mcp/issues).

## License

[MIT](LICENSE) © gate.com
