# Changelog

All notable changes to the Gate AI MCP Server are documented here.

---

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
