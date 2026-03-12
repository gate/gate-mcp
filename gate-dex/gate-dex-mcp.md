# Gate DEX for AI

Supported chains: ETH, BSC, Base, Solana, Arbitrum, Polygon, Avalanche, Fantom, zkSync, Linea, Optimism, Sui, Blast, Tron, Merlin, World, Eni, Bera, GateLayer, TON.

## 1. Authentication

| Tool | Description | Main Parameters |
|---|---|---|
| `auth_google_login_start` | Start Google OAuth login flow, returns a verification URL for the user to open in browser | - |
| `auth_google_login_poll` | Poll login status; returns `pending` / `ok` (with mcp_token) / `error` | `flow_id` |
| `auth_login_google_wallet` | Login with Google OAuth authorization code | `code`, `redirect_url` |
| `auth_logout` | Revoke current MCP session | `mcp_token` |

## 2. Wallet

| Tool | Description | Main Parameters |
|---|---|---|
| `wallet_get_addresses` | Get wallet addresses per chain (EVM, SOL, etc.) | `account_id` |
| `wallet_get_token_list` | Get token balances with prices (paginated) | `network_keys`, `page`, `page_size` |
| `wallet_get_total_asset` | Get total portfolio value and 24h change | `account_id` |
| `wallet_sign_message` | Sign a message (32-byte hex) with wallet private key | `chain`, `message` |
| `wallet_sign_transaction` | Sign a raw transaction with wallet private key | `chain`, `raw_tx` |

## 3. Chain

| Tool | Description | Main Parameters |
|---|---|---|
| `chain_config` | Get chain configuration (networkKey, chainID, endpoint) | `chain` |

## 4. Transactions

### 4.1 Transfer & Gas

| Tool | Description | Main Parameters |
|---|---|---|
| `tx_gas` | Estimate gas price and gas limit | `chain`, `from`, `to`, `value`, `data` |
| `tx_transfer_preview` | Preview transfer details before signing (supports EVM native/ERC-20 and Solana SOL/SPL) | `from`, `to`, `amount`, `chain`, `token`, `token_contract`, `token_mint` |
| `tx_get_sol_unsigned` | Build unsigned Solana SOL transfer with latest blockhash | `from`, `to`, `amount`, `priority_fee_micro_lamports` |
| `tx_send_raw_transaction` | Broadcast signed transaction on-chain | `chain`, `signed_tx` |

### 4.2 Swap

| Tool | Description | Main Parameters |
|---|---|---|
| `tx_quote` | Get swap quote with route, price impact and gas estimation (mandatory before `tx_swap`) | `chain_id_in`, `chain_id_out`, `token_in`, `token_out`, `amount`, `slippage`, `user_wallet`, `native_in`, `native_out` |
| `tx_swap` | One-shot swap: Quote → Build → Sign → Submit | `chain_id_in`, `chain_id_out`, `token_in`, `token_out`, `amount`, `slippage`, `user_wallet`, `account_id`, `native_in`, `native_out` |
| `tx_swap_detail` | Query swap order status by order ID | `tx_order_id` |

### 4.3 History

| Tool | Description | Main Parameters |
|---|---|---|
| `tx_list` | Get transaction history list | `account_id`, `page_num`, `page_size` |
| `tx_detail` | Get transaction detail by hash | `hash_id` |
| `tx_history_list` | Get swap / bridge transaction history (paginated) | `account_id`, `src_chain`, `dst_chain`, `page_num`, `page_size` |

## 5. Market Data

| Tool | Description | Main Parameters |
|---|---|---|
| `market_get_kline` | Get K-line (candlestick) data | `chain`, `token_address`, `period`(1m/5m/1h/4h/1d), `limit` |
| `market_get_tx_stats` | Get trading volume and trader statistics (5m/1h/4h/24h) | `chain`, `token_address` |
| `market_get_pair_liquidity` | Get liquidity pool add / remove events | `chain`, `token_address`, `page_index`, `page_size` |

## 6. Token Info

| Tool | Description | Main Parameters |
|---|---|---|
| `token_get_coin_info` | Get token info: price, market cap, supply, holder distribution | `chain`, `address`, `include_holders` |
| `token_ranking` | Get 24h top gainers / top losers | `direction`(desc/asc), `chain`, `top_n` |
| `token_get_coins_range_by_created_at` | Discover new tokens by creation time range | `start`, `end`, `chain`, `limit` |
| `token_get_risk_info` | Security audit: honeypot, buy/sell tax, blacklist, permissions | `chain`, `address` |
