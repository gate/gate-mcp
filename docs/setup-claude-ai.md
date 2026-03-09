# Claude.ai Setup Guide

## Prerequisites

- An active Claude.ai account (Pro or Enterprise)

## Step 1: Open Claude.ai Settings

Navigate to **Settings** → **Connectors** → **Add custom connector**

![Claude.ai Connector](../images/claude-ai-connector.png)

## Step 2: Configure the MCP Connector

1. **Name**: Enter "Gate MCP" or your preferred name
2. **URL**: Enter `https://api.gatemcp.ai/mcp`
3. **Transport**: Select `streamable-http`

![Claude.ai Config](../images/claude-ai-config.png)

## Step 3: Save and Verify

Click **Save** to add the connector. You should see it listed in your connectors.

To verify it's working:

1. Start a new conversation in Claude.ai
2. Try: "List available tools from Gate MCP"

![Claude.ai Verify](../images/claude-ai-verify.png)

## Troubleshooting

### Connector Not Saving

- Check if the URL is correct
- Verify you have the necessary permissions
- Try refreshing the page and trying again

### Tools Not Available

- Check if the connector is enabled
- Try removing and re-adding the connector
- Check if your Claude.ai plan supports custom connectors

## Next Steps

- Explore all [available tools](../README.md#tools)
- Learn about [futures market tools](../README.md#futures-market)
- Check the [API documentation](https://www.gate.io/docs/developers/apiv4/)
