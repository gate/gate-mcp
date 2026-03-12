# Cursor Setup Guide

## Method 1: One-click Install

In the AI chat, type:

> Help me auto install Gate Skills and MCPs: https://github.com/gateio/gate-skills

![Cursor One-Click Installer](../images/cursor-one-click-installer.png)

## Method 2: Manual Configuration

Gate MCP provides two endpoints. Choose based on your needs:

| Endpoint | Auth | Use Case |
|----------|------|----------|
| `https://api.gatemcp.ai/mcp` | None | Market data only (tickers, order books, K-line, etc.) |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | Full access (trading, balances, transfers — OAuth login on connect) |

### Step 1: Open Cursor Settings

Navigate to `Settings` → `Tools & MCP` → `Add Custom MCP`

![Cursor Add MCP](../images/cursor-add-mcp.png)

### Step 2: Edit MCP Configuration

Edit your `mcp.json` file.

**For full trading (OAuth on connect):**

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

![Cursor MCP JSON](../images/cursor-mcp-json.png)

### Step 3: Start Using

Open Cursor AI chat and try:

- "What is the current price of BTC/USDT?"
- "Show me the order book for ETH/USDT"
- "Get the 1-hour K-line data for SOL/USDT"

![Cursor Usage](../images/cursor-usage.png)

## Troubleshooting

### Connection Issues

1. Check your internet connection
2. Verify the MCP server URL is correct
3. Check Cursor's MCP logs for errors

### Tools Not Available

1. Ensure the MCP configuration is saved correctly
2. Restart Cursor
3. Check if the MCP server is accessible

## Next Steps

- Explore all [available tools](../README.md#available-tools)
- Learn about [futures market tools](../README.md#public-mcp-mcp--no-auth)
- Check the [API documentation](https://www.gate.com/docs/developers/apiv4/)
