# Gate Agentic Wallet MCP Server

## 1. Overview

Gate Agentic Wallet MCP Server is a Web3 wallet service built on the MCP (Model Context Protocol), providing Google OAuth login, wallet management, on-chain transaction signing, swap trading, and market data queries.

- **Protocol**: MCP (Model Context Protocol), based on JSON-RPC 2.0
- **Authentication**: Obtain an `mcp_token` via Google OAuth; include the token when calling tools that require authentication
- **Supported Chains**: EVM-compatible (ETH, BSC, Polygon, Arbitrum, Base, Avalanche, etc.) + Solana
- **Permission Scopes**: `wallet:read`, `wallet:sign`, `tx:read`, `tx:write`

## 2. Installation & Configuration

- **Endpoint URL**: `https://api.gatemcp.ai/mcp/dex`
- **x-api-key**: `MCP_AK_8W2N7Q` (case-sensitive)

### 2.1 Cursor Integration

Add the following in Cursor Settings → MCP:

```json
{
  "mcpServers": {
    "gate-dex": {
      "url": "https://api.gatemcp.ai/mcp/dex",
      "headers": {
        "x-api-key": "MCP_AK_8W2N7Q",
        "Authorization": "Bearer <your_mcp_token>"
      }
    }
  }
}
```

Once added, Cursor will automatically discover all available tools. When you first invoke a tool that requires authentication, a Google authorization page will appear to complete the login.

- **x-api-key**: Access key assigned by the server
- **Authorization**: The `mcp_token` obtained after login (valid for 30 days; after expiration, re-obtain the token and update the configuration. Restart Cursor after updating the config file)

### 2.2 Claude Desktop Integration

Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "gate-dex": {
      "url": "https://api.gatemcp.ai/mcp/dex",
      "headers": {
        "x-api-key": "MCP_AK_8W2N7Q",
        "Authorization": "Bearer <your_mcp_token>"
      }
    }
  }
}
```

After restarting Claude Desktop, you can use Gate Wallet tools directly in conversations. It is recommended to restart Claude Desktop after updating the config file.

### 2.3 Other MCP Clients

Any client that supports MCP Streamable HTTP can connect by configuring:

| Config Item | Value | Description |
|-------------|-------|-------------|
| MCP Endpoint | `https://api.gatemcp.ai/mcp/dex` | |
| x-api-key | `MCP_AK_8W2N7Q` | Access key |
| Authorization | `Bearer <mcp_token>` | Obtained after login |

### 2.4 Obtaining mcp_token

Before first use, obtain an `mcp_token` via Google OAuth login:

1. Call `dex_auth_google_login_start` → get the Google authorization URL
2. Open the URL in a browser and complete Google account login
3. Call `dex_auth_google_login_poll` to retrieve the `mcp_token`
4. Add the token to the `Authorization` header in your client configuration

The token is valid for 30 days. After expiration, repeat the steps above to obtain a new one.

> Market data and token information tools can be used without an `mcp_token`.

## 3. Authentication

### 3.1 Login Flow

#### Google OAuth Login

Google OAuth login is supported with the following flow:

1. Call `dex_auth_google_login_start` → returns `flow_id` and `verification_url`
2. User opens `verification_url` in a browser and completes Google login authorization
3. Call `dex_auth_google_login_poll` to poll the login status → returns `mcp_token` upon successful login

Poll response statuses:

| status | Description | Associated Fields |
|--------|-------------|-------------------|
| `pending` | User has not completed login yet | `retry_after` |
| `ok` | Login successful | `mcp_token`, `user_id`, `account_id`, `wallets`, etc. |
| `error` | Login failed | `error` |
| `expired` | Flow expired (default: 30 minutes) | `error` |

#### Gate OAuth Login

Gate OAuth login is supported with the following flow:

1. Call `dex_auth_gate_login_start` → returns `flow_id` and `verification_url`
2. User opens `verification_url` in a browser and completes Gate login authorization
3. Call `dex_auth_gate_login_poll` to poll the login status → returns `mcp_token` upon successful login

Poll response statuses:

| status | Description | Associated Fields |
|--------|-------------|-------------------|
| `pending` | User has not completed login yet | `retry_after` |
| `ok` | Login successful | `mcp_token`, `user_id`, `account_id`, `wallets`, etc. |
| `error` | Login failed | `error` |
| `expired` | Flow expired (default: 30 minutes) | `error` |

### 3.2 Token Details

- **Format**: `mcp_pat_<payload>.<signature>`
- **Validity**: 30 days by default
- **Delivery**: Pass `"mcp_token": "mcp_pat_xxx"` in tool parameters
- The upstream token is automatically refreshed upon expiration; re-login is required when the `refresh_token` expires

### 3.3 Tool Authentication Categories

| Category | Requires mcp_token |
|----------|-------------------|
| Auth tools (`dex_auth_*`) | No |
| Market data (`dex_market_get_*`) | No |
| Token info (`dex_token_*`) | No |
| Wallet tools (`dex_wallet_*`) | Yes |
| Transaction tools (`dex_tx_*`, `dex_chain_*`) | Yes |

## 4. Tool Reference

27 tools in total.

### 4.1 Auth Tools

| Tool Name | Description | Parameters |
|-----------|-------------|------------|
| `dex_auth_google_login_start` | Initiate a Google login flow; returns a verification URL | None |
| `dex_auth_google_login_poll` | Poll Google login status | `flow_id` (required) |
| `dex_auth_login_google_wallet` | Login directly with a Google authorization code | `code` (required), `redirect_url` (required) |
| `dex_auth_gate_login_start` | Initiate a Gate login flow; returns a verification URL | None |
| `dex_auth_gate_login_poll` | Poll Gate login status | `flow_id` (required) |
| `dex_auth_login_gate_wallet` | Login directly with a Gate authorization code | `code` (required), `redirect_url` (required) |
| `dex_auth_logout` | Revoke the current session | `mcp_token` (required) |

### 4.2 Wallet Tools

| Tool Name | Description | Parameters |
|-----------|-------------|------------|
| `dex_wallet_get_addresses` | Get wallet addresses across chains (EVM, SOL) | `account_id` (required), `mcp_token` |
| `dex_wallet_get_token_list` | Query token balance list (with prices) | `account_id`, `chain`, `network_keys`, `page`, `page_size`, `mcp_token` |
| `dex_wallet_get_total_asset` | Query total assets with 24h change | `account_id`, `mcp_token` |
| `dex_wallet_sign_message` | Sign a message with the wallet private key (32-byte hex) | `message` (required), `chain` (required, EVM/SOL), `mcp_token` |
| `dex_wallet_sign_transaction` | Sign a raw transaction with the wallet private key | `raw_tx` (required), `chain` (required, EVM/SOL), `mcp_token` |

## 5. Resources

Accessed via the MCP `resources/read` method.

### 5.1 Static Resources

| URI | Description |
|-----|-------------|
| `chain://supported` | All supported chains and their configurations (networkKey, chainType, endpoints, etc.) |
| `swap://supported_chains` | List of swap-supported chains, grouped by EVM/Solana (includes chain_id) |

### 5.2 Resource Templates

| URI Template | Description |
|--------------|-------------|
| `account://{accountId}` | Account overview (chain types, masked addresses) |
| `balance://{accountId}` | Token balance snapshot (optional `?chain=ETH&network=ETH`) |
| `kline://{chain}/{tokenAddress}?period=1h&limit=100` | Candlestick (K-line) data |
| `volume://{chain}/{tokenAddress}` | Trading volume statistics (5m/1h/4h/24h) |
| `liquidity://{chain}/{tokenAddress}` | Liquidity pool events |
| `token://{chain}/{address}` | Token contract details (including holder distribution) |
| `ranking://{direction}?top_n=10` | Gainers/losers ranking (direction: desc/asc) |
| `security://{chain}/{address}` | Security audit (honeypot, tax rate, permissions, etc.) |
| `discover_tokens://{sort_field}/{sort_order}?limit=20` | New token discovery |
| `trade://order/{txOrderId}` | Swap order details |
