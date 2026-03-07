# Gate Exchange for AI

## 1. Spot Trading

### 1.1 Account Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `get_spot_accounts` | Get spot account balances | `currency` (optional, returns all if omitted) |
| `list_spot_account_book` | Get spot account ledger records | `currency`, `from`, `to`, `limit` |
| `get_spot_fee` | Get trading fee rate | `currency_pair` |
| `get_spot_batch_fee` | Get trading fee rates in batch | `currency_pairs` (list of pairs) |

### 1.2 Order Management

| Tool | Description | Main Parameters |
|---|---|---|
| `create_spot_order` | Create a spot order | `currency_pair`, `side`(buy/sell), `amount`, `price`, `type`(limit/market), `time_in_force` |
| `list_spot_orders` | List spot orders | `currency_pair`, `status`(open/finished), `side`, `limit` |
| `get_spot_order` | Get a single spot order | `order_id`, `currency_pair` |
| `cancel_spot_order` | Cancel a single spot order | `order_id`, `currency_pair` |
| `cancel_all_spot_orders` | Cancel all spot orders | `currency_pair` (optional), `side` (optional) |
| `amend_spot_order` | Amend a spot order | `order_id`, `currency_pair`, `price`, `amount` |

### 1.3 Trade Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `list_spot_my_trades` | Query personal spot trade history | `currency_pair`, `order_id`, `limit`, `from`, `to` |

### 1.4 Market Data

| Tool | Description | Main Parameters |
|---|---|---|
| `get_spot_tickers` | Get ticker data | `currency_pair` (optional, returns all if omitted) |
| `get_spot_order_book` | Get order book depth | `currency_pair`, `limit` (depth levels) |
| `get_spot_candlesticks` | Get candlestick data | `currency_pair`, `interval`(1m/5m/1h/1d, etc.), `limit` |
| `get_spot_trades` | Get public trades | `currency_pair`, `limit` |

## 2. Futures Trading

### 2.1 Accounts and Positions

| Tool | Description | Main Parameters |
|---|---|---|
| `get_futures_accounts` | Get futures account information | `settle` (settlement currency, usdt/btc) |
| `list_futures_account_book` | Get futures account ledger records | `settle`, `type`, `limit` |
| `get_futures_position` | Get a single position | `settle`, `contract` |
| `list_futures_positions` | List all positions | `settle`, `holding` (only return active positions) |
| `get_futures_dual_mode_position` | Get dual-mode position | `settle`, `contract` |

### 2.2 Position Settings

| Tool | Description | Main Parameters |
|---|---|---|
| `update_futures_position_leverage` | Update leverage | `settle`, `contract`, `leverage` |
| `update_futures_position_margin` | Update margin | `settle`, `contract`, `change` (increase/decrease amount) |
| `update_futures_position_risk_limit` | Update risk limit tier | `settle`, `contract`, `risk_limit` |
| `update_futures_position_cross_mode` | Switch cross/isolated mode | `settle`, `contract`, `cross_leverage_limit` |
| `update_futures_dual_comp_position_cross_mode` | Switch mode for dual positions | `settle`, `contract`, `mode`(CROSS/ISOLATED) |
| `update_futures_dual_mode_position_leverage` | Update leverage for dual positions | `settle`, `contract`, `leverage` |
| `update_futures_dual_mode_position_margin` | Update margin for dual positions | `settle`, `contract`, `change` |
| `update_futures_dual_mode_position_risk_limit` | Update risk limit for dual positions | `settle`, `contract`, `risk_limit` |
| `set_futures_dual_mode` | Set dual-position mode | `settle`, `dual_mode`(true/false) |

### 2.3 Order Management

| Tool | Description | Main Parameters |
|---|---|---|
| `create_futures_order` | Create a futures order | `settle`, `contract`, `size` (positive=long, negative=short), `price`, `tif`(gtc/ioc/poc/fok), `reduce_only` |
| `list_futures_orders` | List futures orders | `settle`, `contract`, `status`(open/finished), `limit` |
| `get_futures_order` | Get a single futures order | `settle`, `order_id` |
| `get_futures_orders_timerange` | Query orders by time range | `settle`, `contract`, `from`, `to` |
| `cancel_futures_order` | Cancel a single futures order | `settle`, `order_id` |
| `cancel_all_futures_orders` | Cancel all futures orders | `settle`, `contract`, `side` (optional) |
| `amend_futures_order` | Amend a futures order | `settle`, `order_id`, `price`, `size` |

### 2.4 Trade Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `list_futures_my_trades` | Query personal futures trade history | `settle`, `contract`, `order`, `limit` |
| `get_futures_my_trades_timerange` | Query personal trades by time range | `settle`, `contract`, `from`, `to` |
| `list_futures_liq_orders` | Query liquidation orders | `settle`, `contract`, `limit` |

### 2.5 Market Data

| Tool | Description | Main Parameters |
|---|---|---|
| `get_futures_tickers` | Get futures ticker data | `settle`, `contract` (optional) |
| `get_futures_order_book` | Get futures order book depth | `settle`, `contract`, `limit` |
| `get_futures_candlesticks` | Get futures candlestick data | `settle`, `contract`, `interval`, `limit` |
| `get_futures_trades` | Get public futures trades | `settle`, `contract`, `limit` |
| `get_futures_funding_rate` | Get funding rates | `settle`, `contract`, `limit` |
| `get_futures_premium_index` | Get premium index | `settle`, `contract` |
| `get_futures_fee` | Get futures fee rate | `settle`, `contract` |

### 2.6 Contract Information

| Tool | Description | Main Parameters |
|---|---|---|
| `get_futures_contract` | Get single contract info | `settle`, `contract` |
| `list_futures_contracts` | List all futures contracts | `settle` |
| `list_futures_risk_limit_tiers` | Get risk limit tiers | `settle`, `contract` |

## 3. Unified Account

| Tool | Description | Main Parameters |
|---|---|---|
| `get_unified_accounts` | Get unified account information | `currency` (optional) |
| `get_unified_mode` | Get unified account mode | - |
| `set_unified_mode` | Set unified account mode | `mode` |
| `get_unified_borrowable` | Get borrowable amount | `currency` |
| `get_unified_risk_units` | Get risk units | - |
| `list_unified_loans` | Get unified account loan records | `currency`, `limit` |

## 4. Transfer

| Tool | Description | Main Parameters |
|---|---|---|
| `create_transfer` | Transfer between accounts | `currency`, `from` (account type), `to` (account type), `amount` |
| `get_transfer_order_status` | Get transfer status | `tx_id` |
| `get_total_balance` | Get total balance | `currency` (optional) |
| `get_wallet_fee` | Get withdrawal fee | `currency` |
| `list_deposits` | List deposits | `currency`, `limit` |
| `list_withdrawals` | List withdrawals | `currency`, `limit` |

## 5. Sub Account

### 5.1 Sub Account Management

| Tool | Description | Main Parameters |
|---|---|---|
| `create_sub_account` | Create a sub account | `login_name`, `email`, `password` |
| `get_sub_account` | Get sub account information | `user_id` |
| `list_sub_accounts` | List sub accounts | `limit` |
| `lock_sub_account` | Lock a sub account | `user_id` |
| `unlock_sub_account` | Unlock a sub account | `user_id` |
| `get_sub_account_unified_mode` | Get sub account unified mode | `user_id` |

### 5.2 Sub Account API Key

| Tool | Description | Main Parameters |
|---|---|---|
| `create_sub_account_key` | Create sub account API key | `user_id`, `name`, `perms` |
| `get_sub_account_key` | Get sub account API key | `user_id`, `key` |
| `list_sub_account_keys` | List sub account API keys | `user_id` |
| `update_sub_account_key` | Update sub account API key | `user_id`, `key`, `perms` |
| `delete_sub_account_key` | Delete sub account API key | `user_id`, `key` |

### 5.3 Sub Account Transfers

| Tool | Description | Main Parameters |
|---|---|---|
| `create_sub_account_transfer` | Transfer between main and sub account | `currency`, `sub_account`, `direction`(to/from), `amount` |
| `create_sub_account_to_sub_account_transfer` | Transfer between sub accounts | `currency`, `sub_account_from`, `sub_account_to`, `amount` |

## 6. Public Data

### 6.1 Currency Information

| Tool | Description | Main Parameters |
|---|---|---|
| `get_currency` | Get single currency information | `currency` |
| `list_currencies` | List all currencies | - |
| `get_currency_pair` | Get single currency pair information | `currency_pair` |
| `list_currency_pairs` | List all currency pairs | - |
