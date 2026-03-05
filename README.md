# Gate MCP Server

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-Protocol-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

An [MCP (Model Context Protocol)](https://modelcontextprotocol.io) server that exposes Gate.io trading API as tools for AI agents.

## Features

- **Spot Market** — Ticker, order book, K-line, trades, currency & pair info
- **Futures Market** — Contract info, ticker, order book, K-line, trades
- **Funding Rate** — Historical funding rate query
- **Premium Index** — Futures premium index K-line
- **Liquidation Orders** — Futures liquidation history

## Prerequisites

- **Node.js** >= 18 (for MCP clients)
- **Python** >= 3.9 (optional, for local proxy)

## Quick Start

Choose your preferred client:

### Cursor

Edit `~/.cursor/mcp.json`:

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

See [Cursor Setup Guide](docs/setup-cursor.md) for detailed instructions.

### Claude CLI

```bash
# Install Claude Code
brew install claude-code

# Add Gate MCP
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp

# Verify
claude mcp list
```

### Claude Desktop

Claude Desktop requires a local stdio proxy.

1. Download the [Python proxy](gate-mcp-proxy.py)
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

See [Claude Desktop Setup Guide](docs/setup-claude-desktop.md) for details.

### Other Clients

| Client | Setup Guide |
|--------|-------------|
| Claude.ai | [Setup](docs/setup-claude-ai.md) |
| Codex App | [Setup](docs/setup-codex-app.md) |
| Codex CLI | [Setup](docs/setup-codex-cli.md) |
| OpenClaw | [Setup](docs/setup-openclaw.md) |

## Tools

### Spot Market

| Tool | Description |
|------|-------------|
| `list_currencies` | List all supported currencies |
| `get_currency` | Get single currency details |
| `list_currency_pairs` | List all supported trading pairs |
| `get_currency_pair` | Get single trading pair details |
| `get_spot_tickers` | Get spot ticker info |
| `get_spot_order_book` | Get spot market depth |
| `get_spot_candlesticks` | Get spot K-line data |
| `get_spot_trades` | Get spot trade records |

### Futures Market

| Tool | Description |
|------|-------------|
| `list_futures_contracts` | List all futures contracts |
| `get_futures_contract` | Get single futures contract info |
| `get_futures_tickers` | Get futures ticker info |
| `get_futures_order_book` | Get futures market depth |
| `get_futures_candlesticks` | Get futures K-line data |
| `get_futures_trades` | Get futures trade records |
| `get_futures_funding_rate` | Get historical funding rates |
| `get_futures_premium_index` | Get futures premium index K-line |
| `list_futures_liq_orders` | Get futures liquidation history |

## Development

```bash
# Clone the repository
git clone https://github.com/gateio/gate-ai-mcp.git
cd gate-ai-mcp

# Install dependencies
npm install

# Run in development mode
npm run dev

# Run tests
npm test
```

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details.

## License

[MIT](LICENSE) © gate.com
