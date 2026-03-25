# Gate News MCP 工具

> 本文仅列出 **对 Cursor 上线可见** 的 News 工具（与 `/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml` 中 `news.cursor_visible` 一致）。  
> 行情/链上类见 [gate-info-mcp_zh.md](gate-info-mcp_zh.md)。
>
> **实现仓库**：`/Users/slamdunk/gate/news-mcp-server`。命名见 `specs/mcp-tool-rule.md`。

**运行说明**：`news_events_*` 依赖 OpenSearch 事件索引；未配置时行为依部署而定。`news_feed_search_ugc`、`news_feed_search_x` 在代码中存在，但**当前不在** Cursor 可见清单内，本文不列。

---

## 1. 资讯快讯（`news_feed_*`）

### 1.1 搜索与实时快讯

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `news_feed_search_news` | 实时快讯/资讯检索。`query` 为空=热度模式（可带 coin→tickers、`top_total_score=1`）；`query` 非空=相似度模式（不下发 tickers，默认 `similarity_score=0.6`、`top_total_score=0`）。 | `query`、`coin`、`platform` / `platform_type`、`lang`（仅 MCP 层过滤）、`start_time`、`end_time`、`sort_by`、`top_total_score`、`limit`、`page`、`similarity_score` |

**下游 API**：`GET /api/v1/agent/news/social/real_time_news_feed`

### 1.2 交易所公告

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `news_feed_get_exchange_announcements` | 上新/下架/维护等公告。`exchange` / `platform` / `query` 映射下游查询参数 `query`；`coin` 映射 `tickers`。 | `exchange`、`platform`、`query`（交易所筛选同义字段）、`coin`、`announcement_type`、`from`、`to`（Unix 秒）、`limit`（传入时最大 100） |

**下游 API**：`GET /api/v1/agent/news/social/new_listing_on_exchange`

### 1.3 社交舆情（币种维度）

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `news_feed_get_social_sentiment` | 按币种聚合舆情：`overall_sentiment`、`sentiment_label`、`mention_count`、`sentiment_distribution`、`top_tweets`；并行请求 sentiment_score / positive_ratio / sentiment_analysis。**不传 `coin` 时默认按 BTC。** | `coin`（可选，支持逗号多币）、`time_range`（`1h` / `24h` 默认 / `7d`） |

**下游 API**：`GET /api/v1/agent/news/social/sentiment_score`、`positive_ratio`、`sentiment_analysis`（以 `tools_news_feed.go` 中 path 常量为准）。

---

## 2. 事件异动（`news_events_*`）

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `news_events_get_latest_events` | 已配置 OpenSearch 事件索引时为最新事件列表；否则为占位工具。 | `event_type`、`coin`、`time_range`（1h / 24h / 7d；与 `start_time`/`end_time` 互斥）、`limit`、`start_time`、`end_time`、`cursor` |
| `news_events_get_event_detail` | 已配置时为按 ID 查单条事件详情；否则为占位工具。 | `event_id`（必填） |

---

## 返回形态

- **列表型快讯工具**（`search_news`、`get_exchange_announcements`）：回显入参、`total`、`count`、`items`、`duration_ms`（见各 handler）。
- **`get_social_sentiment`**：币种舆情字段（`overall_sentiment`、`sentiment_label`、`mention_count`、`sentiment_distribution`、`top_tweets`、`duration_ms`），与通用列表信封不同。
- **事件类**：结构体见 `internal/event/types.go`（`LatestEventsResponse` / `EventDetailResponse`）。

风格参考：各仓库 `.cursor/rules/mcp-tool-api-style.mdc`。

---

## 参考

- Cursor 可见性/上线清单：`/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml`
- `specs/mcp-tool-rule.md`
- `internal/mcphost/tools_news_feed.go`、`tools_event.go`、`tools_placeholder.go`
- `docs/tool-api-mapping.md`、`docs/request.md`
