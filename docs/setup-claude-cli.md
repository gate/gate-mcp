# Claude CLI Setup Guide

## Prerequisites

- macOS or Linux
- Homebrew installed

## Step 1: Install Claude Code

```bash
brew install claude-code
```

For other installation methods, see the [official documentation](https://code.claude.com/docs).

## Step 2: Add Gate MCP

```bash
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp
```

![Claude CLI Add MCP](../images/claude-cli-add-mcp.png)

## Step 3: Verify Installation

```bash
claude mcp list
```

You should see the Gate MCP server in the list.

![Claude CLI List](../images/claude-cli-list.png)

## Step 4: Start Using

Start a conversation with Claude CLI:

```bash
claude
```

Try these example queries:

- "What is the current price of BTC/USDT?"
- "Show me arbitrage opportunities on Gate"
- "Analyze SOL for me"
- "Any new coins on Gate worth watching?"

## Updating

To update the MCP server URL or configuration:

```bash
claude mcp remove Gate
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp
```

## Troubleshooting

### MCP Not Found

1. Check if the MCP is properly added: `claude mcp list`
2. Try removing and re-adding the MCP
3. Check your internet connection

### Connection Errors

1. Verify the URL is correct: `https://api.gatemcp.ai/mcp`
2. Check if you need a proxy or VPN
3. Try again later (the server might be temporarily down)

## Next Steps

- Explore all [available tools](../README.md#tools)
- Learn about [futures market tools](../README.md#futures-market)
- Check the [API documentation](https://www.gate.io/docs/developers/apiv4/)
