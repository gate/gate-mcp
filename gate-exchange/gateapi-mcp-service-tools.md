# Remote CEX MCP Full Tool Catalogue

[English](gateapi-mcp-service-tools.md) | [中文](gateapi-mcp-service-tools_zh.md)

Inventory reference: service version `v1.16.7`, checked on 2026-11-04. **393 names: 83 public and 310 private**. The public name set was checked against the live directory on that date. The private count is the implementation's registration ceiling; token permissions, account type and operational policies determine the visible and callable subset.

This catalogue covers remote `api.gatemcp.ai`, not the separate gate-local-mcp npm package. Use the connected endpoint's `tools/list` for parameters, required fields and enums; see the [usage and parameter reference](gate-exchange-mcp.md).

Public tools need no OAuth. Ordinary scopes in the private table match with OR. For ordinary matching, `base` includes `read` and `asset` and does not mean read-only. The Agentic override takes precedence for that account type; only “Same as ordinary mapping” uses the ordinary column. Gate authorization supplies scopes; tool arguments cannot set them. Missing or malformed scopes do not receive default permission.

Bot `strategy_type` is inside the JSON-string `body`: spot strategies are `spot_grid`, `margin_grid`, `infinite_grid`, `spot_martingale` and `smart_position`; futures strategies are `futures_grid`, `contract_martingale` and `futures_combo`. Creates must match the selected creation tool; stop permission follows the strategy type. `mcp:tools` does not replace a business scope.

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

## Spot

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_spot_amend_spot_batch_orders` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_amend_spot_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_cancel_all_spot_orders` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_cancel_spot_batch_orders` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_cancel_spot_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_cancel_spot_pov_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_cancel_spot_pov_orders` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_cancel_spot_price_triggered_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_cancel_spot_price_triggered_order_list` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_countdown_cancel_all_spot` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_create_cross_liquidate_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_create_spot_batch_orders` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_create_spot_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_create_spot_pov_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_create_spot_price_triggered_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_spot_get_currency` | `/mcp` | — | — |
| `cex_spot_get_currency_pair` | `/mcp` | — | — |
| `cex_spot_get_spot_accounts` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_get_spot_batch_fee` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_get_spot_candlesticks` | `/mcp` | — | — |
| `cex_spot_get_spot_fee` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_get_spot_insurance_history` | `/mcp` | — | — |
| `cex_spot_get_spot_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_get_spot_order_book` | `/mcp` | — | — |
| `cex_spot_get_spot_pov_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_get_spot_price_triggered_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_get_spot_tickers` | `/mcp` | — | — |
| `cex_spot_get_spot_trades` | `/mcp` | — | — |
| `cex_spot_list_all_open_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_list_currencies` | `/mcp` | — | — |
| `cex_spot_list_currency_pairs` | `/mcp` | — | — |
| `cex_spot_list_spot_account_book` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_list_spot_my_trades` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_list_spot_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_list_spot_pov_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_list_spot_price_triggered_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_spot_list_spot_rpi_order_book` | `/mcp` | — | — |

## Futures

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_fx_amend_fx_batch_orders` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_amend_fx_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_cancel_all_fx_orders` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_cancel_fx_batch_orders` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_cancel_fx_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_cancel_fx_price_triggered_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_cancel_fx_price_triggered_order_list` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_countdown_cancel_all_fx` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_create_chase_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_create_fx_batch_orders` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_create_fx_bbo_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_create_fx_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_create_fx_price_triggered_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_create_trail_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_get_chase_order_detail` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_chase_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_fx_accounts` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_fx_candlesticks` | `/mcp` | — | — |
| `cex_fx_get_fx_contract` | `/mcp` | — | — |
| `cex_fx_get_fx_dual_position` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_fx_fee` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_fx_funding_rate` | `/mcp` | — | — |
| `cex_fx_get_fx_my_trades_timerange` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_fx_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_fx_order_book` | `/mcp` | — | — |
| `cex_fx_get_fx_orders_with_time_range` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_fx_position` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_fx_premium_index` | `/mcp` | — | — |
| `cex_fx_get_fx_price_triggered_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_fx_risk_limit_table` | `/mcp` | — | — |
| `cex_fx_get_fx_tickers` | `/mcp` | — | — |
| `cex_fx_get_fx_trades` | `/mcp` | — | — |
| `cex_fx_get_index_constituents` | `/mcp` | — | — |
| `cex_fx_get_leverage` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_trail_order_change_log` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_trail_order_detail` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_get_trail_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_list_auto_deleverages` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_list_batch_fx_funding_rates` | `/mcp` | — | — |
| `cex_fx_list_contract_stats` | `/mcp` | — | — |
| `cex_fx_list_fx_account_book` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_list_fx_adl_risk_states` | `/mcp` | — | — |
| `cex_fx_list_fx_contracts` | `/mcp` | — | — |
| `cex_fx_list_fx_contracts_all` | `/mcp` | — | — |
| `cex_fx_list_fx_insurance_ledger` | `/mcp` | — | — |
| `cex_fx_list_fx_liq_orders` | `/mcp` | — | — |
| `cex_fx_list_fx_my_trades` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_list_fx_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_list_fx_positions` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_list_fx_risk_limit_tiers` | `/mcp` | — | — |
| `cex_fx_list_fx_rpi_order_book` | `/mcp` | — | — |
| `cex_fx_list_liquidated_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_list_position_close` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_list_positions_timerange` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_list_price_triggered_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fx_set_fx_dual` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_set_position_mode` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_stop_all_chase_orders` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_stop_all_trail_orders` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_stop_chase_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_stop_trail_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_contract_position_leverage` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_dual_position_cross_mode` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_dual_position_leverage` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_dual_position_margin` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_dual_position_risk_limit` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_position_cross_mode` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_position_leverage` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_position_margin` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_position_risk_limit` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_fx_price_triggered_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_fx_update_trail_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |

## Margin

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_margin_create_uni_loan` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_margin_get_auto_repay_status` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_get_margin_transferable` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_get_margin_uni_estimate_rate` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_get_market_margin_tier` | `/mcp` | — | — |
| `cex_margin_get_uni_borrowable` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_get_uni_currency_pair` | `/mcp` | — | — |
| `cex_margin_get_user_margin_tier` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_list_cross_margin_loans` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_list_cross_margin_repayments` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_list_funding_accounts` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_list_margin_account_book` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_list_margin_accounts` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_list_margin_user_account` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_list_uni_currency_pairs` | `/mcp` | — | — |
| `cex_margin_list_uni_loan_interest_records` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_list_uni_loan_records` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_list_uni_loans` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_margin_set_auto_repay` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_margin_set_user_market_leverage` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |

## Options

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_options_amend_options_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_options_cancel_options_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_options_cancel_options_orders` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_options_countdown_cancel_all_options` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_options_create_options_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_options_get_options_contract` | `/mcp` | — | — |
| `cex_options_get_options_mmp` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_get_options_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_get_options_position` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_get_options_settlement` | `/mcp` | — | — |
| `cex_options_list_my_options_settlements` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_list_my_options_trades` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_list_options_account` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_list_options_account_book` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_list_options_candlesticks` | `/mcp` | — | — |
| `cex_options_list_options_contracts` | `/mcp` | — | — |
| `cex_options_list_options_expirations` | `/mcp` | — | — |
| `cex_options_list_options_order_book` | `/mcp` | — | — |
| `cex_options_list_options_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_list_options_position_close` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_list_options_positions` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_options_list_options_settlements` | `/mcp` | — | — |
| `cex_options_list_options_tickers` | `/mcp` | — | — |
| `cex_options_list_options_trades` | `/mcp` | — | — |
| `cex_options_list_options_underlying_candlesticks` | `/mcp` | — | — |
| `cex_options_list_options_underlying_tickers` | `/mcp` | — | — |
| `cex_options_list_options_underlyings` | `/mcp` | — | — |
| `cex_options_reset_options_mmp` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_options_set_options_mmp` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |

## Delivery

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_dc_cancel_dc_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_dc_cancel_dc_orders` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_dc_cancel_price_triggered_dc_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_dc_cancel_price_triggered_dc_order_list` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_dc_create_dc_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_dc_create_price_triggered_dc_order` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_dc_get_dc_contract` | `/mcp` | — | — |
| `cex_dc_get_dc_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_get_dc_position` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_get_my_dc_trades` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_get_price_triggered_dc_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_list_dc_account_book` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_list_dc_accounts` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_list_dc_candlesticks` | `/mcp` | — | — |
| `cex_dc_list_dc_contracts` | `/mcp` | — | — |
| `cex_dc_list_dc_insurance_ledger` | `/mcp` | — | — |
| `cex_dc_list_dc_liquidates` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_list_dc_order_book` | `/mcp` | — | — |
| `cex_dc_list_dc_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_list_dc_position_close` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_list_dc_positions` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_list_dc_risk_limit_tiers` | `/mcp` | — | — |
| `cex_dc_list_dc_settlements` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_list_dc_tickers` | `/mcp` | — | — |
| `cex_dc_list_dc_trades` | `/mcp` | — | — |
| `cex_dc_list_price_triggered_dc_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_dc_update_dc_position_leverage` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_dc_update_dc_position_margin` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |
| `cex_dc_update_dc_position_risk_limit` | `/mcp/exchange` | `futures_trade` OR `trade` | `futures_trade` |

## Wallet

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_wallet_convert_small_balance` | `/mcp/exchange` | `asset` OR `wallet` | `spot_trade` |
| `cex_wallet_create_sa_to_sa_transfer` | `/mcp/exchange` | `asset` OR `wallet` | Unavailable to Agentic accounts |
| `cex_wallet_create_sa_transfer` | `/mcp/exchange` | `asset` OR `wallet` | `base` |
| `cex_wallet_create_transfer` | `/mcp/exchange` | `asset` OR `wallet` | `base` |
| `cex_wallet_get_deposit_address` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_get_low_cap_exchange_list` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_get_total_balance` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_get_transfer` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_wallet_get_transfer_order_status` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_get_wallet_fee` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_currency_chains` | `/mcp` | — | — |
| `cex_wallet_list_deposits` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_push_orders` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_sa_balances` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_sa_cross_margin_balances` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_sa_fx_balances` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_sa_margin_balances` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_sa_transfers` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_saved_address` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_small_balance` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_small_balance_history` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_withdraw_status` | `/mcp/exchange` | `read` OR `wallet` | `base` |
| `cex_wallet_list_withdrawals` | `/mcp/exchange` | `read` OR `wallet` | `base` |

## Unified account

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_unified_calculate_portfolio_margin` | `/mcp` | — | — |
| `cex_unified_create_quick_repayment` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_unified_create_unified_loan` | `/mcp/exchange` | `earn` OR `account` | `earn` |
| `cex_unified_get_estimated_quick_repayment` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_unified_get_history_loan_rate` | `/mcp` | — | — |
| `cex_unified_get_unified_accounts` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_get_unified_borrowable` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_get_unified_borrowable_list` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_get_unified_delta_neutral` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_unified_get_unified_estimate_rate` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_get_unified_mode` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_get_unified_risk_units` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_get_unified_transferable` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_get_unified_transferables` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_get_user_leverage_currency_config` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_get_user_leverage_currency_setting` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_list_currency_discount_tiers` | `/mcp` | — | — |
| `cex_unified_list_loan_margin_tiers` | `/mcp` | — | — |
| `cex_unified_list_unified_currencies` | `/mcp` | — | — |
| `cex_unified_list_unified_loan_interest_records` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_list_unified_loan_records` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_list_unified_loans` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_unified_set_unified_collateral` | `/mcp/exchange` | `asset` OR `account` | `base` |
| `cex_unified_set_unified_delta_neutral` | `/mcp/exchange` | `asset` OR `trade` | `base` |
| `cex_unified_set_unified_mode` | `/mcp/exchange` | `asset` OR `account` | `base` |
| `cex_unified_set_user_leverage` | `/mcp/exchange` | `asset` OR `trade` | `base` |
| `cex_unified_set_user_leverage_currency_setting` | `/mcp/exchange` | `asset` OR `account` | `base` |

## Account management

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_account_add_stp_group_users` | `/mcp/exchange` | `asset` OR `account` | Unavailable to Agentic accounts |
| `cex_account_create_stp_group` | `/mcp/exchange` | `asset` OR `account` | Unavailable to Agentic accounts |
| `cex_account_delete_stp_group_users` | `/mcp/exchange` | `asset` OR `account` | Unavailable to Agentic accounts |
| `cex_account_get_account_detail` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_account_get_account_main_keys` | `/mcp/exchange` | `asset` OR `account` | Unavailable to Agentic accounts |
| `cex_account_get_account_rate_limit` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_account_get_debit_fee` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_account_list_stp_groups` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_account_list_stp_groups_users` | `/mcp/exchange` | `read` OR `account` | `base` |
| `cex_account_set_debit_fee` | `/mcp/exchange` | `asset` OR `account` | `base` |

## Rebate

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_rebate_broker_commission_history` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_rebate_broker_transaction_history` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_rebate_get_partner_agent_data_aggregated` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_rebate_get_partner_application_recent` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_rebate_get_partner_eligibility` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_rebate_partner_commissions_history` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_rebate_partner_sub_list` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_rebate_partner_transaction_history` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_rebate_user_info` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_rebate_user_sub_relation` | `/mcp/exchange` | `read` OR `profile` | `base` |

## Flash swap

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_fc_create_fc_multi_currency_many_to_one_order` | `/mcp/exchange` | `asset` OR `trade` | `spot_trade` |
| `cex_fc_create_fc_multi_currency_one_to_many_order` | `/mcp/exchange` | `asset` OR `trade` | `spot_trade` |
| `cex_fc_create_fc_order_v1` | `/mcp/exchange` | `asset` OR `trade` | `spot_trade` |
| `cex_fc_get_fc_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fc_list_fc_currency_pairs` | `/mcp` | — | — |
| `cex_fc_list_fc_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_fc_preview_fc_multi_currency_many_to_one_order` | `/mcp/exchange` | `asset` OR `trade` | `base` |
| `cex_fc_preview_fc_multi_currency_one_to_many_order` | `/mcp/exchange` | `asset` OR `trade` | `base` |
| `cex_fc_preview_fc_order_v1` | `/mcp/exchange` | `asset` OR `trade` | `base` |

## Earn

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_earn_add_position_auto_invest_plan` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_asset_list` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_award_list` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_change_uni_lend` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_create_auto_invest_plan` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_create_earn_fixed_term_lend` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_create_earn_fixed_term_pre_redeem` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_create_uni_lend` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_find_coin` | `/mcp/exchange` | `earn` OR `trade` | `base` |
| `cex_earn_get_auto_invest_min_amount` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_get_auto_invest_plan_detail` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_get_dual_order_refund_preview` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_get_dual_project_recommend` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_get_dual_stock_order_refund_preview` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_get_dual_stock_project_recommend` | `/mcp` | — | — |
| `cex_earn_get_uni_currency` | `/mcp` | — | — |
| `cex_earn_get_uni_interest` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_get_uni_interest_status` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_auto_invest_coins` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_auto_invest_config` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_auto_invest_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_auto_invest_plan_records` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_auto_invest_plans` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_dual_balance` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_dual_investment_plans` | `/mcp` | — | — |
| `cex_earn_list_dual_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_dual_stock_balance` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_dual_stock_investment_plans` | `/mcp` | — | — |
| `cex_earn_list_dual_stock_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_earn_fixed_term_history` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_earn_fixed_term_lends` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_earn_fixed_term_products` | `/mcp` | — | — |
| `cex_earn_list_earn_fixed_term_products_by_asset` | `/mcp` | — | — |
| `cex_earn_list_uni_chart` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_uni_currencies` | `/mcp` | — | — |
| `cex_earn_list_uni_interest_records` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_uni_lend_records` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_uni_rate` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_list_user_uni_lends` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_modify_dual_order_reinvest` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_modify_dual_stock_order_reinvest` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_order_list` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_earn_place_dual_order` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_place_dual_order_refund` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_place_dual_stock_order` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_place_dual_stock_order_refund` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_stop_auto_invest_plan` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_swap_staking_coin` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_earn_update_auto_invest_plan` | `/mcp/exchange` | `earn` OR `trade` | `earn` |

## Alpha

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_alpha_get_alpha_order` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_alpha_list_alpha_account_book` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_alpha_list_alpha_accounts` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_alpha_list_alpha_currencies` | `/mcp` | — | — |
| `cex_alpha_list_alpha_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_alpha_list_alpha_tickers` | `/mcp` | — | — |
| `cex_alpha_list_alpha_tokens` | `/mcp` | — | — |
| `cex_alpha_place_alpha_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `spot_trade` |
| `cex_alpha_quote_alpha_order` | `/mcp/exchange` | `spot_trade` OR `trade` | `base` |

## CFD / TradFi

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_cfd_close_position` | `/mcp/exchange` | `cfd` | `cfd` |
| `cex_cfd_create_tradfi_order` | `/mcp/exchange` | `cfd` | `cfd` |
| `cex_cfd_create_transaction` | `/mcp/exchange` | `cfd` | `cfd` |
| `cex_cfd_delete_order` | `/mcp/exchange` | `cfd` | `cfd` |
| `cex_cfd_query_categories` | `/mcp` | — | — |
| `cex_cfd_query_mt5_account_info` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_query_order_history_list` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_query_order_list` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_query_order_log` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_query_position_history_list` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_query_position_list` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_query_symbol_commissions` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_query_symbol_detail` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_query_symbol_kline` | `/mcp` | — | — |
| `cex_cfd_query_symbol_ticker` | `/mcp` | — | — |
| `cex_cfd_query_symbols` | `/mcp` | — | — |
| `cex_cfd_query_transaction` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_query_user_assets` | `/mcp/exchange` | `cfd` | `base` |
| `cex_cfd_update_order` | `/mcp/exchange` | `cfd` | `cfd` |
| `cex_cfd_update_position` | `/mcp/exchange` | `cfd` | `cfd` |

## Stock

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_stock_close_stock_position` | `/mcp/exchange` | `stock` | `stock` |
| `cex_stock_create_stock_order` | `/mcp/exchange` | `stock` | `stock` |
| `cex_stock_create_stock_transaction` | `/mcp/exchange` | `stock` | `base` |
| `cex_stock_delete_all_stock_orders` | `/mcp/exchange` | `stock` | `stock` |
| `cex_stock_delete_stock_order` | `/mcp/exchange` | `stock` | `stock` |
| `cex_stock_query_stock_exchanges` | `/mcp` | — | — |
| `cex_stock_query_stock_fee_rate` | `/mcp` | — | — |
| `cex_stock_query_stock_order_book` | `/mcp` | — | — |
| `cex_stock_query_stock_order_history` | `/mcp/exchange` | `stock` | `base` |
| `cex_stock_query_stock_order_list` | `/mcp/exchange` | `stock` | `base` |
| `cex_stock_query_stock_positions` | `/mcp/exchange` | `stock` | `base` |
| `cex_stock_query_stock_symbol_detail` | `/mcp` | — | — |
| `cex_stock_query_stock_symbols` | `/mcp` | — | — |
| `cex_stock_query_stock_transactions` | `/mcp/exchange` | `stock` | `base` |
| `cex_stock_query_stock_user_assets` | `/mcp/exchange` | `stock` | `base` |
| `cex_stock_update_stock_order` | `/mcp/exchange` | `stock` | `stock` |

## Multi-collateral loan

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_mcl_create_multi_collateral` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_mcl_get_multi_collateral_current_rate` | `/mcp` | — | — |
| `cex_mcl_get_multi_collateral_fix_rate` | `/mcp` | — | — |
| `cex_mcl_get_multi_collateral_ltv` | `/mcp` | — | — |
| `cex_mcl_get_multi_collateral_order_detail` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_mcl_list_multi_collateral_currencies` | `/mcp` | — | — |
| `cex_mcl_list_multi_collateral_orders` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_mcl_list_multi_collateral_records` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_mcl_list_multi_repay_records` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_mcl_list_user_currency_quota` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_mcl_operate_multi_collateral` | `/mcp/exchange` | `earn` OR `trade` | `earn` |
| `cex_mcl_repay_mcl` | `/mcp/exchange` | `earn` OR `trade` | `earn` |

## Strategy bots / AIHub

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_bot_get_ai_hub_portfolio_detail` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_bot_get_ai_hub_portfolio_running` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_bot_get_ai_hub_strategy_recommend` | `/mcp/exchange` | `read` OR `market` | `base` |
| `cex_bot_post_ai_hub_contract_martingale_create` | `/mcp/exchange` | `read` OR `profile` | `futures_trade`; `body.strategy_type=contract_martingale` |
| `cex_bot_post_ai_hub_futures_grid_create` | `/mcp/exchange` | `read` OR `profile` | `futures_trade`; `body.strategy_type=futures_grid` |
| `cex_bot_post_ai_hub_fx_combo_create` | `/mcp/exchange` | `read` OR `profile` | `futures_trade`; `body.strategy_type=futures_combo` |
| `cex_bot_post_ai_hub_infinite_grid_create` | `/mcp/exchange` | `read` OR `profile` | `spot_trade`; `body.strategy_type=infinite_grid` |
| `cex_bot_post_ai_hub_margin_grid_create` | `/mcp/exchange` | `read` OR `profile` | `spot_trade`; `body.strategy_type=margin_grid` |
| `cex_bot_post_ai_hub_portfolio_stop` | `/mcp/exchange` | `read` OR `profile` | `spot_trade` or `futures_trade`, selected by `body.strategy_type` |
| `cex_bot_post_ai_hub_smart_position_create` | `/mcp/exchange` | `read` OR `profile` | `spot_trade`; `body.strategy_type=smart_position` |
| `cex_bot_post_ai_hub_spot_grid_create` | `/mcp/exchange` | `read` OR `profile` | `spot_trade`; `body.strategy_type=spot_grid` |
| `cex_bot_post_ai_hub_spot_martingale_create` | `/mcp/exchange` | `read` OR `profile` | `spot_trade`; `body.strategy_type=spot_martingale` |

## Portfolio optimization / AssetSwap

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_assetswap_create_asset_swap_order_v1` | `/mcp/exchange` | `asset` OR `trade` | `spot_trade` |
| `cex_assetswap_evaluate_asset_swap` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_assetswap_get_asset_swap_config` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_assetswap_get_asset_swap_order_v1` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_assetswap_list_asset_swap_assets` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_assetswap_list_asset_swap_orders_v1` | `/mcp/exchange` | `read` OR `profile` | `base` |
| `cex_assetswap_preview_asset_swap_order_v1` | `/mcp/exchange` | `asset` OR `trade` | `base` |

## Square

| Tool | Endpoint | Ordinary OAuth scopes | Agentic override |
|---|---|---|---|
| `cex_square_list_live_replay` | `/mcp` | — | — |
| `cex_square_list_square_ai_search` | `/mcp` | — | — |
