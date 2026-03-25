# Gate Info MCP Tools

> This document lists **Cursor-visible** Info tools only (aligned with `cursor_visible` under `info` in `/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml`).  
> News tools: [gate-news-mcp.md](gate-news-mcp.md). Docs research tools: [gate-docs-mcp.md](gate-docs-mcp.md).
>
> **Implementation**: `/Users/slamdunk/gate/mcp-server` (module `github.com/jelix/ai-data-mcp-server`). Naming: `specs/mcp-tool-rule.md`, prefix `info_{subcategory}_{action}`.

**Runtime**: Many domains need backing services (OpenSearch, Gate HTTP API, Redis, block explorer, token-security API). Unconfigured backends return documented error codes. `info_compliance_check_token_security` appears in Cursor only when the token-security service is enabled **and** the tool remains in `cursor_visible`. Tools not in that YAML (placeholders, `curl_only`, etc.) are intentionally omitted here.

Default response shape where applicable: echoed input → `total` → `count` → `items` → `duration_ms` (snake_case). See that repo’s `docs/info/api-responses.md` and `.cursor/rules/mcp-tool-api-style.mdc`.

---

## 1. Coin (`info_coin`)

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_coin_get_coin_info` | Resolve a coin by name, symbol, or contract; returns matches and metadata. | `query` (required), `query_type` (auto / address / symbol / name / gate_symbol / source_id), `scope` (basic / detailed / full), `size`, `fields` |

---

## 2. Market snapshot (`info_marketsnapshot`)

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_marketsnapshot_get_market_snapshot` | Real-time quote, kline summary, project block for one symbol. | `symbol` (required); `timeframe` or `indicator_timeframe` (default 1h); `source` (spot / alpha / future / fx, default spot); `quote` (e.g. USDT); `scope` (basic / detailed / full) |

---

## 3. Market trend (`info_markettrend`)

### 3.1 K-line

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_markettrend_get_kline` | OHLCV with optional indicators. | `symbol` (required), `timeframe`, `period`, `size` / `limit`, `start_time`, `end_time`, `with_indicators` |

### 3.2 Indicator history

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_markettrend_get_indicator_history` | Historical series for listed indicators. | `symbol` (required), `indicators` (required), `timeframe` (15m / 1h / 4h / 1d), `start_time`, `end_time`, `limit` |

### 3.3 Technical analysis

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_markettrend_get_technical_analysis` | Multi-timeframe technical signals. | `symbol` (required) |

---

## 4. Onchain (`info_onchain`)

### 4.1 Address

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_onchain_get_address_info` | Labels, risk, token balances (eth / trx / bsc / btc / sol / base / arb, …). | `address` (required), `chain` (required), `scope` (basic / detailed / full), `min_value_usd` |
| `info_onchain_get_address_transactions` | Transaction history with filters. | `address` (required), `chain`, `tx_type`, `time_range` or `start_time` / `end_time`, `min_value_usd`, `limit` |

### 4.2 Transaction & token

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_onchain_get_transaction` | Full tx by hash. | `tx_hash` (required), `chain` |
| `info_onchain_get_token_onchain` | Holder / activity / transfers / smart_money slices. | `token` (required), `chain`, `scope` (holders / activity / transfers / smart_money / full) |

---

## 5. Compliance (`info_compliance`)

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_compliance_check_token_security` | Contract security: risk tier, taxes, open source, holders, name risk. **Registered only if token-security service is enabled.** | `token` or `address` (one required), `chain` (required), `scope` (basic / full), `lang` |

---

## 6. Platform metrics (`info_platformmetrics`)

Requires OpenSearch-backed `platformmetrics` fetcher; otherwise calls error with “requires OpenSearch” semantics.

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_platformmetrics_get_platform_info` | Single protocol/platform metrics. | `platform_name` (required), `scope` (basic / with_chain_breakdown / full) |
| `info_platformmetrics_search_platforms` | Ranked list with filters/sort. | `platform_type`, `chain`, `sort_by`, `limit` |
| `info_platformmetrics_get_defi_overview` | Macro DeFi / spot / perp / stablecoin / bridge aggregates. | `category` (optional enum or label) |
| `info_platformmetrics_get_stablecoin_info` | Stablecoin ranking or one symbol detail. | `symbol`, `chain`, `limit` |
| `info_platformmetrics_get_bridge_metrics` | Bridge ranking or breakdown. | `bridge_name`, `chain`, `sort_by`, `limit` |
| `info_platformmetrics_get_yield_pools` | Lending / yield pools. | `project`, `chain`, `symbol`, `pool_type`, `sort_by`, `limit`, `min_tvl_usd` |
| `info_platformmetrics_get_platform_history` | TVL / volume / fees history. | `platform_name` (required), `metrics`, `start_date`, `end_date` (YYYY-MM-DD) |
| `info_platformmetrics_get_exchange_reserves` | Exchange on-chain reserves. | `exchange` (required), `asset`, `period` |
| `info_platformmetrics_get_liquidation_heatmap` | Liquidation distribution by price band. | `symbol` (required), `exchange`, `range` |

---

## 7. Macro (`info_macro`)

Requires OpenSearch macro fetcher + indices; otherwise “requires OpenSearch” style errors.

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_macro_get_macro_indicator` | Latest or time series for one indicator. | `mode` (latest / timeseries), `indicator` (required), `country`, time range, `size` (default 20, max 100) |
| `info_macro_get_economic_calendar` | Economic calendar rows. | `start_date` / `end_date`, `event_type`, `importance`, `size` |
| `info_macro_get_macro_summary` | Snapshot: key indicators + upcoming calendar items. | (no input) |

---

## 8. Market detail — Gate API (`info_marketdetail`)

Direct Gate HTTP API; needs `marketdetail.gateAPI.baseURL`. Timestamps in responses are UTC.

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `info_marketdetail_get_orderbook` | Order book depth. | `symbol`, `market_type` (spot / futures / delivery / options), `depth`, `settle` |
| `info_marketdetail_get_recent_trades` | Recent trades. | `symbol`, `market_type`, `limit`, `settle` |
| `info_marketdetail_get_kline` | Fine-grained candles (e.g. 1s / 1m). | `symbol`, `market_type`, `timeframe`, `start_time`, `end_time`, `limit` |

---

## Reference

- Cursor visibility / launch list: `/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml`
- Tool rules: `specs/mcp-tool-rule.md`
- API style: `.cursor/rules/mcp-tool-api-style.mdc`
- APIs & errors: `docs/info/api.md`, `docs/info/api-responses.md`, `docs/error-codes.md`
