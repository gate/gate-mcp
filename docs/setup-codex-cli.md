# Codex CLI Setup Guide

## Prerequisites

- OpenAI API key with Codex access
- Node.js >= 18

## Step 1: Install Codex CLI

Install the OpenAI Codex CLI globally:

```bash
npm install -g @openai/codex
```

Or use npx (no installation required):

```bash
npx @openai/codex --version
```

## Step 2: Configure OpenAI API Key

Set your OpenAI API key:

```bash
export OPENAI_API_KEY="your-api-key-here"
```

Or add it to your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):

```bash
echo 'export OPENAI_API_KEY="your-api-key-here"' >> ~/.zshrc
source ~/.zshrc
```

## Step 3: Add Gate MCP

**For full trading (OAuth on connect):**

```bash
codex mcp add gate --url https://api.gatemcp.ai/mcp/exchange
```

**For market data only (no auth):**

```bash
codex mcp add gate --url https://api.gatemcp.ai/mcp
```

![Codex CLI Add MCP](../images/codex-cli-add-mcp.png)

## Step 4: Verify Installation

List all configured MCP servers:

```bash
codex mcp list
```

You should see the Gate MCP server in the list.

![Codex CLI List](../images/codex-cli-list.png)

## Step 5: Start Using

Launch the Codex CLI:

```bash
codex
```

Try these example queries:

- "What is the current price of BTC/USDT?"
- "Show me arbitrage opportunities on Gate"
- "Analyze SOL for me"
- "Any new coins on Gate worth watching?"

![Codex CLI Usage](../images/codex-cli-usage.png)

## Updating the MCP Server

To update the MCP server URL or configuration:

```bash
codex mcp remove gate
codex mcp add gate --url https://api.gatemcp.ai/mcp/exchange
```

## Troubleshooting

### "OPENAI_API_KEY not set" Error

Make sure you've set your OpenAI API key:

```bash
export OPENAI_API_KEY="your-api-key-here"
```

### MCP Server Not Found

1. Check if the MCP is properly added: `codex mcp list`
2. Try removing and re-adding the MCP
3. Check your internet connection

### Connection Errors

1. Verify the URL is correct: `https://api.gatemcp.ai/mcp/exchange` (trading) or `https://api.gatemcp.ai/mcp` (market data)
2. Check if you need a proxy or VPN
3. Try again later (the server might be temporarily down)

## Next Steps

- Explore all [available tools](../README.md#available-tools)
- Learn about [futures market tools](../README.md#public-mcp-mcp--no-auth)
- Check the [API documentation](https://www.gate.com/docs/developers/apiv4/)
