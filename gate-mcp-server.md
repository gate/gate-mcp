# Gate MCP Server

[English](#gate-mcp-server) | [中文](#gate-mcp-服务器)

---

A Gate MCP (Model Context Protocol) server that enables AI agents to interact with the Gate cryptocurrency exchange for real-time market data.

## Features

- 🔍 **Spot Market Data** - Query spot tickers, order books, trades, and K-line data
- 📊 **Futures Market Data** - Access futures contracts, funding rates, premium index, and liquidation history
- 💹 **Real-time Prices** - Get live cryptocurrency prices across 1,700+ trading pairs
- 📈 **Technical Analysis** - Retrieve K-line/candlestick data for multiple timeframes

## Quick Start

### Prerequisites

- Claude Pro/Team/Enterprise account

### Installation

1. In Claude settings, find "Connectors"
2. Search and enable "Gate MCP Server"
3. Start chatting with Claude about crypto market data

### Basic Usage

Once enabled, you can interact with Gate market data through natural language:

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

## Available Tools

### Spot Market Tools

| Tool | Description |
|------|-------------|
| `list_currencies` | Get all supported currencies with details |
| `get_currency` | Get single currency information |
| `list_currency_pairs` | Get all supported trading pairs |
| `get_currency_pair` | Get single trading pair details |
| `get_spot_tickers` | Get spot market ticker data (price, volume, change) |
| `get_spot_order_book` | Get order book depth for a trading pair |
| `get_spot_trades` | Get recent trade history |
| `get_spot_candlesticks` | Get K-line/candlestick data |

### Futures Market Tools

| Tool | Description |
|------|-------------|
| `list_futures_contracts` | Get all perpetual contracts |
| `get_futures_contract` | Get single contract details |
| `get_futures_tickers` | Get futures market ticker data |
| `get_futures_order_book` | Get futures order book depth |
| `get_futures_trades` | Get futures trade history |
| `get_futures_candlesticks` | Get futures K-line data |
| `get_futures_funding_rate` | Get funding rate history |
| `get_futures_premium_index` | Get premium index K-line |
| `list_futures_liq_orders` | Get liquidation order history |

---

## Tool Details

### Spot Market

<details>
<summary><b>list_currencies</b> - Get all currencies</summary>

Get all supported currencies on Gate with their details.

**Parameters:** None

**Returns:** List of currencies with name, precision, deposit/withdrawal status

</details>

<details>
<summary><b>get_currency</b> - Get currency details</summary>

Get detailed information for a specific currency.

**Parameters:**
- `currency` (string, required): Currency name, e.g., `BTC`, `ETH`

**Returns:** Currency details including precision, chain info, deposit/withdrawal limits

</details>

<details>
<summary><b>list_currency_pairs</b> - Get all trading pairs</summary>

Get all supported spot trading pairs.

**Parameters:** None

**Returns:** List of trading pairs with trading rules and precision

</details>

<details>
<summary><b>get_currency_pair</b> - Get trading pair details</summary>

Get detailed information for a specific trading pair.

**Parameters:**
- `currency_pair` (string, required): Trading pair name, e.g., `BTC_USDT`

**Returns:** Trading pair details including min order size, price precision

</details>

<details>
<summary><b>get_spot_tickers</b> - Get spot tickers</summary>

Get real-time ticker data for spot markets.

**Parameters:**
- `currency_pair` (string, optional): Trading pair name. Returns all pairs if not specified
- `timezone` (string, optional): Timezone for statistics, e.g., `Asia/Shanghai`

**Returns:** Ticker data including last price, 24h high/low, volume, change percentage

</details>

<details>
<summary><b>get_spot_order_book</b> - Get order book</summary>

Get order book depth for a trading pair.

**Parameters:**
- `currency_pair` (string, required): Trading pair name
- `interval` (string, optional): Price precision merge level, `0` for no merge
- `limit` (number, optional): Number of levels to return, default 10, max 100
- `with_id` (boolean, optional): Whether to return depth update ID

**Returns:** Bid and ask levels with price and quantity

</details>

<details>
<summary><b>get_spot_trades</b> - Get recent trades</summary>

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
<summary><b>get_spot_candlesticks</b> - Get K-line data</summary>

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
<summary><b>list_futures_contracts</b> - Get all contracts</summary>

Get all perpetual futures contracts.

**Parameters:**
- `settle` (string, optional): Settlement currency, `usdt` or `btc`
- `limit` (number, optional): Maximum number to return
- `offset` (number, optional): Offset for pagination

**Returns:** Contract list with specifications and margin requirements

</details>

<details>
<summary><b>get_futures_contract</b> - Get contract details</summary>

Get detailed information for a specific contract.

**Parameters:**
- `contract` (string, required): Contract identifier, e.g., `BTC_USDT`
- `settle` (string, optional): Settlement currency, default `usdt`

**Returns:** Contract details including leverage, maintenance margin rate

</details>

<details>
<summary><b>get_futures_tickers</b> - Get futures tickers</summary>

Get real-time ticker data for futures markets.

**Parameters:**
- `settle` (string, optional): Settlement currency, default `usdt`
- `contract` (string, optional): Contract identifier. Returns all if not specified

**Returns:** Ticker data including last price, mark price, open interest

</details>

<details>
<summary><b>get_futures_order_book</b> - Get futures order book</summary>

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
<summary><b>get_futures_trades</b> - Get futures trades</summary>

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
<summary><b>get_futures_candlesticks</b> - Get futures K-line</summary>

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
<summary><b>get_futures_funding_rate</b> - Get funding rate</summary>

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
<summary><b>get_futures_premium_index</b> - Get premium index</summary>

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
<summary><b>list_futures_liq_orders</b> - Get liquidation history</summary>

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

A: No. The current version only provides public market data, which does not require a Gate account or API key.

### Q: Does it support trading?

A: The current version only provides public market data queries. Trading and account-related features will be available in future releases.

### Q: How often is the data updated?

A: All data is queried in real-time from Gate's API, returning the latest market information.

---

## Privacy & Security

- This service only queries publicly available market data
- No personal information is collected
- All API calls are transmitted via HTTPS encryption
- For more details, see [Gate Privacy Policy](https://www.gate.com/legal/privacy-policy)

---

## Support & Feedback

- **API Documentation**: [Gate API Docs](https://www.gate.com/docs/developers/apiv4)
- **Issue Reporting**: Please contact Gate support
- **Business Inquiries**: Contact Gate official channels

---

# Gate MCP 服务器

一个 Gate MCP（模型上下文协议）服务器，使 AI 代理能够与 Gate 加密货币交易所交互，获取实时市场数据。

## 功能特性

- 🔍 **现货市场数据** - 查询现货行情、订单簿、成交记录和 K 线数据
- 📊 **合约市场数据** - 获取合约信息、资金费率、溢价指数和强平历史
- 💹 **实时价格** - 获取 1,700+ 交易对的实时加密货币价格
- 📈 **技术分析** - 获取多种时间周期的 K 线/蜡烛图数据

## 快速开始

### 前置要求

- Claude Pro/Team/Enterprise 账号

### 安装步骤

1. 在 Claude 设置中找到 "Connectors"
2. 搜索并启用 "Gate MCP Server"
3. 开始与 Claude 聊天，查询加密货币市场数据

### 基础用法

启用后，您可以通过自然语言与 Gate 市场数据交互：

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

## 可用工具

### 现货市场工具

| 工具 | 描述 |
|------|------|
| `list_currencies` | 获取所有支持的币种及详情 |
| `get_currency` | 获取单个币种信息 |
| `list_currency_pairs` | 获取所有支持的交易对 |
| `get_currency_pair` | 获取单个交易对详情 |
| `get_spot_tickers` | 获取现货市场行情（价格、成交量、涨跌幅） |
| `get_spot_order_book` | 获取交易对订单簿深度 |
| `get_spot_trades` | 获取最近成交记录 |
| `get_spot_candlesticks` | 获取 K 线/蜡烛图数据 |

### 合约市场工具

| 工具 | 描述 |
|------|------|
| `list_futures_contracts` | 获取所有永续合约 |
| `get_futures_contract` | 获取单个合约详情 |
| `get_futures_tickers` | 获取合约市场行情 |
| `get_futures_order_book` | 获取合约订单簿深度 |
| `get_futures_trades` | 获取合约成交记录 |
| `get_futures_candlesticks` | 获取合约 K 线数据 |
| `get_futures_funding_rate` | 获取资金费率历史 |
| `get_futures_premium_index` | 获取溢价指数 K 线 |
| `list_futures_liq_orders` | 获取强平订单历史 |

---

## 常见问题

### Q: 需要 Gate 账号吗？

A: 不需要。当前版本仅提供公共市场数据，无需 Gate 账号或 API 密钥。

### Q: 支持交易功能吗？

A: 当前版本仅提供公共市场数据查询。交易和账户相关功能将在后续版本中提供。

### Q: 数据更新频率是多少？

A: 所有数据均实时查询 Gate API，返回最新的市场信息。

---

## 隐私与安全

- 本服务仅查询公开的市场数据
- 不收集任何个人信息
- 所有 API 调用均通过 HTTPS 加密传输
- 详情请参阅 [Gate 隐私政策](https://www.gate.com/legal/privacy-policy)

---

## 支持与反馈

- **API 文档**：[Gate API 文档](https://www.gate.com/docs/developers/apiv4)
- **问题反馈**：请联系 Gate 客服
- **商务合作**：请联系 Gate 官方渠道
