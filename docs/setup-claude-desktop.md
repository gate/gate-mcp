# Claude Desktop Setup Guide

Claude Desktop requires a local stdio proxy to connect to the Gate MCP server.

## Step 1: Download the Python Proxy

Download the proxy file from the repository:

```bash
curl -O https://raw.githubusercontent.com/gateio/gate-ai-mcp/main/gate-mcp-proxy.py
```

Or save the following as `gate-mcp-proxy.py`:

```python
#!/usr/bin/env python3
"""
MCP Proxy for Gate CEX MCP Server
Converts stdio to HTTP for Claude Desktop compatibility
"""

import sys
import json
import urllib.request
import urllib.error

MCP_SERVER_URL = "https://api.gatemcp.ai/mcp"

def send_request(method, params=None):
    """Send request to MCP server"""
    data = json.dumps({
        "jsonrpc": "2.0",
        "method": method,
        "params": params or {},
        "id": 1
    }).encode('utf-8')

    req = urllib.request.Request(
        MCP_SERVER_URL,
        data=data,
        headers={
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
    )

    try:
        with urllib.request.urlopen(req) as response:
            return json.loads(response.read().decode('utf-8'))
    except urllib.error.URLError as e:
        return {"error": str(e)}

def main():
    """Main loop for stdio communication"""
    while True:
        try:
            line = sys.stdin.readline()
            if not line:
                break

            message = json.loads(line)
            method = message.get('method')
            params = message.get('params', {})

            result = send_request(method, params)

            response = {
                "jsonrpc": "2.0",
                "id": message.get('id'),
                "result": result.get('result', {})
            }

            print(json.dumps(response), flush=True)

        except json.JSONDecodeError:
            continue
        except KeyboardInterrupt:
            break

if __name__ == "__main__":
    main()
```

## Step 2: Edit Claude Desktop Configuration

Open the Claude Desktop configuration file:

- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

![Claude Desktop Config](../images/claude-desktop-config.png)

Add the following configuration (replace `/path/to/gate-mcp-proxy.py` with the actual path):

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

## Step 3: Restart and Verify

1. **Restart Claude Desktop** completely
2. Open a new conversation
3. Try: "List available Gate MCP tools"

![Claude Desktop Verify](../images/claude-desktop-verify.png)

## Step 4: Start Using

Example queries:

- "What is the current price of BTC/USDT?"
- "Show me the funding rate for ETH/USDT"
- "Get the liquidation history for the last 24 hours"

![Claude Desktop Usage](../images/claude-desktop-usage.png)

## Troubleshooting

### "Cannot find module" Error

Make sure Python 3 is installed and accessible:

```bash
python3 --version
```

### Permission Denied

Make the proxy script executable:

```bash
chmod +x /path/to/gate-mcp-proxy.py
```

### Connection Timeouts

1. Check your internet connection
2. Verify the MCP server URL is accessible
3. Check if a firewall is blocking the connection

## Next Steps

- Explore all [available tools](../README.md#tools)
- Learn about [futures market tools](../README.md#futures-market)
- Check the [API documentation](https://www.gate.io/docs/developers/apiv4/)
