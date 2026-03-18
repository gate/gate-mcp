# Gate DEX for AI

Supported chains: ETH, BSC, Base, Solana, Arbitrum, Polygon, Avalanche, Fantom, zkSync, Linea, Optimism, Sui, Blast, Tron, Merlin, World, Eni, Bera, GateLayer, TON.

## 1. Authentication

| Tool | Description | Main Parameters |
|---|---|---|
| `dex_auth_google_login_start` | Start Google OAuth login flow, returns verification URL | - |
| `dex_auth_google_login_poll` | Poll login status, returns mcp_token on success | `flow_id` |
| `dex_auth_login_google_wallet` | Login with Google OAuth authorization code | `code`, `redirect_url` |
| `dex_auth_gate_login_start` | Start Gate OAuth login flow, returns verification URL | - |
| `dex_auth_gate_login_poll` | Poll Gate OAuth login status, returns mcp_token on success | `flow_id` |
| `dex_auth_login_gate_wallet` | Login directly with Gate OAuth authorization code | `code`, `redirect_url` |
| `dex_auth_logout` | Revoke current session | `mcp_token` |

## 2. Wallet

| Tool | Description | Main Parameters |
|---|---|---|
| `dex_wallet_get_addresses` | Get wallet addresses for each chain (EVM, Solana) | `account_id` |
| `dex_wallet_get_token_list` | Token balances with prices and pagination | `network_keys`, `page`, `page_size` |
| `dex_wallet_get_total_asset` | Total portfolio value and 24h change | `account_id` |
| `dex_wallet_sign_message` | Sign a message with wallet private key (EVM / Solana) | `chain`, `message` |
| `dex_wallet_sign_transaction` | Sign a raw transaction with wallet private key | `chain`, `raw_tx` |

## 3. Chain

| Tool | Description | Main Parameters |
|---|---|---|
| `dex_chain_config` | Chain configuration (chain ID, capabilities) | `chain` |

## 4. Transactions

### 4.1 Transfer & Gas

| Tool | Description | Main Parameters |
|---|---|---|
| `dex_tx_gas` | Estimate gas price and gas limit | `chain`, `from`, `to`, `value`, `data` |
| `dex_tx_transfer_preview` | Preview transfer details before signing | `from`, `to`, `amount`, `chain`, `token`, `token_contract`, `token_mint` |
| `dex_tx_approve_preview` | Token approval preview: build ERC20/SPL approve transaction | `chain`, `token_contract`, `spender`, `amount` |
| `dex_tx_get_sol_unsigned` | Build unsigned Solana SOL transfer with latest blockhash | `from`, `to`, `amount`, `priority_fee_micro_lamports` |
| `dex_tx_send_raw_transaction` | Broadcast signed transaction on-chain | `chain`, `signed_tx` |

### 4.2 Swap

| Tool | Description | Main Parameters |
|---|---|---|
| `dex_tx_quote` | Swap quote with route, price impact and gas estimation | `chain_id_in`, `chain_id_out`, `token_in`, `token_out`, `amount`, `slippage`, `user_wallet`, `native_in`, `native_out` |
| `dex_tx_swap` | One-click swap: quote → build → sign → submit | `chain_id_in`, `chain_id_out`, `token_in`, `token_out`, `amount`, `slippage`, `user_wallet`, `account_id`, `native_in`, `native_out` |
| `dex_tx_swap_detail` | Query swap order status by order ID | `tx_order_id` |

### 4.3 History

| Tool | Description | Main Parameters |
|---|---|---|
| `dex_tx_list` | Transaction history list | `account_id`, `page_num`, `page_size` |
| `dex_tx_detail` | Transaction detail by hash | `hash_id` |
| `dex_tx_history_list` | Swap / bridge transaction history | `account_id`, `src_chain`, `dst_chain`, `page_num`, `page_size` |

## 5. Market Data

| Tool | Description | Main Parameters |
|---|---|---|
| `dex_market_get_kline` | K-line (candlestick) data: 1m, 5m, 1h, 4h, 1d | `chain`, `token_address`, `period`, `limit` |
| `dex_market_get_tx_stats` | Trading volume and trader statistics (5m / 1h / 4h / 24h) | `chain`, `token_address` |
| `dex_market_get_pair_liquidity` | Liquidity pool add / remove events | `chain`, `token_address`, `page_index`, `page_size` |

## 6. Token Info

| Tool | Description | Main Parameters |
|---|---|---|
| `dex_token_list_swap_tokens` | Available tokens for swap on a given chain | `chain` |
| `dex_token_list_cross_chain_bridge_tokens` | Bridgeable tokens for cross-chain transfers | `chain`, `token_address` |
| `dex_token_get_coin_info` | Token info: price, market cap, supply, holder distribution | `chain`, `address`, `include_holders` |
| `dex_token_ranking` | 24h top gainers / top losers | `direction`(desc/asc), `chain`, `top_n` |
| `dex_token_get_coins_range_by_created_at` | Discover new tokens by creation time range | `start`, `end`, `chain`, `limit` |
| `dex_token_get_risk_info` | Security audit: honeypot, buy/sell tax, blacklist, permissions | `chain`, `address` |

## 7. Agentic & RPC

| Tool | Description | Main Parameters |
|---|---|---|
| `dex_agentic_report` | Report agentic wallet addresses to wallet service | `wallet_address`, `chain` |
| `dex_rpc_call` | Execute JSON-RPC call to blockchain node | `chain`, `method`, `params` |
