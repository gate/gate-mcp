# Gate News MCP Tools

> **Cursor-visible** News tools only (aligned with `cursor_visible` under `news` in `/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml`).  
> Market / on-chain tools: [gate-info-mcp.md](gate-info-mcp.md).
>
> **Implementation**: `/Users/slamdunk/gate/news-mcp-server`. Naming: `specs/mcp-tool-rule.md`.

**Runtime**: `news_events_*` need OpenSearch `eventIndex` when running real handlers; if misconfigured, calls may still error or behave as placeholders depending on deploy. Tools such as `news_feed_search_ugc` / `news_feed_search_x` exist in code but are **not** in current Cursor visibility — omitted here.

---

## 1. News feed (`news_feed_*`)

### 1.1 Search & real-time news

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `news_feed_search_news` | Real-time news / feed search. Empty `query` = popularity mode (tickers, `top_total_score=1`); non-empty `query` = similarity mode (no tickers, default `similarity_score=0.6`, `top_total_score=0`). | `query`, `coin` (→ tickers when query empty), `platform` / `platform_type`, `lang` (MCP-side filter only), `start_time`, `end_time`, `sort_by`, `top_total_score`, `limit`, `page`, `similarity_score` |

**Downstream API**: `GET /api/v1/agent/news/social/real_time_news_feed`

### 1.2 Exchange announcements

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `news_feed_get_exchange_announcements` | Listings, delistings, maintenance, etc. Maps `exchange` / `platform` / `query` → downstream `query`; `coin` → `tickers`. | `exchange`, `platform`, `query` (synonyms for exchange filter), `coin`, `announcement_type`, `from`, `to` (Unix seconds), `limit` (max 100 when set) |

**Downstream API**: `GET /api/v1/agent/news/social/new_listing_on_exchange`

### 1.3 Social sentiment (coin-level)

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `news_feed_get_social_sentiment` | Aggregate sentiment for a coin over a window: `overall_sentiment`, `sentiment_label`, `mention_count`, `sentiment_distribution`, `top_tweets`. Parallel calls to sentiment_score / positive_ratio / sentiment_analysis. Default coin **BTC** if omitted. | `coin` (optional; comma-separated supported), `time_range` (`1h` / `24h` default / `7d`) |

**Downstream APIs**: `GET /api/v1/agent/news/social/sentiment_score`, `positive_ratio`, `sentiment_analysis` (paths as in `tools_news_feed.go`).

---

## 2. News events (`news_events_*`)

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `news_events_get_latest_events` | Latest anomaly / event list from OpenSearch when configured; else placeholder. | `event_type`, `coin`, `time_range` (1h / 24h / 7d; mutually exclusive with `start_time`/`end_time`), `limit`, `start_time`, `end_time`, `cursor` |
| `news_events_get_event_detail` | One event by id when OpenSearch configured; else placeholder. | `event_id` (required) |

---

## Response shape

- **List-style feed tools** (`search_news`, `get_exchange_announcements`): echoed inputs, `total`, `count`, `items`, `duration_ms` (see news-mcp-server handlers).
- **`get_social_sentiment`**: coin-level fields (`overall_sentiment`, `sentiment_label`, `mention_count`, `sentiment_distribution`, `top_tweets`, `duration_ms`) — not the same as the generic list envelope.
- **Events**: `LatestEventsResponse` / `EventDetailResponse` structs in `internal/event/types.go`.

Shared style reference: `.cursor/rules/mcp-tool-api-style.mdc` (in each repo).

---

## Reference

- Cursor visibility / launch list: `/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml`
- `specs/mcp-tool-rule.md`
- `internal/mcphost/tools_news_feed.go`, `tools_event.go`, `tools_placeholder.go`
- `docs/tool-api-mapping.md`, `docs/request.md`
