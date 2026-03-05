# OpenClaw Setup Guide

## Prerequisites

- OpenClaw installed (visit [openclaw.io](https://openclaw.io))
- Node.js >= 18

## Step 1: Enable mcporter Skill

In OpenClaw, navigate to **Skills** and search for `mcporter`. Enable it.

![OpenClaw Enable mcporter](../images/openclaw-enable-mcporter.png)

## Step 2: Install mcporter Locally

Install the mcporter CLI tool globally:

```bash
npm install -g mcporter
```

Or use npx to run without installing:

```bash
npx mcporter --version
```

## Step 3: Add Gate MCP Configuration

Add the Gate MCP server configuration:

```bash
mcporter config add gate https://api.gatemcp.ai/mcp --scope home
```

This saves the configuration to your home directory.

## Step 4: Verify the Connection

Check the configuration:

```bash
mcporter config get gate
```

List the available tools:

```bash
mcporter list gate --schema
```

> If the tool list is returned, the connection is successful.

## Step 5: Use in OpenClaw

1. Start a new session in OpenClaw
2. The mcporter skill should automatically detect and use the Gate MCP configuration
3. Try: "What is the current price of BTC/USDT?"

![OpenClaw Usage](../images/openclaw-usage.png)

## Managing Configurations

### List All Configurations

```bash
mcporter config list
```

### Remove a Configuration

```bash
mcporter config remove gate
```

### Update a Configuration

```bash
mcporter config add gate https://api.gatemcp.ai/mcp --scope home --force
```

## Troubleshooting

### mcporter Not Found

Make sure mcporter is installed and in your PATH:

```bash
which mcporter
# or
npx mcporter --version
```

### Configuration Not Saving

Check if you have write permissions to the configuration directory:

```bash
mcporter config list --verbose
```

### Connection Failed

1. Verify the URL: `https://api.gatemcp.ai/mcp`
2. Check your internet connection
3. Try accessing the URL directly in a browser

## Next Steps

- Explore all [available tools](../README.md#tools)
- Learn about [futures market tools](../README.md#futures-market)
- Check the [API documentation](https://www.gate.io/docs/developers/apiv4/)
