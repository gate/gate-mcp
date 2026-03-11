# Gate MCP Server

[English](#gate-mcp-server) | [中文](#gate-mcp-服务器)

---

A Gate MCP (Model Context Protocol) server that enables AI agents to interact with the Gate cryptocurrency exchange for market data, trading, and account management.

## MCP Endpoints

| Endpoint | Auth | Tools |
|----------|------|-------|
| `https://api.gatemcp.ai/mcp` | None | Market data only (17 public tools: spot + futures) |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | Trading & account tools (66 tools: spot/futures trading, wallet, unified account, sub-accounts) |

Transport: Streamable HTTP (with SSE fallback).

## Features

- **Public Market Data** - Spot & futures tickers, order books, trades, K-line, funding rate, liquidation history (**no auth required**)
- **Trading** - Create/cancel/amend spot and futures orders (OAuth2 required)
- **Account & Wallet** - Balances, transfers, deposits, withdrawals, sub-accounts (OAuth2 required)
- **Real-time Prices** - Get live cryptocurrency prices across 1,700+ trading pairs

## Quick Start

### Prerequisites

- MCP-compatible client (Claude.ai, Cursor, Claude CLI, OpenClaw, etc.)
- Gate account (only for `/mcp/exchange`)

### Installation

**For market data (no auth):**
1. Configure your MCP client with URL: `https://api.gatemcp.ai/mcp`
2. Start querying crypto market data

**For full trading (OAuth2):**
1. Configure your MCP client with URL: `https://api.gatemcp.ai/mcp/exchange`
2. Complete OAuth2 login with your Gate account
3. Start trading and managing your account

### Basic Usage

Once enabled, you can interact with Gate through natural language:

**Query BTC Price**
> User: What's the current price of BTC/USDT?
>
> AI: BTC/USDT is currently trading at $83,742.9 with a 24h change of +1.17%

**Get Market Depth**
> User: Show me the order book for ETH/USDT
>
> AI: [Displays top 10 bid/ask levels with prices and quantities]

**Analyze K-line Data**
> User: Get the daily K-line data for BTC over the last 7 days
>
> AI: [Returns candlestick data and provides trend analysis]

---

## Public Tools (`/mcp` — no auth)

### Spot Market Tools

| Tool | Description |
|------|-------------|
| `cex_spot_list_currencies` | Get all supported currencies with details |
| `cex_spot_get_currency` | Get single currency information |
| `cex_spot_list_currency_pairs` | Get all supported trading pairs |
| `cex_spot_get_currency_pair` | Get single trading pair details |
| `cex_spot_get_spot_tickers` | Get spot market ticker data (price, volume, change) |
| `cex_spot_get_spot_order_book` | Get order book depth for a trading pair |
| `cex_spot_get_spot_trades` | Get recent trade history |
| `cex_spot_get_spot_candlesticks` | Get K-line/candlestick data |

### Futures Market Tools

| Tool | Description |
|------|-------------|
| `cex_fx_list_fx_contracts` | Get all perpetual contracts |
| `cex_fx_get_fx_contract` | Get single contract details |
| `cex_fx_get_fx_tickers` | Get futures market ticker data |
| `cex_fx_get_fx_order_book` | Get futures order book depth |
| `cex_fx_get_fx_trades` | Get futures trade history |
| `cex_fx_get_fx_candlesticks` | Get futures K-line data |
| `cex_fx_get_fx_funding_rate` | Get funding rate history |
| `cex_fx_get_fx_premium_index` | Get premium index K-line |
| `cex_fx_list_fx_liq_orders` | Get liquidation order history |

---

## Tool Details

### Spot Market

<details>
<summary><b>cex_spot_list_currencies</b> - Get all currencies</summary>

Get all supported currencies on Gate with their details.

**Parameters:** None

**Returns:** List of currencies with name, precision, deposit/withdrawal status

</details>

<details>
<summary><b>cex_spot_get_currency</b> - Get currency details</summary>

Get detailed information for a specific currency.

**Parameters:**
- `currency` (string, required): Currency name, e.g., `BTC`, `ETH`

**Returns:** Currency details including precision, chain info, deposit/withdrawal limits

</details>

<details>
<summary><b>cex_spot_list_currency_pairs</b> - Get all trading pairs</summary>

Get all supported spot trading pairs.

**Parameters:** None

**Returns:** List of trading pairs with trading rules and precision

</details>

<details>
<summary><b>cex_spot_get_currency_pair</b> - Get trading pair details</summary>

Get detailed information for a specific trading pair.

**Parameters:**
- `currency_pair` (string, required): Trading pair name, e.g., `BTC_USDT`

**Returns:** Trading pair details including min order size, price precision

</details>

<details>
<summary><b>cex_spot_get_spot_tickers</b> - Get spot tickers</summary>

Get real-time ticker data for spot markets.

**Parameters:**
- `currency_pair` (string, optional): Trading pair name. Returns all pairs if not specified
- `timezone` (string, optional): Timezone for statistics, e.g., `Asia/Shanghai`

**Returns:** Ticker data including last price, 24h high/low, volume, change percentage

</details>

<details>
<summary><b>cex_spot_get_spot_order_book</b> - Get order book</summary>

Get order book depth for a trading pair.

**Parameters:**
- `currency_pair` (string, required): Trading pair name
- `interval` (string, optional): Price precision merge level, `0` for no merge
- `limit` (number, optional): Number of levels to return, default 10, max 100
- `with_id` (boolean, optional): Whether to return depth update ID

**Returns:** Bid and ask levels with price and quantity

</details>

<details>
<summary><b>cex_spot_get_spot_trades</b> - Get recent trades</summary>

Get recent trade history for a trading pair.

**Parameters:**
- `currency_pair` (string, required): Trading pair name
- `limit` (number, optional): Number of records, default 100
- `last_id` (string, optional): Pagination cursor
- `reverse` (boolean, optional): Reverse order
- `from` (number, optional): Start timestamp (seconds)
- `to` (number, optional): End timestamp (seconds)
- `page` (number, optional): Page number

**Returns:** Trade records with price, amount, timestamp, side

</details>

<details>
<summary><b>cex_spot_get_spot_candlesticks</b> - Get K-line data</summary>

Get candlestick/K-line data for technical analysis.

**Parameters:**
- `currency_pair` (string, required): Trading pair name
- `interval` (string, optional): K-line period: `1m`, `5m`, `15m`, `30m`, `1h`, `4h`, `8h`, `1d`, `7d`, `30d`
- `limit` (number, optional): Number of data points (mutually exclusive with from/to)
- `from` (number, optional): Start timestamp (seconds)
- `to` (number, optional): End timestamp (seconds)

**Returns:** OHLCV data (Open, High, Low, Close, Volume)

</details>

### Futures Market

<details>
<summary><b>cex_fx_list_fx_contracts</b> - Get all contracts</summary>

Get all perpetual futures contracts.

**Parameters:**
- `settle` (string, optional): Settlement currency, `usdt` or `btc`
- `limit` (number, optional): Maximum number to return
- `offset` (number, optional): Offset for pagination

**Returns:** Contract list with specifications and margin requirements

</details>

<details>
<summary><b>cex_fx_get_fx_contract</b> - Get contract details</summary>

Get detailed information for a specific contract.

**Parameters:**
- `contract` (string, required): Contract identifier, e.g., `BTC_USDT`
- `settle` (string, optional): Settlement currency, default `usdt`

**Returns:** Contract details including leverage, maintenance margin rate

</details>

<details>
<summary><b>cex_fx_get_fx_tickers</b> - Get futures tickers</summary>

Get real-time ticker data for futures markets.

**Parameters:**
- `settle` (string, optional): Settlement currency, default `usdt`
- `contract` (string, optional): Contract identifier. Returns all if not specified

**Returns:** Ticker data including last price, mark price, open interest

</details>

<details>
<summary><b>cex_fx_get_fx_order_book</b> - Get futures order book</summary>

Get order book depth for a futures contract.

**Parameters:**
- `contract` (string, required): Contract identifier
- `settle` (string, optional): Settlement currency, default `usdt`
- `interval` (string, optional): Price precision merge level
- `limit` (number, optional): Number of levels
- `with_id` (boolean, optional): Whether to return depth update ID

**Returns:** Bid and ask levels with price and quantity

</details>

<details>
<summary><b>cex_fx_get_fx_trades</b> - Get futures trades</summary>

Get recent trade history for a futures contract.

**Parameters:**
- `contract` (string, required): Contract identifier
- `settle` (string, optional): Settlement currency, default `usdt`
- `limit` (number, optional): Number of records
- `offset` (number, optional): Offset for pagination
- `last_id` (string, optional): Pagination cursor
- `from` (number, optional): Start timestamp (seconds)
- `to` (number, optional): End timestamp (seconds)

**Returns:** Trade records with price, size, timestamp

</details>

<details>
<summary><b>cex_fx_get_fx_candlesticks</b> - Get futures K-line</summary>

Get candlestick data for futures contracts.

**Parameters:**
- `contract` (string, required): Contract identifier
- `settle` (string, optional): Settlement currency, default `usdt`
- `interval` (string, optional): K-line period
- `limit` (number, optional): Number of data points
- `from` (number, optional): Start timestamp (seconds)
- `to` (number, optional): End timestamp (seconds)
- `timezone` (string, optional): Timezone: `all`, `utc0`, `utc8`

**Returns:** OHLCV data for futures

</details>

<details>
<summary><b>cex_fx_get_fx_funding_rate</b> - Get funding rate</summary>

Get historical funding rate data.

**Parameters:**
- `contract` (string, required): Contract identifier
- `settle` (string, optional): Settlement currency, default `usdt`
- `limit` (number, optional): Number of records
- `from` (number, optional): Start timestamp
- `to` (number, optional): End timestamp

**Returns:** Funding rate history with timestamps

</details>

<details>
<summary><b>cex_fx_get_fx_premium_index</b> - Get premium index</summary>

Get premium index K-line data.

**Parameters:**
- `contract` (string, required): Contract identifier
- `settle` (string, optional): Settlement currency, default `usdt`
- `interval` (string, optional): Data point interval
- `limit` (number, optional): Number of data points
- `from` (number, optional): Start timestamp (seconds)
- `to` (number, optional): End timestamp (seconds)

**Returns:** Premium index K-line data

</details>

<details>
<summary><b>cex_fx_list_fx_liq_orders</b> - Get liquidation history</summary>

Get liquidation order history.

**Parameters:**
- `settle` (string, optional): Settlement currency, default `usdt`
- `contract` (string, optional): Contract identifier. Returns all if not specified
- `limit` (number, optional): Number of records
- `from` (number, optional): Start timestamp
- `to` (number, optional): End timestamp

**Returns:** Liquidation order records

</details>

---

## FAQ

### Q: Do I need a Gate account?

A: **Only for trading and private tools.** For `/mcp`, you can query market data (tickers, order books, K-line, etc.) without any account. For `/mcp/exchange` (trading, balances, transfers), you must log in with your Gate account via OAuth2.

### Q: Does it support trading?

A: Yes. Connect to `https://api.gatemcp.ai/mcp/exchange` with OAuth2. The server supports spot and futures trading, account management, wallet transfers, and sub-accounts.

### Q: How often is the data updated?

A: All data is queried in real-time from Gate's API, returning the latest market information.

---

## Privacy & Security

- OAuth2 authorization via Gate account (no API keys stored in config)
- All API calls are transmitted via HTTPS encryption
- For more details, see [Gate Privacy Policy](https://www.gate.com/legal/privacy-policy)

---

## Support & Feedback

- **API Documentation**: [Gate API Docs](https://www.gate.com/docs/developers/apiv4)
- **Issue Reporting**: Please contact Gate support
- **Business Inquiries**: Contact Gate official channels

---

# Gate MCP 服务器

一个 Gate MCP（模型上下文协议）服务器，使 AI 代理能够与 Gate 加密货币交易所交互，获取市场数据、进行交易和账户管理。

## MCP 端点

| 端点 | 认证 | 工具 |
|------|------|------|
| `https://api.gatemcp.ai/mcp` | 无 | 仅市场数据（17 个公开工具：现货+合约） |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | 交易与账户工具（66 个工具：现货/合约交易、钱包、统一账户、子账户） |

传输协议：Streamable HTTP（支持 SSE 回退）。

## 功能特性

- **公开市场数据** - 现货/合约行情、订单簿、成交记录、K 线、资金费率、强平历史（**无需认证**）
- **交易** - 现货/合约下单、撤单、改单（需 OAuth2）
- **账户与钱包** - 余额、划转、充值提现、子账户（需 OAuth2）
- **实时价格** - 获取 1,700+ 交易对的实时加密货币价格

## 快速开始

### 前置要求

- MCP 兼容客户端（Claude.ai、Cursor、Claude CLI、OpenClaw 等）
- Gate 账号（仅 `/mcp/exchange` 需要）

### 安装步骤

**查行情（无需认证）：**
1. 在 MCP 客户端配置 URL：`https://api.gatemcp.ai/mcp`
2. 开始查询加密货币市场数据

**完整交易（OAuth2）：**
1. 在 MCP 客户端配置 URL：`https://api.gatemcp.ai/mcp/exchange`
2. 使用 Gate 账号完成 OAuth2 登录
3. 开始交易和管理账户

### 基础用法

启用后，您可以通过自然语言与 Gate 交互：

**查询 BTC 价格**
> 用户：BTC/USDT 现在什么价格？
>
> AI：BTC/USDT 当前价格为 $83,742.9，24小时涨幅 +1.17%

**获取市场深度**
> 用户：查看 ETH/USDT 的订单簿
>
> AI：[显示买卖盘前 10 档价格和数量]

**分析 K 线数据**
> 用户：获取 BTC 最近 7 天的日 K 线数据
>
> AI：[返回 K 线数据并提供趋势分析]

---

## 公开工具（`/mcp` — 无需认证）

### 现货市场工具

| 工具 | 描述 |
|------|------|
| `cex_spot_list_currencies` | 获取所有支持的币种及详情 |
| `cex_spot_get_currency` | 获取单个币种信息 |
| `cex_spot_list_currency_pairs` | 获取所有支持的交易对 |
| `cex_spot_get_currency_pair` | 获取单个交易对详情 |
| `cex_spot_get_spot_tickers` | 获取现货市场行情（价格、成交量、涨跌幅） |
| `cex_spot_get_spot_order_book` | 获取交易对订单簿深度 |
| `cex_spot_get_spot_trades` | 获取最近成交记录 |
| `cex_spot_get_spot_candlesticks` | 获取 K 线/蜡烛图数据 |

### 合约市场工具

| 工具 | 描述 |
|------|------|
| `cex_fx_list_fx_contracts` | 获取所有永续合约 |
| `cex_fx_get_fx_contract` | 获取单个合约详情 |
| `cex_fx_get_fx_tickers` | 获取合约市场行情 |
| `cex_fx_get_fx_order_book` | 获取合约订单簿深度 |
| `cex_fx_get_fx_trades` | 获取合约成交记录 |
| `cex_fx_get_fx_candlesticks` | 获取合约 K 线数据 |
| `cex_fx_get_fx_funding_rate` | 获取资金费率历史 |
| `cex_fx_get_fx_premium_index` | 获取溢价指数 K 线 |
| `cex_fx_list_fx_liq_orders` | 获取强平订单历史 |

---

## 常见问题

### Q: 需要 Gate 账号吗？

A: **仅在使用交易和私有工具时需要。** 使用 `/mcp` 时，可无需账号查询市场数据（行情、深度、K 线等）。使用 `/mcp/exchange`（交易、余额、划转）时，须通过 OAuth2 登录 Gate 账号。

### Q: 支持交易功能吗？

A: 支持。连接 `https://api.gatemcp.ai/mcp/exchange` 并完成 OAuth2 授权即可。提供现货、合约交易，账户管理，钱包划转，子账户等。

### Q: 数据更新频率是多少？

A: 所有数据均实时查询 Gate API，返回最新的市场信息。

---

## 隐私与安全

- 通过 Gate 账号 OAuth2 授权（不在配置中存储 API 密钥）
- 所有 API 调用均通过 HTTPS 加密传输
- 详情请参阅 [Gate 隐私政策](https://www.gate.com/legal/privacy-policy)

---

## 支持与反馈

- **API 文档**：[Gate API 文档](https://www.gate.com/docs/developers/apiv4)
- **问题反馈**：请联系 Gate 客服
- **商务合作**：请联系 Gate 官方渠道
