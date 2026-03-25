# Gate Info MCP 工具

> 本文仅列出 **对 Cursor 上线可见** 的 Info 工具（与 `/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml` 中 `info.cursor_visible` 一致）。  
> 资讯类见 [gate-news-mcp_zh.md](gate-news-mcp_zh.md)；文档检索见 [gate-docs-mcp_zh.md](gate-docs-mcp_zh.md)。
>
> **实现仓库**：`/Users/slamdunk/gate/mcp-server`（模块 `github.com/jelix/ai-data-mcp-server`）。命名见 `specs/mcp-tool-rule.md`，前缀 `info_{subcategory}_{action}`。

**运行说明**：多数领域依赖后端（OpenSearch、Gate HTTP API、Redis、浏览器索引、代币安全 API 等），未配置时返回约定错误码。`info_compliance_check_token_security` 仅在代币安全服务启用且仍保留在 `cursor_visible` 时，才对 Cursor 用户可用。未纳入该 YAML 的占位、`curl_only` 等工具本文不列。

适用工具的统一返回形态：回显入参 → `total` → `count` → `items` → `duration_ms`（snake_case）。详见该仓库 `docs/info/api-responses.md` 与 `.cursor/rules/mcp-tool-api-style.mdc`。

---

## 1. 币种（`info_coin`）

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_coin_get_coin_info` | 按名称、符号或合约解析币种，返回匹配列表与元数据。 | `query`（必填）、`query_type`（auto / address / symbol / name / gate_symbol / source_id）、`scope`（basic / detailed / full）、`size`、`fields` |

---

## 2. 行情快照（`info_marketsnapshot`）

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_marketsnapshot_get_market_snapshot` | 单币种实时价、K 线摘要、项目信息块。 | `symbol`（必填）；`timeframe` 或 `indicator_timeframe`（默认 1h）；`source`（spot / alpha / future / fx，默认 spot）；`quote`（如 USDT）；`scope`（basic / detailed / full） |

---

## 3. 行情趋势（`info_markettrend`）

### 3.1 K 线

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_markettrend_get_kline` | OHLCV，可带指标。 | `symbol`（必填）、`timeframe`、`period`、`size` / `limit`、`start_time`、`end_time`、`with_indicators` |

### 3.2 指标历史

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_markettrend_get_indicator_history` | 指定指标历史序列。 | `symbol`（必填）、`indicators`（必填）、`timeframe`（15m / 1h / 4h / 1d）、`start_time`、`end_time`、`limit` |

### 3.3 技术分析

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_markettrend_get_technical_analysis` | 多周期技术信号汇总。 | `symbol`（必填） |

---

## 4. 链上（`info_onchain`）

### 4.1 地址

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_onchain_get_address_info` | 标签、风险、Token 余额（eth / trx / bsc / btc / sol / base / arb 等）。 | `address`（必填）、`chain`（必填）、`scope`（basic / detailed / full）、`min_value_usd` |
| `info_onchain_get_address_transactions` | 交易历史与过滤。 | `address`（必填）、`chain`、`tx_type`、`time_range` 或 `start_time` / `end_time`、`min_value_usd`、`limit` |

### 4.2 交易与代币

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_onchain_get_transaction` | 按哈希查完整交易。 | `tx_hash`（必填）、`chain` |
| `info_onchain_get_token_onchain` | 持仓/活跃度/大额转账/smart_money 等切片。 | `token`（必填）、`chain`、`scope`（holders / activity / transfers / smart_money / full） |

---

## 5. 合规（`info_compliance`）

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_compliance_check_token_security` | 合约安全：风险档、税率、开源、持币人数、名称风险等。**仅代币安全服务启用时注册。** | `token` 或 `address`（二选一必填）、`chain`（必填）、`scope`（basic / full）、`lang` |

---

## 6. 平台指标（`info_platformmetrics`）

依赖 OpenSearch 的 platformmetrics 抓取器；未启用时调用返回需 OpenSearch 类错误。

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_platformmetrics_get_platform_info` | 单平台/协议全量指标。 | `platform_name`（必填）、`scope`（basic / with_chain_breakdown / full） |
| `info_platformmetrics_search_platforms` | 条件筛选与排序列表。 | `platform_type`、`chain`、`sort_by`、`limit` |
| `info_platformmetrics_get_defi_overview` | DeFi/现货/合约/稳定币/桥等宏观汇总。 | `category`（可选枚举或标签） |
| `info_platformmetrics_get_stablecoin_info` | 稳定币排名或单币详情。 | `symbol`、`chain`、`limit` |
| `info_platformmetrics_get_bridge_metrics` | 跨链桥排名或明细。 | `bridge_name`、`chain`、`sort_by`、`limit` |
| `info_platformmetrics_get_yield_pools` | 收益池、借贷利率。 | `project`、`chain`、`symbol`、`pool_type`、`sort_by`、`limit`、`min_tvl_usd` |
| `info_platformmetrics_get_platform_history` | TVL/成交量/费用历史。 | `platform_name`（必填）、`metrics`、`start_date`、`end_date`（YYYY-MM-DD） |
| `info_platformmetrics_get_exchange_reserves` | 交易所链上储备。 | `exchange`（必填）、`asset`、`period` |
| `info_platformmetrics_get_liquidation_heatmap` | 清算热力（价格区间分布）。 | `symbol`（必填）、`exchange`、`range` |

---

## 7. 宏观（`info_macro`）

依赖 OpenSearch 宏观抓取器与索引；未启用时返回需 OpenSearch 类错误。

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_macro_get_macro_indicator` | 单指标最新值或时间序列。 | `mode`（latest / timeseries）、`indicator`（必填）、`country`、时间范围、`size`（默认 20，最大 100） |
| `info_macro_get_economic_calendar` | 经济日历条目。 | `start_date` / `end_date`、`event_type`、`importance`、`size` |
| `info_macro_get_macro_summary` | 快照：关键指标 + 临近日历事件。 | 无入参 |

---

## 8. 盘口成交 K 线 — Gate API（`info_marketdetail`）

直连 Gate HTTP API；需配置 `marketdetail.gateAPI.baseURL`。返回内时间为 UTC。

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `info_marketdetail_get_orderbook` | 买卖盘口。 | `symbol`、`market_type`（spot / futures / delivery / options）、`depth`、`settle` |
| `info_marketdetail_get_recent_trades` | 最近成交。 | `symbol`、`market_type`、`limit`、`settle` |
| `info_marketdetail_get_kline` | 细粒度 K 线（如 1s/1m）。 | `symbol`、`market_type`、`timeframe`、`start_time`、`end_time`、`limit` |

---

## 参考

- Cursor 可见性/上线清单：`/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml`
- 工具规范：`specs/mcp-tool-rule.md`
- 请求/返回风格：`.cursor/rules/mcp-tool-api-style.mdc`
- 接口与错误：`docs/info/api.md`、`docs/info/api-responses.md`、`docs/error-codes.md`
