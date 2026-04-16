# AGENTS.md

## Learned User Preferences

- README 中不要将 mcporter 标注为「推荐」或 "Recommended"
- gate-mcp 文档与 OAuth/客户端示例须与 gateapi-mcp-service 实现对齐；需认证的连接应使用私有端点 `/mcp/exchange`，勿将仅适合公开的 `/mcp` 用于 OAuth 流程示例
- 将 .cursor/、.idea/、config/、scripts/ 添加到 .gitignore
- gateapiv4 YAML CR 中发现的内部字段（如 create_user、update_user、update_time、show_status、show_page、warn_rate、finance_uid）直接移除，不使用 x-external: false 标记
- gateapiv4 YAML 中 inline object 提取到同文件的 components/schemas，不提取到外部 definitions/ 文件
- gateapiv4 YAML CR 修复时 create_time 和 status 字段视为对外字段需保留
- 大型功能实现时，每个阶段（Phase）的内容必须独立闭环、可编译、可测试验证，不允许跨阶段留未闭合的依赖
- 单元测试要求全面覆盖，目标覆盖率 ≥ 90%，所有方案中列出的测试系列须逐项实现
- Go 限频相关代码修改后，须同时运行 `go test -race` 验证无竞态
- gateapi-mcp-service 中 MainUID 获取不到时，直接使用用户 UID 作为 MainUID fallback，不阻塞请求
- Prometheus metrics label 禁止使用含动态参数值的 resolved path（如 order_id、contract），必须使用 path_template 或 tool name 等固定基数标识

## Learned Workspace Facts

- gateapiv4 YAML 中 integer 字段若需表示大 ID（如条件单 order_id），必须显式添加 `format: int64`，否则 OpenAPI Generator 默认生成 int32 会溢出
- MCP 工具的 body 参数 description 中，修改（amend/update）接口应显式警告 body 是扁平 JSON 结构，不是创建接口的嵌套结构（如 `{initial, trigger}`），避免 AI 客户端混淆
- gateapi-mcp-service 限频系统采用三层分包架构：luaparse（Lua 解析）→ match（radix 匹配 + WBL）→ enforce（Redis EVAL 执行），解析器不做匹配、匹配器不解析 Lua、执行器不重复路径匹配
- gateapi-mcp-service 与 apiv4-gateway 共享同一 Redis 令牌桶（同 key、同 token_bucket_script），MCP 侧 Redis key 拼接格式必须与 req_limiter.lua 逐字符一致
- gateway-config 的 rate_limit_config.lua 当前含 42 个 limit_routers（41 个 allow=true）、70 条 limit_rules，支持 ip/user_id/spot_user_id_market/future_user_id_market 四种 limit_var
- Global 规则（http_blacklist + 429 采样封禁）Redis key 统一前缀 `mcp:global_limiter:`，禁止与 token_bucket key 空间冲突
- spot_user_id_market 路由需链式执行 3 次 Redis EVAL（UID → UID+market → MainUID+market），future_user_id_market 需 2 次，任一环节令牌耗尽短路 429 且已消耗令牌不退还
- gatekeeper-go 内部接口 GET /users/:user_id（端口 8183）返回 main_uid 和 tier，失败时降级为 MainUID=UID+Tier=0 不阻塞
- 限频 Lua 配置经 Nacos 下发，四层解析管线（P1 Precheck → P2 Lex → P3 Parse+Bind → P4 Validate）失败时保留 lastGood；limit_mode 缺省为 RESPECTIVE（与 req_limiter.lua 一致），DISTRIBUTED_SHARED 模式 key 不含 method/uri
- OpenAPI 中同一 operation 若挂多个 tag，Go SDK 会为各 tag 生成独立 API 文件，但 *Opts 等类型名仍由 operationId 派生，易在单包内重复定义；应在 gateapiv4 YAML 中保证每个 operation 仅一个 tag 后重新生成 SDK，勿手工改 gateapi-go-internal
- gateapi-mcp-service 限频系统新增 pathresolve 层：加载 config/interface.json 将 MCP tool name + arguments 解析为 HTTP path/method，用于 radix tree 匹配和 Redis key 拼接
- observe 和 enforce 共享 `BuildRequestView`/`ExtractClientIPFromHeader`/`ParseMainUID`（位于 `internal/ratelimit` 包导出），禁止在 enforce 包中重复实现
