# Changelog

All notable changes to the Gate AI MCP Server are documented here.

---

## [3.0.0] - 2026-03-19

### Breaking Changes
- **Delivery tools renamed**: All `cex_dt_*` tools renamed to `cex_dc_*` (29 tools)
- **Futures tools renamed**: Removed redundant `_fx_` infix from 11 tools (e.g., `cex_fx_get_fx_leverage` → `cex_fx_get_leverage`)
- **Rebate tools renamed**: Removed redundant `_rebate_` prefix from 3 tools (e.g., `cex_rebate_rebate_broker_commission_history` → `cex_rebate_broker_commission_history`)
- **TradFi tools renamed**: `trad_fi` → `tradfi` naming unification (e.g., `cex_tradfi_create_trad_fi_order` → `cex_tradfi_create_tradfi_order`)
- **Flash Swap upgraded**: `cex_fc_create_fc_order` / `cex_fc_preview_fc_order` replaced by v1 series + multi-currency series

### Added
- 47 new tools across 11 business areas:
  - **Activity Center** (3): activity types, activities list, user entry
  - **Coupon** (2): user coupons, coupon detail
  - **Earn Fixed Term** (6): products, subscriptions, history, subscribe, early redeem
  - **Flash Swap** (6): one-to-one v1 preview/create, many-to-one, one-to-many preview/create
  - **Futures** (5): risk limit table, liquidation history, position history by time range, position mode, leverage update
  - **Launch Pool** (5): projects, pledge records, reward records, create order, redeem
  - **Options** (1): amend options order
  - **Rebate** (2): partner application, eligibility check
  - **Square** (2): AI search, live replay
  - **Unified Account** (16): portfolio margin, loans, rates, transferable, leverage config, discount tiers, collateral, currencies
  - **Welfare** (2): identity check, beginner tasks
- Collateral Loan module enabled (public + private)
- Flash Swap public tools enabled

### Removed
- OTC module (10 tools)
- `cex_spot_get_system_time`, `cex_tradfi_create_tradfi_user`, `cex_wallet_create_transfer`
- `cex_rebate_agency_commissions_history`, `cex_rebate_agency_transaction_history`

### Changed
- Total `/mcp/exchange` tool count: 300+ → 400+
- Public `/mcp` tool count: 51 → 58

## [2.1.0] - 2026-03-19

### Added
- Gate Agentic Wallet MCP documentation (`gate-dex/gate-agentic-wallet-mcp.md`, `gate-dex/gate-agentic-wallet-mcp_zh.md`): subset of DEX tools covering auth, wallet, market data, token info, and MCP resources
- Gate OAuth login support (`dex_auth_gate_login_start`, `dex_auth_gate_login_poll`, `dex_auth_login_gate_wallet`)

### Changed
- Updated README to reference gate-agentic-wallet-mcp documentation

## [2.0.0] - 2026-03-11

### Changed
- **Dual MCP endpoints**: Split into `/mcp` (public, no auth) and `/mcp/exchange` (private, OAuth2)
- **Tool naming**: All tools now use `cex_` prefix (e.g., `get_spot_tickers` → `cex_spot_get_spot_tickers`, `get_futures_contract` → `cex_fx_get_fx_contract`)
- Private endpoint (`/mcp/exchange`) no longer includes public market data tools

### Added
- 66 private tools on `/mcp/exchange` (OAuth2 required):
  - Spot trading: orders, batch orders, amend, cancel, account queries, fee rates
  - Futures trading: orders, batch orders, positions, dual-mode, leverage, margin, risk limits
  - Wallet: transfers, deposits, withdrawals, sub-account transfers
  - Unified account: mode, borrowable, risk units, loans
  - Sub-accounts: management, API keys, lock/unlock
- Batch operations: `cex_spot_create_spot_batch_orders`, `cex_spot_cancel_spot_batch_orders`, `cex_spot_amend_spot_batch_orders`, `cex_fx_create_fx_batch_orders`, `cex_fx_cancel_fx_batch_orders`, `cex_fx_amend_fx_batch_orders`
- OAuth2 authorization with scopes: `profile`, `trade`, `wallet`, `account`

## [1.0.0] - 2026-03-04

### Added
- Initial release
- 17 MCP tools: list_currencies, get_currency, list_currency_pairs, get_currency_pair, get_spot_tickers, get_spot_order_book, get_spot_candlesticks, get_spot_trades, list_futures_contracts, get_futures_contract, get_futures_tickers, get_futures_order_book, get_futures_candlesticks, get_futures_trades, get_futures_funding_rate, get_futures_premium_index, list_futures_liq_orders
- Spot market queries (ticker, depth, K-line, trades, currency & pair info)
- Futures market queries (contract info, ticker, depth, K-line, trades)
- Funding rate & premium index queries
- Futures liquidation history
