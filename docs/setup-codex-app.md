# Codex App Setup Guide

## Prerequisites

- OpenAI Codex App installed
- OpenAI API key with Codex access

## Step 1: Open Codex Settings

Launch the Codex App and navigate to **Settings**

![Codex App Settings](../images/codex-app-settings.png)

## Step 2: Add MCP Server

1. Select **MCP Servers** from the settings menu
2. Click **Add Server**

![Codex App Add Server](../images/codex-app-add-server.png)

## Step 3: Configure the MCP Server

Enter the following details:

| Field | Value |
|-------|-------|
| Name | `Gate` or `Gate MCP` |
| URL | `https://api.gatemcp.ai/mcp` |
| Transport | `streamable-http` or `http` |

![Codex App Config](../images/codex-app-config.png)

Click **Save** to add the server.

## Step 4: Verify and Use

1. Start a new conversation in Codex App
2. Try: "What tools are available from Gate MCP?"
3. Once confirmed, try: "What's the current price of BTC/USDT?"

![Codex App Usage](../images/codex-app-usage.png)

## Troubleshooting

### Server Not Connecting

1. Check your internet connection
2. Verify the URL is correct
3. Check if Codex App has network permissions

### Tools Not Available

1. Ensure the MCP server is enabled in settings
2. Try removing and re-adding the server
3. Restart the Codex App

## Next Steps

- Explore all [available tools](../README.md#tools)
- Learn about [futures market tools](../README.md#futures-market)
- Check the [API documentation](https://www.gate.io/docs/developers/apiv4/)
