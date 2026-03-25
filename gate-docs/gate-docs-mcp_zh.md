# Gate Docs MCP 工具

> 本文仅列出 **对 Cursor 上线可见** 的 Docs 工具（与 `/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml` 中 `docs.cursor_visible` 一致）。  
> 行情与资讯见 [gate-info-mcp_zh.md](gate-info-mcp_zh.md)、[gate-news-mcp_zh.md](gate-news-mcp_zh.md)。
>
> **实现仓库**：`/Users/slamdunk/gate/docs-mcp-server`。命名见 `specs/mcp-tool-rule.md`（§7.7）。

**运行说明**：OpenSearch 已配置时走 `internal/docs`；未配置时服务端可能仍注册但调用返回**暂未实现**。`docs_research_search_papers`、`docs_research_search_api_docs` 等当前为 `curl_only` 或未对 Cursor 开放，按可见性清单本文不列。

---

## 1. 文档检索（`docs_research_*`）

| 工具名称 | 说明 | 主要参数 |
|----------|------|----------|
| `docs_research_search_research` | 跨子库语义检索（研报/论文/文档/教程等）。依赖 OpenSearch。 | `query`（必填）、`content_type`、`domain`、`source`、`limit`（默认 5） |
| `docs_research_get_coin_research` | 币种相关研报。依赖 OpenSearch。 | `coin`（必填，如 `BTC` 或 `BTC,ETH`）、`limit`（默认 5） |

---

## 返回形态

见 docs-mcp-server 仓库 `.cursor/rules/mcp-tool-api-style.mdc` 与各工具在 `internal/docs` 下的结构化返回类型（回显入参、列表字段、`duration_ms` 等）。

---

## 参考

- Cursor 可见性/上线清单：`/Users/slamdunk/gate/mcptest/docs/mcp-tool.yaml`
- `specs/mcp-tool-rule.md`
- `internal/mcphost/tools_docs_research.go`、`tools_placeholder.go`、`server.go`
- `specs/docs-research-tools-spec.md`
