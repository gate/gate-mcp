# CLAUDE.md

本仓库是 Gate MCP 的**用户侧使用文档**，MCP 实现位于 **gateapi-mcp-service** 项目。

## 文档一致性要求

- 工具列表、scope、端点必须与 gateapi-mcp-service 实现保持一致
- 修改时对照 `gateapi-mcp-service/internal/middleware/scope.go` 的 toolScopeMap 和 `internal/server/server.go` 的注册逻辑
