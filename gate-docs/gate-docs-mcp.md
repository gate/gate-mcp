# Gate Docs MCP Tools

> **Cursor-visible** Docs tools only (aligned with `cursor_visible` under `docs` in `/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml`).  
> Market and news: [gate-info-mcp.md](gate-info-mcp.md), [gate-news-mcp.md](gate-news-mcp.md).
>
> **Implementation**: `/Users/slamdunk/gate/docs-mcp-server`. Naming: `specs/mcp-tool-rule.md` (§7.7).

**Runtime**: With OpenSearch configured (`openSearch.dataSource=opensearch` and non-empty `endpoint`), these two tools call `internal/docs`. If OpenSearch is off, they may still be registered server-side but return **not implemented**. Other tools (e.g. `docs_research_search_papers`, `docs_research_search_api_docs`) may exist as `curl_only` or placeholders — omitted here per visibility YAML.

---

## 1. Docs research (`docs_research_*`)

| Tool | Description | Main parameters |
|------|-------------|-----------------|
| `docs_research_search_research` | Semantic search across research / papers / docs / tutorials (multi-corpus). Requires OpenSearch. | `query` (required), `content_type`, `domain`, `source`, `limit` (default 5) |
| `docs_research_get_coin_research` | Research reports linked to one or more coins. Requires OpenSearch. | `coin` (required, e.g. `BTC` or `BTC,ETH`), `limit` (default 5) |

---

## Response shape

Follow `.cursor/rules/mcp-tool-api-style.mdc` and each tool’s structured response types under `internal/docs` in the docs-mcp-server repo (echoed args, list fields, `duration_ms` where applicable).

---

## Reference

- Cursor visibility / launch list: `/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml`
- `specs/mcp-tool-rule.md`
- `internal/mcphost/tools_docs_research.go`, `tools_placeholder.go`, `server.go`
- `specs/docs-research-tools-spec.md`
