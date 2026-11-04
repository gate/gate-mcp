# CEX MCP Tools and Parameters

[English](gate-exchange-mcp.md) | [中文](gate-exchange-mcp_zh.md)

Inventory reference: service version `v1.16.7`, checked on 2026-11-04. Public `/mcp` has **83** tools; private `/mcp/exchange` has a source registration ceiling of **310**. The private endpoint does not include public tools, and authorization and operational policies determine the visible subset. Each tool below states its endpoint.

See the [full catalogue](gateapi-mcp-service-tools.md) for all 393 names and per-tool ordinary OAuth and Agentic permissions. Parameter tables below retain common inputs; they do not replace the connected endpoint's `tools/list` schema for optional fields, defaults and limits. This reference covers the remote service, not the separate gate-local-mcp implementation. Required markers refer to the current MCP schema; downstream business conditions can require additional fields.

The remote service has retired sub-account/API-key administration, CrossEx, P2P, activity, coupon, welfare and Launch products. Registered wallet tools for sub-account balances and transfers are separate from retired administration tools. Legacy `cex_tradfi_*` names are not callable; CFD uses `cex_cfd_*`. Old structured-product and ETH2 tool names are absent from the current directory; use the current Earn contracts.

| Business | Public `/mcp` | Private `/mcp/exchange` |
|---|---:|---:|
| Spot | 10 | 27 |
| Futures | 18 | 54 |
| Margin | 3 | 17 |
| Options | 12 | 17 |
| Delivery | 8 | 21 |
| Wallet | 1 | 22 |
| Unified account | 5 | 22 |
| Account management | 0 | 10 |
| Rebate | 0 | 10 |
| Flash swap | 1 | 8 |
| Earn | 7 | 42 |
| Alpha | 3 | 6 |
| CFD / TradFi | 4 | 16 |
| Stock | 5 | 11 |
| Multi-collateral loan | 4 | 8 |
| Strategy bots / AIHub | 0 | 12 |
| Portfolio optimization / AssetSwap | 0 | 7 |
| Square | 2 | 0 |
| **Total** | **83** | **310** |

## 1. Spot Trading

### 1.1 Account Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_spot_get_spot_accounts` (/mcp/exchange) | Get spot account balances | `currency` (optional); otherwise `page` (default 1), `limit` (default 10, max 1000). Returns `accounts` and `pagination`; specifying currency disables pagination. |
| `cex_spot_list_spot_account_book` (/mcp/exchange) | Get spot account ledger records | `currency`, `limit`, `page`, `from`, `to`, `type`, `code` |
| `cex_spot_get_spot_fee` (/mcp/exchange) | Get trading fee rate | `currency_pair` |
| `cex_spot_get_spot_batch_fee` (/mcp/exchange) | Get trading fee rates in batch | `currency_pairs` (required, up to 50 pairs) |
| `cex_spot_list_all_open_orders` (/mcp/exchange) | List all open orders across pairs | `account`, `page`, `limit` |
| `cex_spot_get_spot_price_triggered_order` (/mcp/exchange) | Get price-triggered order | `order_id` |
| `cex_spot_list_spot_price_triggered_orders` (/mcp/exchange) | List price-triggered orders | `status` (required), `market`, `account`, `limit`, `offset` |
| `cex_spot_get_spot_insurance_history` (/mcp) | Get insurance fund history | `business`, `currency`, `from`, `to` (required); `limit`, `page` |

### 1.2 Order Management

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_spot_create_spot_order` (/mcp/exchange) | Create a spot order | `currency_pair` (required), `side` (required, buy/sell), `amount` (required), `price`, `type` (limit/market), `account`, `time_in_force`, `iceberg`, `auto_borrow`, `auto_repay`, `text`, `stp_act`, `action_mode`, `slippage`; `stop_profit`, `stop_loss`, `trade_quote` |
| `cex_spot_create_spot_batch_orders` (/mcp/exchange) | Create spot orders in batch | `orders` (required, JSON array) |
| `cex_spot_list_spot_orders` (/mcp/exchange) | List spot orders | `currency_pair` (required), `status` (open/finished), `page`, `limit`, `account`, `from`, `to`, `side` |
| `cex_spot_get_spot_order` (/mcp/exchange) | Get a single spot order | `order_id` (required), `currency_pair` (required), `account` |
| `cex_spot_cancel_spot_order` (/mcp/exchange) | Cancel a single spot order | `order_id` (required), `currency_pair` (required), `account`, `action_mode` |
| `cex_spot_cancel_all_spot_orders` (/mcp/exchange) | Cancel spot orders matching filters | `currency_pair` (optional in the current MCP schema), `side`, `account`, `action_mode`; `trade_quote` |
| `cex_spot_cancel_spot_batch_orders` (/mcp/exchange) | Cancel spot orders in batch | `order_ids` (required), `currency_pair` (required) |
| `cex_spot_amend_spot_order` (/mcp/exchange) | Amend a spot order | `order_id` (required), `currency_pair`, `account`, `amount`, `price`, `amend_text`, `action_mode`; `stop_profit`, `stop_loss` |
| `cex_spot_amend_spot_batch_orders` (/mcp/exchange) | Amend spot orders in batch | `orders` (required, JSON array) |
| `cex_spot_create_spot_price_triggered_order` (/mcp/exchange) | Create price-triggered order | `body` (required JSON string containing `market`, `trigger`, `put`, and applicable options) |
| `cex_spot_cancel_spot_price_triggered_order` (/mcp/exchange) | Cancel price-triggered order | `order_id` |
| `cex_spot_cancel_spot_price_triggered_order_list` (/mcp/exchange) | Cancel all matching price-triggered orders | `market`, `account`; cancels all matching price-triggered orders, not an `order_ids` batch |
| `cex_spot_countdown_cancel_all_spot` (/mcp/exchange) | Countdown cancel all spot orders | `body` (required JSON string); includes `timeout` and optional `currency_pair` |
| `cex_spot_create_cross_liquidate_order` (/mcp/exchange) | Create cross-margin liquidation order | `body` (required JSON string); includes `currency_pair`, `amount`, `price`, optional `text`, `action_mode` |

### 1.3 Trade Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_spot_list_spot_my_trades` (/mcp/exchange) | Query personal spot trade history | `currency_pair`, `limit`, `page`, `order_id`, `account`, `from`, `to` |

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_spot_cancel_spot_pov_order` (/mcp/exchange) | Cancel a Spot POV order |
| `cex_spot_cancel_spot_pov_orders` (/mcp/exchange) | Cancel Spot POV orders |
| `cex_spot_create_spot_pov_order` (/mcp/exchange) | Create a Spot POV order |
| `cex_spot_get_spot_pov_order` (/mcp/exchange) | Query Spot POV order details |
| `cex_spot_list_spot_pov_orders` (/mcp/exchange) | List Spot POV orders |
| `cex_spot_list_spot_rpi_order_book` (/mcp) | Get the RPI order book |


## 2. Futures Trading

### 2.1 Accounts and Positions

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_get_fx_accounts` (/mcp/exchange) | Get futures account information | `settle` (required, btc/usdt/usd1) |
| `cex_fx_list_fx_account_book` (/mcp/exchange) | Get futures account ledger records | `settle` (required), `contract`, `limit`, `offset`, `from`, `to`, `type` |
| `cex_fx_get_fx_position` (/mcp/exchange) | Get a single position | `settle` (required), `contract` (required) |
| `cex_fx_list_fx_positions` (/mcp/exchange) | List all positions | `settle` (required), `holding`, `limit`, `offset` |
| `cex_fx_get_fx_dual_position` (/mcp/exchange) | Get dual-mode position | `settle` (required), `contract` (required) |

### 2.2 Position Settings

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_update_fx_position_leverage` (/mcp/exchange) | Update leverage | `settle` (required), `contract` (required), `leverage` (required), `cross_leverage_limit`, `pid` |
| `cex_fx_update_fx_position_margin` (/mcp/exchange) | Update margin | `settle` (required), `contract` (required), `change` (required) |
| `cex_fx_update_fx_position_risk_limit` (/mcp/exchange) | Update risk limit tier | `settle` (required), `contract` (required), `risk_limit` (required) |
| `cex_fx_update_fx_position_cross_mode` (/mcp/exchange) | Switch cross/isolated mode | `settle` (required), `contract` (required by the current MCP schema), `mode` (required, CROSS/ISOLATED) |
| `cex_fx_update_fx_dual_position_cross_mode` (/mcp/exchange) | Switch mode for dual positions | `settle` (required), `contract` (required), `mode` (required, CROSS/ISOLATED) |
| `cex_fx_update_fx_dual_position_leverage` (/mcp/exchange) | Update leverage for dual positions | `settle` (required), `contract` (required), `leverage` (required), `cross_leverage_limit` |
| `cex_fx_update_fx_dual_position_margin` (/mcp/exchange) | Update margin for dual positions | `settle` (required), `contract` (required), `change` (required), `dual_side` (required, long/short) |
| `cex_fx_update_fx_dual_position_risk_limit` (/mcp/exchange) | Update risk limit for dual positions | `settle` (required), `contract` (required), `risk_limit` (required) |
| `cex_fx_set_fx_dual` (/mcp/exchange) | Set dual-position mode | `settle` (required), `dual_mode` (required, true/false) |

### 2.3 Order Management

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_create_fx_order` (/mcp/exchange) | Create a futures order | `settle` (required), `contract` (required), `size` (required, positive=long/negative=short), `price`, `tif` (gtc/ioc/poc/fok), `close`, `reduce_only`, `iceberg`, `text`, `auto_size`, `stp_act`, `market_order_slip_ratio`, `pos_margin_mode`; `action_mode`, `pid`, `tpsl_sl_bbo_type`, `tpsl_sl_trigger_price`, `tpsl_tp_bbo_type`, `tpsl_tp_trigger_price` |
| `cex_fx_create_fx_batch_orders` (/mcp/exchange) | Create futures orders in batch | `settle` (required), `orders` (required, JSON array) |
| `cex_fx_list_fx_orders` (/mcp/exchange) | List futures orders | `settle` (required), `status` (required, open/finished), `contract`, `limit`, `offset`, `last_id` |
| `cex_fx_get_fx_order` (/mcp/exchange) | Get a single futures order | `settle` (required), `order_id` (required) |
| `cex_fx_cancel_fx_order` (/mcp/exchange) | Cancel a single futures order | `settle` (required), `order_id` (required); `action_mode` |
| `cex_fx_cancel_all_fx_orders` (/mcp/exchange) | Cancel futures orders matching filters | `settle` (required), `contract` (optional; omission does not restrict cancellation to one contract), `side`, `exclude_reduce_only`, `text`; `action_mode` |
| `cex_fx_cancel_fx_batch_orders` (/mcp/exchange) | Cancel futures orders in batch | `settle` (required), `order_ids` (required) |
| `cex_fx_amend_fx_order` (/mcp/exchange) | Amend a futures order | `settle` (required), `order_id` (required), `size`, `price`, `amend_text`, `text`; `action_mode` |
| `cex_fx_amend_fx_batch_orders` (/mcp/exchange) | Amend futures orders in batch | `settle` (required), `orders` (required JSON array); each order carries its own `order_id` / `text` where applicable |

### 2.4 Trade Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_list_fx_my_trades` (/mcp/exchange) | Query personal futures trade history | `settle` (required), `contract`, `limit`, `offset`, `last_id`, `order` |
| `cex_fx_get_fx_my_trades_timerange` (/mcp/exchange) | Query personal trades by time range | `settle` (required), `contract`, `from`, `to`, `limit`, `offset`, `role` |

### 2.5 Fee & Risk

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_fx_get_fx_fee` (/mcp/exchange) | Get futures fee rate | `settle` (required), `contract` |
| `cex_fx_list_fx_risk_limit_tiers` (/mcp) | Get risk limit tiers | `settle` (required), `contract`, `limit`, `offset` |

### 2.6 Additional Futures Tools

| Tool | Description |
|------|-------------|
| `cex_fx_get_fx_orders_with_time_range` (/mcp/exchange) | Query orders by time range |
| `cex_fx_get_leverage` (/mcp/exchange) | Get leverage setting |
| `cex_fx_list_position_close` (/mcp/exchange) | List position close records |
| `cex_fx_list_auto_deleverages` (/mcp/exchange) | List auto deleverage records |
| `cex_fx_list_price_triggered_orders` (/mcp/exchange) / `cex_fx_get_fx_price_triggered_order` (/mcp/exchange) | Price-triggered orders |
| `cex_fx_get_trail_orders` (/mcp/exchange) / `cex_fx_get_trail_order_detail` (/mcp/exchange) / `cex_fx_get_trail_order_change_log` (/mcp/exchange) | Trail orders |
| `cex_fx_create_fx_bbo_order` (/mcp/exchange) | Create BBO (best bid/offer) order |
| `cex_fx_create_fx_price_triggered_order` (/mcp/exchange) / `cex_fx_cancel_fx_price_triggered_order` (/mcp/exchange) / `cex_fx_cancel_fx_price_triggered_order_list` (/mcp/exchange) / `cex_fx_update_fx_price_triggered_order` (/mcp/exchange) | Price-triggered order management |
| `cex_fx_countdown_cancel_all_fx` (/mcp/exchange) | Countdown cancel all futures orders |
| `cex_fx_create_trail_order` (/mcp/exchange) / `cex_fx_update_trail_order` (/mcp/exchange) / `cex_fx_stop_trail_order` (/mcp/exchange) / `cex_fx_stop_all_trail_orders` (/mcp/exchange) | Trail order management |
| `cex_fx_get_fx_risk_limit_table` (/mcp) | Query risk limit table by ID |
| `cex_fx_list_liquidated_orders` (/mcp/exchange) | Query user liquidation history |
| `cex_fx_list_positions_timerange` (/mcp/exchange) | Query position history by time range |
| `cex_fx_set_position_mode` (/mcp/exchange) | Set position mode (one-way/hedge) |
| `cex_fx_update_fx_contract_position_leverage` (/mcp/exchange) | Update leverage for specified margin mode |

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_fx_create_chase_order` (/mcp/exchange) | Create a chase order |
| `cex_fx_get_chase_order_detail` (/mcp/exchange) | Get chase order detail |
| `cex_fx_get_chase_orders` (/mcp/exchange) | List chase orders |
| `cex_fx_list_fx_adl_risk_states` (/mcp) | List market-level ADL risk states |
| `cex_fx_list_fx_contracts_all` (/mcp) | Query all contract information (including delisted) |
| `cex_fx_list_fx_rpi_order_book` (/mcp) | Query futures RPI order book |
| `cex_fx_stop_all_chase_orders` (/mcp/exchange) | Stop chase orders in batch |
| `cex_fx_stop_chase_order` (/mcp/exchange) | Stop a chase order |


## 3. Margin

| Tool | Description |
|------|-------------|
| `cex_margin_list_margin_accounts` (/mcp/exchange) / `cex_margin_list_margin_account_book` (/mcp/exchange) | Margin account & ledger |
| `cex_margin_list_funding_accounts` (/mcp/exchange) / `cex_margin_get_auto_repay_status` (/mcp/exchange) | Funding account, auto repay |
| `cex_margin_get_margin_transferable` (/mcp/exchange) / `cex_margin_get_user_margin_tier` (/mcp/exchange) | Transferable, tier |
| `cex_margin_list_uni_loans` (/mcp/exchange) / `cex_margin_list_uni_loan_records` (/mcp/exchange) / `cex_margin_list_uni_loan_interest_records` (/mcp/exchange) | Uni loans |
| `cex_margin_get_uni_borrowable` (/mcp/exchange) / `cex_margin_list_cross_margin_loans` (/mcp/exchange) / `cex_margin_list_cross_margin_repayments` (/mcp/exchange) | Borrowable, cross margin |
| `cex_margin_set_auto_repay` (/mcp/exchange) / `cex_margin_set_user_market_leverage` (/mcp/exchange) | Auto repay, leverage |
| `cex_margin_create_uni_loan` (/mcp/exchange) | Create uni loan |

## 4. Options

| Tool | Description |
|------|-------------|
| `cex_options_list_my_options_settlements` (/mcp/exchange) / `cex_options_list_options_account` (/mcp/exchange) / `cex_options_list_options_account_book` (/mcp/exchange) | Account & settlements |
| `cex_options_list_options_positions` (/mcp/exchange) / `cex_options_get_options_position` (/mcp/exchange) / `cex_options_list_options_position_close` (/mcp/exchange) | Positions |
| `cex_options_list_options_orders` (/mcp/exchange) / `cex_options_get_options_order` (/mcp/exchange) / `cex_options_list_my_options_trades` (/mcp/exchange) | Orders & trades |
| `cex_options_get_options_mmp` (/mcp/exchange) | MMP (Market Maker Protection) |
| `cex_options_create_options_order` (/mcp/exchange) / `cex_options_cancel_options_orders` (/mcp/exchange) / `cex_options_cancel_options_order` (/mcp/exchange) | Order management |
| `cex_options_amend_options_order` (/mcp/exchange) | Amend options order (price/size) |
| `cex_options_countdown_cancel_all_options` (/mcp/exchange) / `cex_options_set_options_mmp` (/mcp/exchange) / `cex_options_reset_options_mmp` (/mcp/exchange) | Countdown, MMP |

## 5. Delivery

| Tool | Description |
|------|-------------|
| `cex_dc_list_dc_accounts` (/mcp/exchange) / `cex_dc_list_dc_account_book` (/mcp/exchange) | Account & ledger |
| `cex_dc_list_dc_positions` (/mcp/exchange) / `cex_dc_get_dc_position` (/mcp/exchange) | Positions |
| `cex_dc_list_dc_orders` (/mcp/exchange) / `cex_dc_get_dc_order` (/mcp/exchange) | Orders |
| `cex_dc_get_my_dc_trades` (/mcp/exchange) / `cex_dc_list_dc_position_close` (/mcp/exchange) / `cex_dc_list_dc_liquidates` (/mcp/exchange) / `cex_dc_list_dc_settlements` (/mcp/exchange) | Trades, settlements |
| `cex_dc_list_price_triggered_dc_orders` (/mcp/exchange) / `cex_dc_get_price_triggered_dc_order` (/mcp/exchange) | Price-triggered orders |
| `cex_dc_update_dc_position_margin` (/mcp/exchange) / `cex_dc_update_dc_position_leverage` (/mcp/exchange) / `cex_dc_update_dc_position_risk_limit` (/mcp/exchange) | Position settings |
| `cex_dc_create_dc_order` (/mcp/exchange) / `cex_dc_cancel_dc_orders` (/mcp/exchange) / `cex_dc_cancel_dc_order` (/mcp/exchange) | Order management |
| `cex_dc_create_price_triggered_dc_order` (/mcp/exchange) / `cex_dc_cancel_price_triggered_dc_order` (/mcp/exchange) / `cex_dc_cancel_price_triggered_dc_order_list` (/mcp/exchange) | Price-triggered order management |

## 6. Unified Account

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_unified_get_unified_accounts` (/mcp/exchange) | Get unified account information | `currency`, `sub_uid` |
| `cex_unified_get_unified_mode` (/mcp/exchange) | Get unified account mode | - |
| `cex_unified_set_unified_mode` (/mcp/exchange) | Set unified account mode | `mode` (required), `settings` (JSON string). Compatible switches: `usdt_futures`, `spot_hedge`, `use_funding`, `options`; explicit settings takes precedence. |
| `cex_unified_get_unified_borrowable` (/mcp/exchange) | Get borrowable amount | `currency` (required) |
| `cex_unified_get_unified_risk_units` (/mcp/exchange) | Get risk units | - |
| `cex_unified_list_unified_loans` (/mcp/exchange) | Get unified account loan records | `currency`, `limit`, `page`, `type` |
| `cex_unified_calculate_portfolio_margin` (/mcp) / `cex_unified_create_unified_loan` (/mcp/exchange) | Portfolio margin, create loan | See `tools/list` |
| `cex_unified_get_history_loan_rate` (/mcp) / `cex_unified_get_unified_borrowable_list` (/mcp/exchange) / `cex_unified_get_unified_estimate_rate` (/mcp/exchange) | Loan rate, borrowable list | See `tools/list` |
| `cex_unified_get_unified_transferable` (/mcp/exchange) / `cex_unified_get_unified_transferables` (/mcp/exchange) | Transferable amounts | See `tools/list` |
| `cex_unified_get_user_leverage_currency_config` (/mcp/exchange) / `cex_unified_get_user_leverage_currency_setting` (/mcp/exchange) / `cex_unified_set_user_leverage_currency_setting` (/mcp/exchange) | Leverage config | See `tools/list` |
| `cex_unified_list_currency_discount_tiers` (/mcp) / `cex_unified_list_loan_margin_tiers` (/mcp) | Discount tiers | See `tools/list` |
| `cex_unified_list_unified_currencies` (/mcp) / `cex_unified_list_unified_loan_interest_records` (/mcp/exchange) / `cex_unified_list_unified_loan_records` (/mcp/exchange) | Currencies, loan records | See `tools/list` |
| `cex_unified_set_unified_collateral` (/mcp/exchange) | Set collateral | See `tools/list` |

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_unified_create_quick_repayment` (/mcp/exchange) | Quick repayment |
| `cex_unified_get_estimated_quick_repayment` (/mcp/exchange) | Estimated quick repayment details |
| `cex_unified_get_unified_delta_neutral` (/mcp/exchange) | Query the account Delta-neutral strategy mode setting |
| `cex_unified_set_unified_delta_neutral` (/mcp/exchange) | Set the account Delta-neutral strategy mode |
| `cex_unified_set_user_leverage` (/mcp/exchange) | Set leverage for all of the user's borrowed currencies |


## 7. Wallet & Transfer

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_wallet_get_transfer_order_status` (/mcp/exchange) | Get transfer status | `client_order_id`, `tx_id` |
| `cex_wallet_get_total_balance` (/mcp/exchange) | Get total balance | `currency` (optional, BTC/CNY/USD/USDT) |
| `cex_wallet_get_wallet_fee` (/mcp/exchange) | Get trading fee rates | `currency_pair`, `settle` (for futures) |
| `cex_wallet_list_deposits` (/mcp/exchange) | List deposits | `currency`, `limit`, `offset`, `from`, `to` |
| `cex_wallet_list_withdrawals` (/mcp/exchange) | List withdrawals | `currency`, `limit`, `offset`, `from`, `to`, `asset_class`, `withdraw_id`, `withdraw_order_id` |
| `cex_wallet_create_sa_transfer` (/mcp/exchange) | Transfer between main and sub account | `sub_account` (required), `currency` (required), `amount` (required), `direction` (required, to/from), `sub_account_type`, `client_order_id` |
| `cex_wallet_create_sa_to_sa_transfer` (/mcp/exchange) | Transfer between sub accounts | `currency` (required), `sub_account_from` (required), `sub_account_from_type` (required), `sub_account_to` (required), `sub_account_to_type` (required), `amount` (required) |
| `cex_wallet_get_deposit_address` (/mcp/exchange) / `cex_wallet_list_currency_chains` (/mcp) | Deposit address, chains | See `tools/list` |
| `cex_wallet_list_sa_balances` (/mcp/exchange) / `cex_wallet_list_sa_cross_margin_balances` (/mcp/exchange) / `cex_wallet_list_sa_fx_balances` (/mcp/exchange) / `cex_wallet_list_sa_margin_balances` (/mcp/exchange) / `cex_wallet_list_sa_transfers` (/mcp/exchange) | Sub-account balances & transfers | See `tools/list` |
| `cex_wallet_list_small_balance` (/mcp/exchange) / `cex_wallet_list_small_balance_history` (/mcp/exchange) / `cex_wallet_convert_small_balance` (/mcp/exchange) | Small balance convert | See `tools/list` |

### Additional tools

| Tool (endpoint) | Description | Main parameters |
|---|---|---|
| `cex_wallet_create_transfer` (/mcp/exchange) | Transfer between trading accounts | `currency`, `from`, `to`, `amount` (required); `currency_pair` is also required for margin, `settle` for futures/delivery |
| `cex_wallet_get_transfer` (/mcp/exchange) | Get trading account transfer | `tx_id` (required string) |


## 8. Account Management

| Tool | Description |
|------|-------------|
| `cex_account_get_account_detail` (/mcp/exchange) | Get account detail |
| `cex_account_get_account_main_keys` (/mcp/exchange) | Get main API keys |
| `cex_account_get_account_rate_limit` (/mcp/exchange) | Get rate limit |
| `cex_account_get_debit_fee` (/mcp/exchange) / `cex_account_set_debit_fee` (/mcp/exchange) | GT fee-deduction settings; setting requires boolean `enabled`, with explicit false to disable |
| `cex_account_list_stp_groups` (/mcp/exchange) / `cex_account_list_stp_groups_users` (/mcp/exchange) | STP groups |
| `cex_account_create_stp_group` (/mcp/exchange) | Create STP group |
| `cex_account_add_stp_group_users` (/mcp/exchange) / `cex_account_delete_stp_group_users` (/mcp/exchange) | Manage STP users |

## 9. Rebate

| Tool | Description |
|------|-------------|
| `cex_rebate_partner_commissions_history` (/mcp/exchange) / `cex_rebate_partner_sub_list` (/mcp/exchange) / `cex_rebate_partner_transaction_history` (/mcp/exchange) | Partner rebate |
| `cex_rebate_broker_commission_history` (/mcp/exchange) / `cex_rebate_broker_transaction_history` (/mcp/exchange) | Broker rebate |
| `cex_rebate_user_info` (/mcp/exchange) / `cex_rebate_user_sub_relation` (/mcp/exchange) | User rebate info |
| `cex_rebate_get_partner_application_recent` (/mcp/exchange) | Get partner application records (last 30 days) |
| `cex_rebate_get_partner_eligibility` (/mcp/exchange) | Check partner application eligibility |

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_rebate_get_partner_agent_data_aggregated` (/mcp/exchange) | Aggregated partner agent statistics |


## 10. Flash Swap

| Tool | Description |
|------|-------------|
| `cex_fc_list_fc_currency_pairs` (/mcp) | List flash swap currency pairs |
| `cex_fc_list_fc_orders` (/mcp/exchange) / `cex_fc_get_fc_order` (/mcp/exchange) | Query orders |
| `cex_fc_preview_fc_order_v1` (/mcp/exchange) | Preview one-to-one flash swap |
| `cex_fc_create_fc_order_v1` (/mcp/exchange) | Create one-to-one flash swap order |
| `cex_fc_preview_fc_multi_currency_many_to_one_order` (/mcp/exchange) | Preview many-to-one flash swap |
| `cex_fc_preview_fc_multi_currency_one_to_many_order` (/mcp/exchange) | Preview one-to-many flash swap |
| `cex_fc_create_fc_multi_currency_many_to_one_order` (/mcp/exchange) | Create many-to-one flash swap order |
| `cex_fc_create_fc_multi_currency_one_to_many_order` (/mcp/exchange) | Create one-to-many flash swap order |

## 11. Earn

| Tool | Description |
|------|-------------|
| `cex_earn_asset_list` (/mcp/exchange) / `cex_earn_award_list` (/mcp/exchange) | Assets, awards |
| `cex_earn_list_dual_balance` (/mcp/exchange) / `cex_earn_list_dual_orders` (/mcp/exchange) | Dual investment |
| `cex_earn_order_list` (/mcp/exchange) | Earn order list |
| `cex_earn_get_uni_currency` (/mcp) / `cex_earn_get_uni_interest` (/mcp/exchange) / `cex_earn_get_uni_interest_status` (/mcp/exchange) | Uni earn |
| `cex_earn_list_uni_chart` (/mcp/exchange) / `cex_earn_list_uni_interest_records` (/mcp/exchange) / `cex_earn_list_uni_lend_records` (/mcp/exchange) | Uni records |
| `cex_earn_change_uni_lend` (/mcp/exchange) | Change flexible lending |
| `cex_earn_list_earn_fixed_term_products` (/mcp) / `cex_earn_list_earn_fixed_term_products_by_asset` (/mcp) | Fixed-term products |
| `cex_earn_list_earn_fixed_term_lends` (/mcp/exchange) / `cex_earn_list_earn_fixed_term_history` (/mcp/exchange) | Fixed-term subscriptions & history |
| `cex_earn_create_earn_fixed_term_lend` (/mcp/exchange) / `cex_earn_create_earn_fixed_term_pre_redeem` (/mcp/exchange) | Fixed-term subscribe & redeem |

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_earn_add_position_auto_invest_plan` (/mcp/exchange) | Add position immediately |
| `cex_earn_create_auto_invest_plan` (/mcp/exchange) | Create auto invest plan |
| `cex_earn_create_uni_lend` (/mcp/exchange) | Create lending or redemption |
| `cex_earn_get_auto_invest_min_amount` (/mcp/exchange) | Get minimum investment amount |
| `cex_earn_get_auto_invest_plan_detail` (/mcp/exchange) | Query auto-investment plan details |
| `cex_earn_get_dual_order_refund_preview` (/mcp/exchange) | Dual-currency early redemption preview |
| `cex_earn_get_dual_project_recommend` (/mcp/exchange) | Dual-currency recommended projects |
| `cex_earn_get_dual_stock_order_refund_preview` (/mcp/exchange) | Preview stock dual investment redemption |
| `cex_earn_get_dual_stock_project_recommend` (/mcp) | Get recommendations for stock dual investment products |
| `cex_earn_list_auto_invest_coins` (/mcp/exchange) | Query currencies supported for auto investment |
| `cex_earn_list_auto_invest_config` (/mcp/exchange) | List investment currency configuration |
| `cex_earn_list_auto_invest_orders` (/mcp/exchange) | Query auto-investment execution order details |
| `cex_earn_list_auto_invest_plan_records` (/mcp/exchange) | List plan execution records |
| `cex_earn_list_auto_invest_plans` (/mcp/exchange) | Query auto-investment plans |
| `cex_earn_list_dual_stock_balance` (/mcp/exchange) | Get stock dual investment asset statistics |
| `cex_earn_list_dual_stock_investment_plans` (/mcp) | List stock dual investment products |
| `cex_earn_list_dual_stock_orders` (/mcp/exchange) | List stock dual investment orders |
| `cex_earn_modify_dual_order_reinvest` (/mcp/exchange) | Modify dual-currency order reinvest |
| `cex_earn_modify_dual_stock_order_reinvest` (/mcp/exchange) | Reinvest a stock dual investment order |
| `cex_earn_place_dual_order` (/mcp/exchange) | Place Dual Investment order |
| `cex_earn_place_dual_order_refund` (/mcp/exchange) | Dual-currency order early redemption |
| `cex_earn_place_dual_stock_order` (/mcp/exchange) | Place a stock dual investment order |
| `cex_earn_place_dual_stock_order_refund` (/mcp/exchange) | Redeem a stock dual investment order |
| `cex_earn_stop_auto_invest_plan` (/mcp/exchange) | Stop an auto-investment plan |
| `cex_earn_swap_staking_coin` (/mcp/exchange) | Swap staking coins |
| `cex_earn_update_auto_invest_plan` (/mcp/exchange) | Update an auto-investment plan |


## 12. Alpha

| Tool | Description |
|------|-------------|
| `cex_alpha_list_alpha_accounts` (/mcp/exchange) / `cex_alpha_list_alpha_account_book` (/mcp/exchange) | Alpha account |
| `cex_alpha_list_alpha_orders` (/mcp/exchange) / `cex_alpha_get_alpha_order` (/mcp/exchange) | Alpha orders |
| `cex_alpha_quote_alpha_order` (/mcp/exchange) / `cex_alpha_place_alpha_order` (/mcp/exchange) | Quote & place |

## 13. CFD / TradFi

| Tool | Description |
|------|-------------|
| `cex_cfd_query_categories` (/mcp) / `cex_cfd_query_symbols` (/mcp) / `cex_cfd_query_symbol_detail` (/mcp/exchange) | Categories & symbols |
| `cex_cfd_query_symbol_kline` (/mcp) / `cex_cfd_query_symbol_ticker` (/mcp) | Market data |
| `cex_cfd_query_mt5_account_info` (/mcp/exchange) / `cex_cfd_query_user_assets` (/mcp/exchange) | MT5 account, assets |
| `cex_cfd_query_transaction` (/mcp/exchange) / `cex_cfd_query_order_list` (/mcp/exchange) / `cex_cfd_query_order_history_list` (/mcp/exchange) | Transactions, orders |
| `cex_cfd_query_position_list` (/mcp/exchange) / `cex_cfd_query_position_history_list` (/mcp/exchange) | Positions |
| `cex_cfd_create_transaction` (/mcp/exchange) | Transfer CFD funds |
| `cex_cfd_create_tradfi_order` (/mcp/exchange) / `cex_cfd_delete_order` (/mcp/exchange) / `cex_cfd_update_order` (/mcp/exchange) | Order management |
| `cex_cfd_close_position` (/mcp/exchange) / `cex_cfd_update_position` (/mcp/exchange) | Position management |

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_cfd_query_order_log` (/mcp/exchange) | Get order details by log ID |
| `cex_cfd_query_symbol_commissions` (/mcp/exchange) | Query symbol commission rates |


## 14. Square

| Tool | Description |
|------|-------------|
| `cex_square_list_square_ai_search` (/mcp) | AI search Gate Square posts |
| `cex_square_list_live_replay` (/mcp) | Search Gate live streams and replays |

## 15. Stock

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_stock_close_stock_position` (/mcp/exchange) | Close position |
| `cex_stock_create_stock_order` (/mcp/exchange) | Create order |
| `cex_stock_create_stock_transaction` (/mcp/exchange) | Fund transfer |
| `cex_stock_delete_all_stock_orders` (/mcp/exchange) | Cancel all open orders |
| `cex_stock_delete_stock_order` (/mcp/exchange) | Cancel order |
| `cex_stock_query_stock_exchanges` (/mcp) | Query supported exchanges |
| `cex_stock_query_stock_fee_rate` (/mcp) | Query fee rates for Japanese and Korean stocks |
| `cex_stock_query_stock_order_book` (/mcp) | Query market order book |
| `cex_stock_query_stock_order_history` (/mcp/exchange) | Query historical order list |
| `cex_stock_query_stock_order_list` (/mcp/exchange) | Query open order list |
| `cex_stock_query_stock_positions` (/mcp/exchange) | Query current position list |
| `cex_stock_query_stock_symbol_detail` (/mcp) | Query symbol details |
| `cex_stock_query_stock_symbols` (/mcp) | Query symbol list |
| `cex_stock_query_stock_transactions` (/mcp/exchange) | Query transaction records |
| `cex_stock_query_stock_user_assets` (/mcp/exchange) | Query user assets |
| `cex_stock_update_stock_order` (/mcp/exchange) | Modify order |


## 16. Multi-collateral loan

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_mcl_create_multi_collateral` (/mcp/exchange) | Place multi-currency collateral order |
| `cex_mcl_get_multi_collateral_current_rate` (/mcp) | Query currency's current interest rate |
| `cex_mcl_get_multi_collateral_fix_rate` (/mcp) | Query currency's 7-day and 30-day fixed interest rates |
| `cex_mcl_get_multi_collateral_ltv` (/mcp) | Query collateralization ratio information |
| `cex_mcl_get_multi_collateral_order_detail` (/mcp/exchange) | Query order details |
| `cex_mcl_list_multi_collateral_currencies` (/mcp) | Query borrow currencies and collateral currencies supported by multi-currency collateral |
| `cex_mcl_list_multi_collateral_orders` (/mcp/exchange) | Query multi-currency collateral order list |
| `cex_mcl_list_multi_collateral_records` (/mcp/exchange) | Query collateral adjustment records |
| `cex_mcl_list_multi_repay_records` (/mcp/exchange) | Query multi-currency collateral repayment records |
| `cex_mcl_list_user_currency_quota` (/mcp/exchange) | Query user's collateral and borrowing currency quota information |
| `cex_mcl_operate_multi_collateral` (/mcp/exchange) | Add or withdraw collateral |
| `cex_mcl_repay_mcl` (/mcp/exchange) | Multi-currency collateral repayment |


## 17. Strategy bots / AIHub

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_bot_get_ai_hub_portfolio_detail` (/mcp/exchange) | Query strategy portfolio details |
| `cex_bot_get_ai_hub_portfolio_running` (/mcp/exchange) | Query running strategy portfolios |
| `cex_bot_get_ai_hub_strategy_recommend` (/mcp/exchange) | Get AIHub strategy recommendations |
| `cex_bot_post_ai_hub_contract_martingale_create` (/mcp/exchange) | Create a futures martingale strategy |
| `cex_bot_post_ai_hub_futures_grid_create` (/mcp/exchange) | Create a contract grid |
| `cex_bot_post_ai_hub_fx_combo_create` (/mcp/exchange) | Create futures-combo bot |
| `cex_bot_post_ai_hub_infinite_grid_create` (/mcp/exchange) | Create infinite grid |
| `cex_bot_post_ai_hub_margin_grid_create` (/mcp/exchange) | Create a margin grid strategy |
| `cex_bot_post_ai_hub_portfolio_stop` (/mcp/exchange) | Stop a running strategy portfolio |
| `cex_bot_post_ai_hub_smart_position_create` (/mcp/exchange) | Create rebalance bot |
| `cex_bot_post_ai_hub_spot_grid_create` (/mcp/exchange) | Create spot grid |
| `cex_bot_post_ai_hub_spot_martingale_create` (/mcp/exchange) | Create a spot martingale strategy |


## 18. Portfolio optimization / AssetSwap

### Additional tools

| Tool (endpoint) | Description |
|---|---|
| `cex_assetswap_create_asset_swap_order_v1` (/mcp/exchange) | Portfolio optimization — place order |
| `cex_assetswap_evaluate_asset_swap` (/mcp/exchange) | Portfolio optimization — valuation |
| `cex_assetswap_get_asset_swap_config` (/mcp/exchange) | Portfolio optimization — configuration |
| `cex_assetswap_get_asset_swap_order_v1` (/mcp/exchange) | Portfolio optimization — query order |
| `cex_assetswap_list_asset_swap_assets` (/mcp/exchange) | Portfolio optimization — currency list |
| `cex_assetswap_list_asset_swap_orders_v1` (/mcp/exchange) | Portfolio optimization — order list |
| `cex_assetswap_preview_asset_swap_order_v1` (/mcp/exchange) | Portfolio optimization — preview |


<a id="authorization"></a>
## Authorization and Tool Visibility

- Private calls require Gate OAuth2. Both `tools/list` filtering and `tools/call` enforce permissions; a complete catalogue is not a guarantee that a token can discover every tool.
- For ordinary matching, `base` includes `read` and `asset`, so it is not a read-only switch. Ordinary tokens retain per-tool OR compatibility with `market`, `profile`, `trade`, `wallet` and `account`; do not globally replace each legacy scope with one new scope.
- `spot_trade`, `futures_trade`, `earn`, `cfd` and `stock` govern their businesses; use the per-tool catalogue. Agentic overrides use `base` for the listed private CFD/stock reads and stock fund transfer, `cfd` for CFD trading writes, and `stock` for stock order writes. Bot creates/stops select spot or futures permissions by `strategy_type`; ordinary OAuth Bot mappings are listed separately. Some creates/stops still use `read OR profile`, so base also matches through read and must not be treated as read-only mode.
- These registered tools are unavailable to Agentic accounts: `cex_wallet_create_sa_to_sa_transfer`, `cex_account_create_stp_group`, `cex_account_add_stp_group_users`, `cex_account_delete_stp_group_users`, `cex_account_get_account_main_keys`. This account-type restriction does not retire those tools for every user.
- Missing or malformed scopes receive no default permission. Expired authorization needs login; missing business permissions need reauthorization. Reauthorization cannot restore retired tools. `mcp:tools` does not replace a business scope.
- For PKCE, use `https://api.gatemcp.ai/mcp/exchange` as the `resource`; do not reuse tokens issued for CLI APIv4 or other resources. Clients should follow `resource_metadata` in the HTTP 401 `WWW-Authenticate` challenge and complete their own authorization flow. Default scope advertisement does not establish the actual application choices in every environment.

<a id="input-contracts"></a>
## Input Contracts and Examples

The same argument name `body` can mean a JSON string or an object in different tools. Follow that tool's schema rather than copying a REST body into MCP arguments. Order and account-setting examples below illustrate shapes, not account eligibility, and must not be executed as read-only verification.

| Tool or scenario | Current contract |
|---|---|
| Spot trigger creation, spot countdown cancellation, cross-margin liquidation | Use JSON-string `body`; do not move its members to the top-level arguments |
| Spot trigger cancel-all `cex_spot_cancel_spot_price_triggered_order_list` | Filters are `market` / `account`; it cancels every matching trigger order. Use `cex_spot_cancel_spot_price_triggered_order` for one order |
| Spot create/amend | `stop_profit` / `stop_loss` are represented as JSON strings in the tool schema; `trade_quote` applies to spot create/cancel-all. Do not assume omitted, null and empty object are equivalent |
| Futures create | Optional fields include `action_mode`, `pid`, `tpsl_sl_bbo_type`, `tpsl_sl_trigger_price`, `tpsl_tp_bbo_type`, `tpsl_tp_trigger_price`; use each cancel/amend schema for applicable `action_mode` |
| Futures batch amend | Put the applicable `order_id` / `text` in each `orders[i]`; top-level fields do not replace item fields |
| `cex_fx_update_fx_price_triggered_order` | Top-level path `order_id` and `order_id` inside JSON-string `body` are forwarded independently; the update body is flat, not the create shape with `initial` / `trigger` |
| CFD/stock object bodies | The nine tools below accept only object `body`, not the old JSON string; required fields, enums, exact integers and ID types follow each tool schema |
| `cex_unified_set_unified_mode` | `settings` is a JSON string; legacy flat switches remain compatible. Explicit settings takes precedence rather than being merged with old switches |
| `cex_earn_list_earn_fixed_term_products` | Optional `status` is int32 and `show_status` is a string; explicit zero/empty string is forwarded, omission preserves backend defaults |
| `cex_earn_get_auto_invest_min_amount` | JSON-string `body_json` requires `asset_type`: 1=cryptocurrency, 2=TradFi stock, as well as `money` / `items` |
| Alpha currency | Use the Alpha currency ID, not the display symbol. First paginate `cex_alpha_list_alpha_currencies` without currency, match by name/chain/address and use the returned currency |
| Futures positions and ledger | Omitting limit in `cex_fx_list_fx_positions` queries current positions; provided limit must be 1—100. Use the current schema for ledger type descriptions |

These nine tools use object `body`:

- `cex_cfd_close_position`
- `cex_cfd_create_tradfi_order`
- `cex_cfd_create_transaction`
- `cex_cfd_update_order`
- `cex_cfd_update_position`
- `cex_stock_close_stock_position`
- `cex_stock_create_stock_order`
- `cex_stock_create_stock_transaction`
- `cex_stock_update_stock_order`

### Spot trigger order: JSON-string body

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "cex_spot_create_spot_price_triggered_order",
    "arguments": {
      "body": "{\"market\":\"BTC_USDT\",\"trigger\":{\"price\":\"10000\",\"rule\":\">=\",\"expiration\":3600},\"put\":{\"type\":\"limit\",\"side\":\"buy\",\"price\":\"9900\",\"amount\":\"0.001\",\"account\":\"normal\",\"time_in_force\":\"gtc\"}}"
    }
  }
}
```

### CFD order: object body

```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "method": "tools/call",
  "params": {
    "name": "cex_cfd_create_tradfi_order",
    "arguments": {
      "body": {
        "price": "0.9",
        "price_type": "trigger",
        "side": 2,
        "symbol": "EURUSD",
        "volume": "10"
      }
    }
  }
}
```

### Stock order: object body

```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "method": "tools/call",
  "params": {
    "name": "cex_stock_create_stock_order",
    "arguments": {
      "body": {
        "volume": "10",
        "symbol": "AAPL",
        "side": 2,
        "price_type": "limit",
        "trading_session": "all",
        "time_in_force": "day",
        "price": "200.12",
        "client_order_id": "documentation-example"
      }
    }
  }
}
```

### Unified settings: JSON-string settings

```json
{
  "jsonrpc": "2.0",
  "id": 4,
  "method": "tools/call",
  "params": {
    "name": "cex_unified_set_unified_mode",
    "arguments": {
      "mode": "portfolio",
      "settings": "{\"spot_hedge\":true}"
    }
  }
}
```

### Minimum auto investment: JSON-string body_json

```json
{
  "jsonrpc": "2.0",
  "id": 5,
  "method": "tools/call",
  "params": {
    "name": "cex_earn_get_auto_invest_min_amount",
    "arguments": {
      "body_json": "{\"money\":\"USDT\",\"asset_type\":1,\"items\":[{\"asset\":\"BTC\",\"ratio\":\"100\"}]}"
    }
  }
}
```

<a id="trail-contracts"></a>
## Trail Requests and Responses

`cex_fx_create_trail_order` uses `settle` and JSON-string `body`. The body must explicitly provide integer `price_type`: 1=latest, 2=index, 3=mark; there is no default.

| Tool | Response data location |
|---|---|
| `cex_fx_get_trail_orders` | `data.orders` |
| `cex_fx_update_trail_order` / `cex_fx_stop_trail_order` | `data.order` |
| `cex_fx_get_trail_order_change_log` | `data.change_log`; omitted page_num requests page one |

The outer `code`, `message` and `timestamp` are preserved. Order `id`, `user_id`, `user`, `suborder_id`, `created_at`, `activated_at`, `finished_at`, `create_time`, `active_time`, `finish_time` and `updated_at` are strings; log updated_at is a string, while outer timestamp remains an integer. Text JSON and `structuredContent` retain these shapes. Update, stop and change-log operations return `isError: true` for nonzero business codes.

<a id="errors"></a>
## Errors, Precision and Result Queries

- Distinguish JSON-RPC `error`, tool `isError` and backend business `code`. HTTP 200 alone does not establish business success; do not assume one success code or envelope for every tool.
- Public backend errors may include `code`, `label`, `message`, `detail`, `error`, `errors`, `trace_id`. Keep the returned fields distinct rather than concatenating detail into a new message.
- A write timeout, cancellation or rejected redirect can leave the outcome unknown. Query the original order, transaction or strategy before deciding to submit again. A task ID does not prove execution or final fund settlement.
- Non-flat JSON-string `body` / `body_json` inputs are limited to 10 MiB (10,485,760 bytes); the nine CFD/stock tools check the same limit after serializing object bodies. This is not a universal HTTP-request or batch-size limit.
- Preserve schema-defined string precision for amounts and quantities. Handle IDs and timestamps field by field rather than converting every ID/time to one type. Pagination, time ranges and batch sizes are tool-specific; a page_size argument alone is not evidence that every backend's pagination has been verified.

<a id="cfd-stock-fields"></a>
## CFD / Stock Object Body Fields

The following are request fields for the nine object-body tools. Optional in the schema does not remove conditional requirements, such as close_volume for partial close. Top-level MCP order_id/position_id use exact int64 ID strings; placing them inside body does not replace path arguments.

### `cex_cfd_close_position`

Required top-level path arguments: `position_id`

| Body field | Type | Required | Enum | Description |
|---|---|---|---|---|
| `close_type` | integer | Yes | `1`, `2` | Close Type Description: - 1: Partial Close (close_volume is required) - 2: Full Close (close_volume is not required) |
| `close_volume` | string / null | No | — | Close Volume Description: - Required when close_type = 1 - Ignored when close_type = 2 |

Response: Optional empty `data` may be omitted by the SDK. Outer timestamp is int64.

### `cex_cfd_create_tradfi_order`

| Body field | Type | Required | Enum | Description |
|---|---|---|---|---|
| `price` | string | Yes | — | Order price |
| `price_type` | string | Yes | `"trigger"`, `"market"` | Price type (trigger=trigger price, market=market price) |
| `side` | integer | Yes | `1`, `2` | Side (1=sell, 2=buy) |
| `symbol` | string | Yes | — | Base trading symbol code |
| `volume` | string | Yes | — | Order quantity |
| `price_tp` | string | No | — | Take profit price (optional) |
| `price_sl` | string | No | — | Stop loss price (optional) |
| `leverage` | integer | No | — | Leverage multiplier (must be one of the leverage multipliers allowed for the symbol in the trading symbol details response) |

Response: `data.id` is a string queue task ID, not an order ID. Outer timestamp is int64.

### `cex_cfd_create_transaction`

| Body field | Type | Required | Enum | Description |
|---|---|---|---|---|
| `asset` | string | Yes | — | Asset type, e.g., USDT, currently only USDT is supported |
| `change` | string | Yes | — | Change Quantity, supports up to two decimal places |
| `type` | string | Yes | `"deposit"`, `"withdraw"` | Transaction Type (deposit - transfer in, withdraw - transfer out) |

Response: Optional empty `data` may be omitted by the SDK. Outer timestamp is int64.

### `cex_cfd_update_order`

Required top-level path arguments: `order_id`

| Body field | Type | Required | Enum | Description |
|---|---|---|---|---|
| `price` | string | Yes | — | Price Description: - Required |
| `price_tp` | string / null | No | — | Take Profit Price Description: - If not provided or set to "0": The original take profit price will be cleared - If you do not want to clear it, pass the original take profit price returned by the interface |
| `price_sl` | string / null | No | — | Stop Loss Price Description: - If not provided or set to "0": The original stop loss price will be cleared - If you do not want to clear it, pass the original stop loss price returned by the interface |

Response: `data.order_id` is int64; data also contains symbol, state, volume, price, price_tp and price_sl. Outer timestamp is int64.

### `cex_cfd_update_position`

Required top-level path arguments: `position_id`

| Body field | Type | Required | Enum | Description |
|---|---|---|---|---|
| `price_tp` | string / null | No | — | Take Profit Price Description: - If not provided or set to "0": The original take profit price will be cleared - If you do not want to clear it, pass the original take profit price returned by the interface |
| `price_sl` | string / null | No | — | Stop Loss Price Description: - If not provided or set to "0": The original stop loss price will be cleared - If you do not want to clear it, pass the original stop loss price returned by the interface |

Response: Optional empty `data` may be omitted by the SDK. Outer timestamp is int64.

### `cex_stock_close_stock_position`

| Body field | Type | Required | Enum | Description |
|---|---|---|---|---|
| `symbol` | string | Yes | — | Symbol |
| `close_volume` | string | No | — | Close quantity; required for partial close |
| `close_type` | integer | Yes | `1`, `2` | Close type (1=partial close, 2=close all) |

Response: `data.order_id` is an int64 order ID. Outer timestamp is int64.

### `cex_stock_create_stock_order`

| Body field | Type | Required | Enum | Description |
|---|---|---|---|---|
| `volume` | string | Yes | — | Order quantity |
| `symbol` | string | Yes | — | Symbol |
| `side` | integer | Yes | `1`, `2` | Side (1=sell, 2=buy) |
| `price_type` | string | Yes | `"market"`, `"limit"` | Price type (market = market order, limit = limit order) |
| `trading_session` | string | Yes | `"regular"`, `"all"` | Trading session. Limit orders support only all, while market orders support only regular. |
| `time_in_force` | string | Yes | `"day"` | Time in force. - day: Day order. |
| `price` | string | No | — | Order price, used for limit orders |
| `client_order_id` | string | No | — | Client-defined order ID |

Response: `data.id` is a string order ID. Outer timestamp is int64.

### `cex_stock_create_stock_transaction`

| Body field | Type | Required | Enum | Description |
|---|---|---|---|---|
| `asset` | string | Yes | `"USDT"` | Asset, USDT only |
| `change` | string | Yes | — | Change amount, must be greater than 0 |
| `type` | string | Yes | `"deposit"`, `"withdraw"` | Transaction type. deposit transfers funds from the spot account to the stock account; withdraw transfers funds from the stock account to the spot account. |
| `ref_id` | string | Yes | — | Business idempotent ID |

Response: Optional empty `data` may be omitted by the SDK. Outer timestamp is int64.

### `cex_stock_update_stock_order`

Required top-level path arguments: `order_id`

| Body field | Type | Required | Enum | Description |
|---|---|---|---|---|
| `volume` | string | Yes | — | Modified order quantity |
| `price` | string | Yes | — | Modified order price |

Response: `data.order_id` is an int64 order ID. Outer timestamp is int64.
