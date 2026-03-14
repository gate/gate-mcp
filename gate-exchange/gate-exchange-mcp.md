# Gate Exchange MCP Tools

> This document describes the tools available on the **private endpoint** (`/mcp/exchange`, OAuth2 required).
> For public market data tools (no auth), see the [Public MCP section in README](../README.md#public-mcp-mcp--no-auth).
>
> **OAuth2 Scopes**: `market`, `profile`, `trade`, `wallet`, `account`

All tools use the `cex_` prefix. The endpoint exposes 300+ tools across spot, futures, margin, options, delivery, wallet, unified account, sub-account, earn, flash swap, rebate, TradFi, CrossEx, OTC, P2P, and Alpha.

> **api.gatemcp.ai**：工具列表见 [gateapi-mcp-service-tools.md](gateapi-mcp-service-tools.md)。**gate-local-mcp**：工具列表见 [gate-local-mcp-tools.md](gate-local-mcp-tools.md)。

## 1. Spot Trading (scope: profile / trade)

### 1.1 Account Queries

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_spot_get_spot_accounts` | Get spot account balances | `currency` (optional, returns all if omitted) |
| `cex_spot_list_spot_account_book` | Get spot account ledger records | `currency`, `limit`, `page`, `from`, `to`, `type`, `code` |
| `cex_spot_get_spot_fee` | Get trading fee rate | `currency_pair` |
| `cex_spot_get_spot_batch_fee` | Get trading fee rates in batch | `currency_pairs` (required, up to 50 pairs) |
| `cex_spot_list_all_open_orders` | List all open orders across pairs | - |
| `cex_spot_get_spot_price_triggered_order` | Get price-triggered order | `order_id` |
| `cex_spot_list_spot_price_triggered_orders` | List price-triggered orders | `status`, `page`, `limit` |
| `cex_spot_get_spot_insurance_history` | Get insurance fund history | `currency_pair`, `limit` |

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
| `cex_spot_create_spot_price_triggered_order` | Create price-triggered order | `market`, `trigger`, `put`, `options` |
| `cex_spot_cancel_spot_price_triggered_order` | Cancel price-triggered order | `order_id` |
| `cex_spot_cancel_spot_price_triggered_order_list` | Cancel price-triggered orders in batch | `order_ids` |
| `cex_spot_countdown_cancel_all_spot` | Countdown cancel all spot orders | `timeout`, `currency_pair`, `market` |
| `cex_spot_create_cross_liquidate_order` | Create cross-margin liquidation order | `currency_pair`, `side`, `amount`, `price` |

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

### 2.6 Additional Futures Tools

| Tool | Description |
|------|-------------|
| `cex_fx_get_fx_orders_with_time_range` | Query orders by time range |
| `cex_fx_get_fx_leverage` | Get leverage setting |
| `cex_fx_list_fx_position_close` | List position close records |
| `cex_fx_list_fx_auto_deleverages` | List auto deleverage records |
| `cex_fx_list_fx_price_triggered_orders` / `cex_fx_get_fx_price_triggered_order` | Price-triggered orders |
| `cex_fx_get_fx_trail_orders` / `cex_fx_get_fx_trail_order_detail` / `cex_fx_get_fx_trail_order_change_log` | Trail orders |
| `cex_fx_create_fx_bbo_order` | Create BBO (best bid/offer) order |
| `cex_fx_create_fx_price_triggered_order` / `cex_fx_cancel_fx_price_triggered_order` / `cex_fx_cancel_fx_price_triggered_order_list` / `cex_fx_update_fx_price_triggered_order` | Price-triggered order management |
| `cex_fx_countdown_cancel_all_fx` | Countdown cancel all futures orders |
| `cex_fx_create_fx_trail_order` / `cex_fx_update_fx_trail_order` / `cex_fx_stop_fx_trail_order` / `cex_fx_stop_all_fx_trail_orders` | Trail order management |

## 3. Margin (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_margin_list_margin_accounts` / `cex_margin_list_margin_account_book` | Margin account & ledger |
| `cex_margin_list_funding_accounts` / `cex_margin_get_auto_repay_status` | Funding account, auto repay |
| `cex_margin_get_margin_transferable` / `cex_margin_get_user_margin_tier` | Transferable, tier |
| `cex_margin_list_uni_loans` / `cex_margin_list_uni_loan_records` / `cex_margin_list_uni_loan_interest_records` | Uni loans |
| `cex_margin_get_uni_borrowable` / `cex_margin_list_cross_margin_loans` / `cex_margin_list_cross_margin_repayments` | Borrowable, cross margin |
| `cex_margin_set_auto_repay` / `cex_margin_set_user_market_leverage` | Auto repay, leverage |
| `cex_margin_create_uni_loan` | Create uni loan |

## 4. Options (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_options_list_my_options_settlements` / `cex_options_list_options_account` / `cex_options_list_options_account_book` | Account & settlements |
| `cex_options_list_options_positions` / `cex_options_get_options_position` / `cex_options_list_options_position_close` | Positions |
| `cex_options_list_options_orders` / `cex_options_get_options_order` / `cex_options_list_my_options_trades` | Orders & trades |
| `cex_options_get_options_mmp` | MMP (Market Maker Protection) |
| `cex_options_create_options_order` / `cex_options_cancel_options_orders` / `cex_options_cancel_options_order` | Order management |
| `cex_options_countdown_cancel_all_options` / `cex_options_set_options_mmp` / `cex_options_reset_options_mmp` | Countdown, MMP |

## 5. Delivery (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_dt_list_dt_accounts` / `cex_dt_list_dt_account_book` | Account & ledger |
| `cex_dt_list_dt_positions` / `cex_dt_get_dt_position` | Positions |
| `cex_dt_list_dt_orders` / `cex_dt_get_dt_order` | Orders |
| `cex_dt_get_my_dt_trades` / `cex_dt_list_dt_position_close` / `cex_dt_list_dt_liquidates` / `cex_dt_list_dt_settlements` | Trades, settlements |
| `cex_dt_list_price_triggered_dt_orders` / `cex_dt_get_price_triggered_dt_order` | Price-triggered orders |
| `cex_dt_update_dt_position_margin` / `cex_dt_update_dt_position_leverage` / `cex_dt_update_dt_position_risk_limit` | Position settings |
| `cex_dt_create_dt_order` / `cex_dt_cancel_dt_orders` / `cex_dt_cancel_dt_order` | Order management |
| `cex_dt_create_price_triggered_dt_order` / `cex_dt_cancel_price_triggered_dt_order` / `cex_dt_cancel_price_triggered_dt_order_list` | Price-triggered order management |

## 6. Unified Account (scope: account)

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_unified_get_unified_accounts` | Get unified account information | `currency`, `sub_uid` |
| `cex_unified_get_unified_mode` | Get unified account mode | - |
| `cex_unified_set_unified_mode` | Set unified account mode | `mode` (required), `usdt_futures`, `spot_hedge`, `use_funding`, `options` |
| `cex_unified_get_unified_borrowable` | Get borrowable amount | `currency` (required) |
| `cex_unified_get_unified_risk_units` | Get risk units | - |
| `cex_unified_list_unified_loans` | Get unified account loan records | `currency`, `limit`, `page`, `type` |
| `cex_unified_calculate_portfolio_margin` / `cex_unified_create_unified_loan` | Portfolio margin, create loan |
| `cex_unified_get_history_loan_rate` / `cex_unified_get_unified_borrowable_list` / `cex_unified_get_unified_estimate_rate` | Loan rate, borrowable list |
| `cex_unified_get_unified_transferable` / `cex_unified_get_unified_transferables` | Transferable amounts |
| `cex_unified_get_user_leverage_currency_config` / `cex_unified_set_user_leverage_currency_setting` | Leverage config |
| `cex_unified_list_currency_discount_tiers` / `cex_unified_list_loan_margin_tiers` | Discount tiers |
| `cex_unified_list_unified_currencies` / `cex_unified_list_unified_loan_interest_records` / `cex_unified_list_unified_loan_records` | Currencies, loan records |
| `cex_unified_set_unified_collateral` | Set collateral |

## 7. Wallet & Transfer (scope: wallet)

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
| `cex_wallet_get_deposit_address` / `cex_wallet_list_currency_chains` | Deposit address, chains |
| `cex_wallet_list_sa_balances` / `cex_wallet_list_sa_cross_margin_balances` / `cex_wallet_list_sa_futures_balances` / `cex_wallet_list_sa_margin_balances` / `cex_wallet_list_sa_transfers` | Sub-account balances & transfers |
| `cex_wallet_list_small_balance` / `cex_wallet_list_small_balance_history` / `cex_wallet_convert_small_balance` | Small balance convert |

## 8. Sub Account (scope: account)

### 8.1 Sub Account Management

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_sa_create_sa` | Create a sub account | `login_name` (required), `password`, `email`, `remark` |
| `cex_sa_get_sa` | Get sub account information | `user_id` (required) |
| `cex_sa_list_sas` | List sub accounts | `type` |
| `cex_sa_lock_sa` | Lock a sub account | `user_id` (required) |
| `cex_sa_unlock_sa` | Unlock a sub account | `user_id` (required) |
| `cex_sa_get_sa_unified_mode` | Get sub account unified mode | - |

### 8.2 Sub Account API Key

| Tool | Description | Main Parameters |
|---|---|---|
| `cex_sa_create_sa_key` | Create sub account API key | `user_id` (required), `mode`, `name`, `perms` (JSON array), `ip_whitelist` |
| `cex_sa_get_sa_key` | Get sub account API key | `user_id` (required), `key` (required) |
| `cex_sa_list_sa_keys` | List sub account API keys | `user_id` (required) |
| `cex_sa_update_sa_key` | Update sub account API key | `user_id` (required), `key` (required), `mode`, `name`, `perms` (JSON array), `ip_whitelist` |
| `cex_sa_delete_sa_key` | Delete sub account API key | `user_id` (required), `key` (required) |

## 9. Account Management (scope: account)

| Tool | Description |
|------|-------------|
| `cex_account_get_account_detail` | Get account detail |
| `cex_account_get_account_main_keys` | Get main API keys |
| `cex_account_get_account_rate_limit` | Get rate limit |
| `cex_account_get_debit_fee` / `cex_account_set_debit_fee` | Debit fee |
| `cex_account_list_stp_groups` / `cex_account_list_stp_groups_users` | STP groups |
| `cex_account_create_stp_group` | Create STP group |
| `cex_account_add_stp_group_users` / `cex_account_delete_stp_group_users` | Manage STP users |

## 10. Rebate (scope: profile)

| Tool | Description |
|------|-------------|
| `cex_rebate_agency_commissions_history` / `cex_rebate_agency_transaction_history` | Agency rebate |
| `cex_rebate_partner_commissions_history` / `cex_rebate_partner_sub_list` / `cex_rebate_partner_transaction_history` | Partner rebate |
| `cex_rebate_rebate_broker_commission_history` / `cex_rebate_rebate_broker_transaction_history` | Broker rebate |
| `cex_rebate_rebate_user_info` / `cex_rebate_user_sub_relation` | User rebate info |

## 11. Flash Swap (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_fc_list_fc_currency_pairs` | List flash swap currency pairs |
| `cex_fc_list_fc_orders` / `cex_fc_get_fc_order` | Query orders |
| `cex_fc_create_fc_order` | Create flash swap order |
| `cex_fc_preview_fc_order` | Preview flash swap |

## 12. Earn (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_earn_asset_list` / `cex_earn_award_list` | Assets, awards |
| `cex_earn_list_dual_balance` / `cex_earn_list_dual_orders` | Dual investment |
| `cex_earn_list_structured_orders` / `cex_earn_order_list` | Structured products |
| `cex_earn_get_uni_currency` / `cex_earn_get_uni_interest` / `cex_earn_get_uni_interest_status` | Uni earn |
| `cex_earn_list_uni_chart` / `cex_earn_list_uni_interest_records` / `cex_earn_list_uni_lend_records` | Uni records |
| `cex_earn_place_structured_order` / `cex_earn_swap_eth2` / `cex_earn_change_uni_lend` | Trading actions |

## 13. Alpha (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_alpha_list_alpha_accounts` / `cex_alpha_list_alpha_account_book` | Alpha account |
| `cex_alpha_list_alpha_orders` / `cex_alpha_get_alpha_order` | Alpha orders |
| `cex_alpha_quote_alpha_order` / `cex_alpha_place_alpha_order` | Quote & place |

## 14. TradFi (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_tradfi_query_categories` / `cex_tradfi_query_symbols` / `cex_tradfi_query_symbol_detail` | Categories & symbols |
| `cex_tradfi_query_symbol_kline` / `cex_tradfi_query_symbol_ticker` | Market data |
| `cex_tradfi_query_mt5_account_info` / `cex_tradfi_query_user_assets` | MT5 account, assets |
| `cex_tradfi_query_transaction` / `cex_tradfi_query_order_list` / `cex_tradfi_query_order_history_list` | Transactions, orders |
| `cex_tradfi_query_position_list` / `cex_tradfi_query_position_history_list` | Positions |
| `cex_tradfi_create_trad_fi_user` / `cex_tradfi_create_transaction` | Create user, transaction |
| `cex_tradfi_create_trad_fi_order` / `cex_tradfi_delete_order` / `cex_tradfi_update_order` | Order management |
| `cex_tradfi_close_position` / `cex_tradfi_update_position` | Position management |

## 15. CrossEx (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_crx_list_crx_rule_symbols` / `cex_crx_list_crx_rule_risk_limits` | Rule symbols, risk limits |
| `cex_crx_list_crx_transfer_coins` / `cex_crx_list_crx_transfers` | Transfer coins, transfers |
| `cex_crx_get_crx_account` / `cex_crx_get_crx_fee` / `cex_crx_get_crx_interest_rate` | Account, fee, interest |
| `cex_crx_list_crx_positions` / `cex_crx_list_crx_margin_positions` | Positions |
| `cex_crx_list_crx_open_orders` / `cex_crx_get_crx_order` | Orders |
| `cex_crx_create_crx_transfer` / `cex_crx_create_crx_order` / `cex_crx_cancel_crx_order` / `cex_crx_update_crx_order` | Transfers, orders |
| `cex_crx_close_crx_position` / `cex_crx_create_crx_convert_quote` / `cex_crx_create_crx_convert_order` | Close, convert |
| `cex_crx_update_crx_account` / `cex_crx_update_crx_positions_leverage` / `cex_crx_update_crx_margin_positions_leverage` | Update account, leverage |

## 16. OTC (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_otc_get_bank_list` / `cex_otc_get_user_default_bank` | Bank list |
| `cex_otc_get_otc_order_detail` / `cex_otc_list_otc_orders` / `cex_otc_list_stable_coin_orders` | OTC orders |
| `cex_otc_create_otc_quote` / `cex_otc_create_otc_order` / `cex_otc_cancel_otc_order` | OTC quote, order |
| `cex_otc_mark_otc_order_paid` / `cex_otc_create_stable_coin_order` | Mark paid, stable coin |

## 17. P2P (scope: profile / trade)

| Tool | Description |
|------|-------------|
| `cex_p2p_get_user_info` / `cex_p2p_get_counterparty_user_info` / `cex_p2p_get_myself_payment` | User info |
| `cex_p2p_ads_detail` / `cex_p2p_ads_list` / `cex_p2p_my_ads_list` | Ads |
| `cex_p2p_get_chats_list` | Chats |
| `cex_p2p_get_completed_transaction_list` / `cex_p2p_get_pending_transaction_list` / `cex_p2p_get_transaction_details` | Transactions |
| `cex_p2p_ads_update_status` / `cex_p2p_place_biz_push_order` | Ads, push order |
| `cex_p2p_send_chat_message` / `cex_p2p_upload_chat_file` | Chat |
| `cex_p2p_transaction_cancel` / `cex_p2p_transaction_confirm_payment` / `cex_p2p_transaction_confirm_receipt` | Transaction actions |
