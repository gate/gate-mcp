# Gate Agentic Wallet MCP Server

## 1. 概述

Gate Agentic Wallet MCP Server 是基于 MCP (Model Context Protocol) 的 Web3 钱包服务，提供 Google OAuth 登录、钱包管理、链上交易签名、Swap 交易、市场数据查询等能力。

- **协议**: MCP (Model Context Protocol)，基于 JSON-RPC 2.0
- **认证**: 通过 Google OAuth 获取 mcp_token，后续调用需鉴权的工具时携带该 token
- **支持链**: EVM 系（ETH、BSC、Polygon、Arbitrum、Base、Avalanche 等）+ Solana
- **权限范围**: `wallet:read`, `wallet:sign`, `tx:read`, `tx:write`

## 2. 安装与配置

- **URL 地址**: `https://api.gatemcp.ai/mcp/dex`
- **x-api-key**: `MCP_AK_8W2N7Q`（区分大小写）

### 2.1 Cursor 接入

在 Cursor Settings → MCP 中添加：

```json
{
  "mcpServers": {
    "gate-dex": {
      "url": "https://api.gatemcp.ai/mcp/dex",
      "headers": {
        "x-api-key": "MCP_AK_8W2N7Q",
        "Authorization": "Bearer <your_mcp_token>"
      }
    }
  }
}
```

添加后 Cursor 会自动发现所有工具。首次使用需鉴权的工具时，会弹出 Google 授权页面完成登录。

- **x-api-key**: 服务端分配的接入密钥
- **Authorization**: 登录后获取的 mcp_token（有效期 30 天，过期后需重新获取并更新配置，添加配置文件之后需要重启 Cursor）

### 2.2 Claude Desktop 接入

编辑 `~/Library/Application Support/Claude/claude_desktop_config.json`：

```json
{
  "mcpServers": {
    "gate-dex": {
      "url": "https://api.gatemcp.ai/mcp/dex",
      "headers": {
        "x-api-key": "MCP_AK_8W2N7Q",
        "Authorization": "Bearer <your_mcp_token>"
      }
    }
  }
}
```

重启 Claude Desktop 后，在对话中可直接使用 Gate Wallet 的工具，添加配置文件之后最好重启 CC。

### 2.3 其他 MCP 客户端

任何支持 MCP Streamable HTTP 的客户端均可接入，只需配置：

| 配置项 | 值 | 说明 |
|--------|------|------|
| MCP 端点 | `https://api.gatemcp.ai/mcp/dex` | |
| x-api-key | `MCP_AK_8W2N7Q` | 接入密钥 |
| Authorization | `Bearer <mcp_token>` | 登录后获取 |

### 2.4 获取 mcp_token

首次使用前需通过 Google 授权登录获取 mcp_token：

1. 调用 `dex_auth_google_login_start` → 获取 Google 授权链接
2. 在浏览器中打开链接，完成 Google 账号登录
3. 调用 `dex_auth_google_login_poll` 获取 mcp_token
4. 将 token 填入客户端配置的 `Authorization` 头中

Token 有效期 30 天，过期后重复上述步骤重新获取。

> 市场数据和代币信息类工具无需 mcp_token 即可直接使用。

## 3. 认证

### 3.1 登录流程

#### Google OAuth 登录

支持 Google OAuth 登录，流程如下：

1. 调用 `dex_auth_google_login_start` → 获取 `flow_id` 和 `verification_url`
2. 用户在浏览器打开 `verification_url` 完成 Google 登录授权
3. 调用 `dex_auth_google_login_poll` 轮询登录状态 → 登录成功后返回 `mcp_token`

轮询响应状态：

| status | 说明 | 附带字段 |
|--------|------|----------|
| `pending` | 用户尚未完成登录 | `retry_after` |
| `ok` | 登录成功 | `mcp_token`, `user_id`, `account_id`, `wallets` 等 |
| `error` | 登录失败 | `error` |
| `expired` | 流程过期（默认 30 分钟） | `error` |

#### Gate OAuth 登录

支持 Gate OAuth 登录，流程如下：

1. 调用 `dex_auth_gate_login_start` → 获取 `flow_id` 和 `verification_url`
2. 用户在浏览器打开 `verification_url` 完成 Gate 登录授权
3. 调用 `dex_auth_gate_login_poll` 轮询登录状态 → 登录成功后返回 `mcp_token`

轮询响应状态：

| status | 说明 | 附带字段 |
|--------|------|----------|
| `pending` | 用户尚未完成登录 | `retry_after` |
| `ok` | 登录成功 | `mcp_token`, `user_id`, `account_id`, `wallets` 等 |
| `error` | 登录失败 | `error` |
| `expired` | 流程过期（默认 30 分钟） | `error` |

### 3.2 Token 说明

- **格式**: `mcp_pat_<payload>.<signature>`
- **有效期**: 默认 30 天
- **传递方式**: 在工具参数中传 `"mcp_token": "mcp_pat_xxx"`
- 上游 token 过期时自动刷新，refresh_token 过期时需重新登录

### 3.3 工具鉴权分类

| 分类 | 是否需要 mcp_token |
|------|-------------------|
| 认证工具 (`dex_auth_*`) | 不需要 |
| 市场数据 (`dex_market_get_*`) | 不需要 |
| 代币信息 (`dex_token_*`) | 不需要 |
| 钱包工具 (`dex_wallet_*`) | 需要 |
| 交易工具 (`dex_tx_*`, `dex_chain_*`) | 需要 |

## 4. 工具列表

共 27 个工具。

### 4.1 认证工具

| 工具名 | 说明 | 参数 |
|--------|------|------|
| `dex_auth_google_login_start` | 创建 Google 登录流，返回验证 URL | 无 |
| `dex_auth_google_login_poll` | 轮询 Google 登录状态 | `flow_id` (必填) |
| `dex_auth_login_google_wallet` | 直接用 Google 授权码登录 | `code` (必填), `redirect_url` (必填) |
| `dex_auth_gate_login_start` | 创建 Gate 登录流，返回验证 URL | 无 |
| `dex_auth_gate_login_poll` | 轮询 Gate 登录状态 | `flow_id` (必填) |
| `dex_auth_login_gate_wallet` | 直接用 Gate 授权码登录 | `code` (必填), `redirect_url` (必填) |
| `dex_auth_logout` | 撤销会话 | `mcp_token` (必填) |

### 4.2 钱包工具

| 工具名 | 说明 | 参数 |
|--------|------|------|
| `dex_wallet_get_addresses` | 获取各链钱包地址（EVM、SOL） | `account_id` (必填), `mcp_token` |
| `dex_wallet_get_token_list` | 查询代币余额列表（含价格） | `account_id`, `chain`, `network_keys`, `page`, `page_size`, `mcp_token` |
| `dex_wallet_get_total_asset` | 查询总资产及 24h 涨跌 | `account_id`, `mcp_token` |
| `dex_wallet_sign_message` | 用钱包私钥签名消息（32 字节 hex） | `message` (必填), `chain` (必填, EVM/SOL), `mcp_token` |
| `dex_wallet_sign_transaction` | 用钱包私钥签名原始交易 | `raw_tx` (必填), `chain` (必填, EVM/SOL), `mcp_token` |

## 5. 资源 (Resources)

通过 MCP `resources/read` 方法读取。

### 5.1 静态资源

| URI | 说明 |
|-----|------|
| `chain://supported` | 所有支持的链及其配置（networkKey、chainType、端点等） |
| `swap://supported_chains` | Swap 支持的链列表，按 EVM/Solana 分组（含 chain_id） |

### 5.2 资源模板

| URI 模板 | 说明 |
|----------|------|
| `account://{accountId}` | 账户概览（链类型、脱敏地址） |
| `balance://{accountId}` | 代币余额快照（可选 `?chain=ETH&network=ETH`） |
| `kline://{chain}/{tokenAddress}?period=1h&limit=100` | K 线数据 |
| `volume://{chain}/{tokenAddress}` | 交易量统计（5m/1h/4h/24h） |
| `liquidity://{chain}/{tokenAddress}` | 流动性池事件 |
| `token://{chain}/{address}` | 代币合约详情（含持仓分布） |
| `ranking://{direction}?top_n=10` | 涨跌排行（direction: desc/asc） |
| `security://{chain}/{address}` | 安全审计（蜜罐、税率、权限等） |
| `discover_tokens://{sort_field}/{sort_order}?limit=20` | 新代币发现 |
| `trade://order/{txOrderId}` | Swap 订单详情 |
