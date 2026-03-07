# Gate Wallet for AI

## 1. Authentication

| Tool | Description | Main Parameters |
|---|---|---|
| `auth.google_login_start` | Start Google OAuth login flow, returns verification URL | - |
| `auth.google_login_poll` | Poll login status, returns mcp_token on success | - |
| `auth.login_google_wallet` | Login with Google OAuth authorization code | `code` |
| `auth.refresh_token` | Refresh login session | - |
| `auth.logout` | Revoke current session | - |

## 2. Wallet

| Tool | Description | Main Parameters |
|---|---|---|
| `wallet.get_addresses` | Get wallet addresses for each chain | `chain` (EVM / Solana) |
| `wallet.get_token_list` | Get token balances with prices | `chain`, `page`, `limit` |
| `wallet.get_total_asset` | Get total portfolio value and 24h change | - |
| `wallet.sign_message` | Sign a message with wallet private key | `chain`, `message` |
| `wallet.sign_transaction` | Sign a raw transaction with wallet private key | `chain`, `tx` |

## 3. Chain

| Tool | Description | Main Parameters |
|---|---|---|
| `chain.config` | Get chain configuration (chain ID, capabilities) | `chain` |

## 4. Transactions

### 4.1 Transfer & Gas

| Tool | Description | Main Parameters |
|---|---|---|
| `tx.gas` | Estimate gas price and gas limit | `chain`, `tx` |
| `tx.transfer_preview` | Preview transfer details before signing | `chain`, `to`, `amount`, `token` |
| `tx.get_sol_unsigned` | Build unsigned Solana SOL transfer with latest blockhash | `to`, `amount` |
| `tx.send_raw_transaction` | Broadcast signed transaction on-chain | `chain`, `raw_tx` |

### 4.2 Swap

| Tool | Description | Main Parameters |
|---|---|---|
| `tx.quote` | Get swap quote with route, price impact and gas estimation | `chain`, `from_token`, `to_token`, `amount` |
| `tx.swap` | One-click swap: quote → build → sign → submit | `chain`, `from_token`, `to_token`, `amount` |
| `tx.swap_detail` | Query swap order status by order ID | `order_id` |

### 4.3 History

| Tool | Description | Main Parameters |
|---|---|---|
| `tx.list` | Get transaction history list | `chain`, `limit` |
| `tx.detail` | Get transaction detail by hash | `chain`, `hash` |
| `tx.history_list` | Get swap / bridge transaction history | `chain`, `limit` |

## 5. Market Data

| Tool | Description | Main Parameters |
|---|---|---|
| `market_get_kline` | Get K-line (candlestick) data | `chain`, `pair`, `interval`(1m/5m/1h/4h/1d), `limit` |
| `market_get_tx_stats` | Get trading volume and trader statistics | `chain`, `pair`, `interval`(5m/1h/4h/24h) |
| `market_get_pair_liquidity` | Get liquidity pool add / remove events | `chain`, `pair`, `limit` |
| `market_list_swap_tokens` | List available tokens for swap on a given chain | `chain` |
| `market_list_cross_chain_bridge_tokens` | List bridgeable tokens for cross-chain transfers | `from_chain`, `to_chain` |

## 6. Token Info

| Tool | Description | Main Parameters |
|---|---|---|
| `token_get_coin_info` | Get token info: price, market cap, supply, holder distribution | `chain`, `address` |
| `token_ranking` | Get 24h top gainers / top losers | `chain`, `type`(gainers/losers) |
| `token_get_coins_range_by_created_at` | Discover new tokens by creation time range | `chain`, `from`, `to` |
| `token_get_risk_info` | Security audit: honeypot, buy/sell tax, blacklist, permissions | `chain`, `address` |
