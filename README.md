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

Tools are organized into the following modules:

### `gate-dex`

Decentralized exchange related tools.

- No tools are published in this module yet.

### `gate-exchange`

Spot and futures market tools. [View details](gate-exchange/gate-exchange-mcp.md)

- `get_spot_tickers` — Get spot ticker data for one trading pair or all pairs.
- `get_spot_order_book` — Get spot market depth for a specified trading pair.
- `create_spot_order` — Create a new spot buy/sell order.
- `get_futures_tickers` — Get futures ticker data for one contract or all contracts.
- `create_futures_order` — Create a new futures order for a specified contract.

### `gate-info`

General information and metadata tools.

- No tools are published in this module yet.

### `gate-news`

News and announcements tools.

- No tools are published in this module yet.

### `gate-wallet`

Wallet and asset tools. [View details](gate-wallet/gate-wallet-mcp.md)

- No tools are published in this module yet.

## Development

```bash
# Clone the repository
git clone https://github.com/gate/gate-mcp.git
cd gate-mcp

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
