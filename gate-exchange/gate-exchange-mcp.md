# Gate Exchange MCP Tools

> This document describes the tools available on the **private endpoint** (`/mcp/exchange`, OAuth2 required).
> For public market data tools (no auth), see the [Public MCP section in README](../README.md#public-mcp-mcp--no-auth).
>
> **OAuth2 Scopes**: `market`, `profile`, `trade`, `wallet`, `account`

All tools use the `cex_` prefix.

## 1. Spot Trading

### 1.1 Account Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_spot_get_spot_accounts` | Get spot account balances | `currency` (optional, returns all if omitted) |
| `cex_spot_list_spot_account_book` | Get spot account ledger records | `currency`, `limit`, `page`, `from`, `to`, `type`, `code` |
| `cex_spot_get_spot_fee` | Get trading fee rate | `currency_pair` |
| `cex_spot_get_spot_batch_fee` | Get trading fee rates in batch | `currency_pairs` (required, up to 50 pairs) |

### 1.2 Order Management

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_spot_create_spot_order` | Create a spot order | `currency_pair` (required), `side` (required, buy/sell), `amount` (required), `price`, `type` (limit/market), `account`, `time_in_force`, `iceberg`, `auto_borrow`, `auto_repay`, `text`, `stp_act`, `action_mode`, `slippage` |
| `cex_spot_create_spot_batch_orders` | Create spot orders in batch | `orders` (required, JSON array) |
| `cex_spot_list_spot_orders` | List spot orders | `currency_pair` (required), `status` (open/finished), `page`, `limit`, `account`, `from`, `to`, `side` |
| `cex_spot_get_spot_order` | Get a single spot order | `order_id` (required), `currency_pair` (required), `account` |
| `cex_spot_cancel_spot_order` | Cancel a single spot order | `order_id` (required), `currency_pair` (required), `account`, `action_mode` |
| `cex_spot_cancel_all_spot_orders` | Cancel all spot orders in specified pair | `currency_pair` (required), `side`, `account`, `action_mode` |
| `cex_spot_cancel_spot_batch_orders` | Cancel spot orders in batch | `order_ids` (required), `currency_pair` (required) |
| `cex_spot_amend_spot_order` | Amend a spot order | `order_id` (required), `currency_pair`, `account`, `amount`, `price`, `amend_text`, `action_mode` |
| `cex_spot_amend_spot_batch_orders` | Amend spot orders in batch | `orders` (required, JSON array) |

### 1.3 Trade Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_spot_list_spot_my_trades` | Query personal spot trade history | `currency_pair`, `limit`, `page`, `order_id`, `account`, `from`, `to` |

## 2. Futures Trading

### 2.1 Accounts and Positions

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_get_fx_accounts` | Get futures account information | `settle` (required, usdt/btc) |
| `cex_fx_list_fx_account_book` | Get futures account ledger records | `settle` (required), `contract`, `limit`, `offset`, `from`, `to`, `type` |
| `cex_fx_get_fx_position` | Get a single position | `settle` (required), `contract` (required) |
| `cex_fx_list_fx_positions` | List all positions | `settle` (required), `holding`, `limit`, `offset` |
| `cex_fx_get_fx_dual_position` | Get dual-mode position | `settle` (required), `contract` (required) |

### 2.2 Position Settings

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_update_fx_position_leverage` | Update leverage | `settle` (required), `contract` (required), `leverage` (required), `cross_leverage_limit`, `pid` |
| `cex_fx_update_fx_position_margin` | Update margin | `settle` (required), `contract` (required), `change` (required) |
| `cex_fx_update_fx_position_risk_limit` | Update risk limit tier | `settle` (required), `contract` (required), `risk_limit` (required) |
| `cex_fx_update_fx_position_cross_mode` | Switch cross/isolated mode | `settle` (required), `contract`, `mode` (required, CROSS/ISOLATED) |
| `cex_fx_update_fx_dual_position_cross_mode` | Switch mode for dual positions | `settle` (required), `contract` (required), `mode` (required, CROSS/ISOLATED) |
| `cex_fx_update_fx_dual_position_leverage` | Update leverage for dual positions | `settle` (required), `contract` (required), `leverage` (required), `cross_leverage_limit` |
| `cex_fx_update_fx_dual_position_margin` | Update margin for dual positions | `settle` (required), `contract` (required), `change` (required), `dual_side` (required, long/short) |
| `cex_fx_update_fx_dual_position_risk_limit` | Update risk limit for dual positions | `settle` (required), `contract` (required), `risk_limit` (required) |
| `cex_fx_set_fx_dual` | Set dual-position mode | `settle` (required), `dual_mode` (required, true/false) |

### 2.3 Order Management

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_create_fx_order` | Create a futures order | `settle` (required), `contract` (required), `size` (required, positive=long/negative=short), `price`, `tif` (gtc/ioc/poc/fok), `close`, `reduce_only`, `iceberg`, `text`, `auto_size`, `stp_act`, `market_order_slip_ratio`, `pos_margin_mode` |
| `cex_fx_create_fx_batch_orders` | Create futures orders in batch | `settle` (required), `orders` (required, JSON array) |
| `cex_fx_list_fx_orders` | List futures orders | `settle` (required), `status` (required, open/finished), `contract`, `limit`, `offset`, `last_id` |
| `cex_fx_get_fx_order` | Get a single futures order | `settle` (required), `order_id` (required) |
| `cex_fx_cancel_fx_order` | Cancel a single futures order | `settle` (required), `order_id` (required) |
| `cex_fx_cancel_all_fx_orders` | Cancel all futures orders | `settle` (required), `contract` (required), `side`, `exclude_reduce_only`, `text` |
| `cex_fx_cancel_fx_batch_orders` | Cancel futures orders in batch | `settle` (required), `order_ids` (required) |
| `cex_fx_amend_fx_order` | Amend a futures order | `settle` (required), `order_id` (required), `size`, `price`, `amend_text`, `text` |
| `cex_fx_amend_fx_batch_orders` | Amend futures orders in batch | `settle` (required), `orders` (required, JSON array), `order_id`, `text` |

### 2.4 Trade Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_list_fx_my_trades` | Query personal futures trade history | `settle` (required), `contract`, `limit`, `offset`, `last_id`, `order` |
| `cex_fx_get_fx_my_trades_timerange` | Query personal trades by time range | `settle` (required), `contract`, `from`, `to`, `limit`, `offset`, `role` |

### 2.5 Fee & Risk

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_get_fx_fee` | Get futures fee rate | `settle` (required), `contract` |
| `cex_fx_list_fx_risk_limit_tiers` | Get risk limit tiers | `settle` (required), `contract`, `limit`, `offset` |

## 3. Unified Account

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_unified_get_unified_accounts` | Get unified account information | `currency`, `sub_uid` |
| `cex_unified_get_unified_mode` | Get unified account mode | - |
| `cex_unified_set_unified_mode` | Set unified account mode | `mode` (required), `usdt_futures`, `spot_hedge`, `use_funding`, `options` |
| `cex_unified_get_unified_borrowable` | Get borrowable amount | `currency` (required) |
| `cex_unified_get_unified_risk_units` | Get risk units | - |
| `cex_unified_list_unified_loans` | Get unified account loan records | `currency`, `limit`, `page`, `type` |

## 4. Wallet & Transfer

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_wallet_create_transfer` | Transfer between accounts | `currency` (required), `from` (required), `to` (required), `amount` (required), `currency_pair` (for margin), `settle` (for futures/delivery) |
| `cex_wallet_get_transfer_order_status` | Get transfer status | `client_order_id`, `tx_id` |
| `cex_wallet_get_total_balance` | Get total balance | `currency` (optional, BTC/CNY/USD/USDT) |
| `cex_wallet_get_wallet_fee` | Get trading fee rates | `currency_pair`, `settle` (for futures) |
| `cex_wallet_list_deposits` | List deposits | `currency`, `limit`, `offset`, `from`, `to` |
| `cex_wallet_list_withdrawals` | List withdrawals | `currency`, `limit`, `offset`, `from`, `to` |
| `cex_wallet_create_sa_transfer` | Transfer between main and sub account | `sub_account` (required), `currency` (required), `amount` (required), `direction` (required, to/from), `sub_account_type`, `client_order_id` |
| `cex_wallet_create_sa_to_sa_transfer` | Transfer between sub accounts | `currency` (required), `sub_account_from` (required), `sub_account_from_type` (required), `sub_account_to` (required), `sub_account_to_type` (required), `amount` (required) |

## 5. Sub Account

### 5.1 Sub Account Management

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_sa_create_sa` | Create a sub account | `login_name` (required), `password`, `email`, `remark` |
| `cex_sa_get_sa` | Get sub account information | `user_id` (required) |
| `cex_sa_list_sas` | List sub accounts | `type` |
| `cex_sa_lock_sa` | Lock a sub account | `user_id` (required) |
| `cex_sa_unlock_sa` | Unlock a sub account | `user_id` (required) |
| `cex_sa_get_sa_unified_mode` | Get sub account unified mode | - |

### 5.2 Sub Account API Key

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_sa_create_sa_key` | Create sub account API key | `user_id` (required), `mode`, `name`, `perms` (JSON array), `ip_whitelist` |
| `cex_sa_get_sa_key` | Get sub account API key | `user_id` (required), `key` (required) |
| `cex_sa_list_sa_keys` | List sub account API keys | `user_id` (required) |
| `cex_sa_update_sa_key` | Update sub account API key | `user_id` (required), `key` (required), `mode`, `name`, `perms` (JSON array), `ip_whitelist` |
| `cex_sa_delete_sa_key` | Delete sub account API key | `user_id` (required), `key` (required) |
