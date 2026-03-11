# Gate MCP 服务器

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-协议-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

一个 [MCP (Model Context Protocol)](https://modelcontextprotocol.io) 服务器，将 Gate 交易 API 以工具形式提供给 AI 智能体使用。

## 功能特性

- **公开市场数据** — 现货/合约行情、深度、K 线、资金费率、强平历史（**无需认证**）
- **交易** — 现货/合约下单、撤单、改单
- **账户与钱包** — 余额、划转、充值提现、子账户
- **OAuth2 授权** — 交易及私有工具需 Gate 账号登录

## MCP 端点

服务提供两个 MCP 端点：

| 端点 | 认证 | 工具 |
|------|------|------|
| `https://api.gatemcp.ai/mcp` | 无 | 仅市场数据（17 个公开工具：现货+合约） |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | 交易与账户工具（66 个工具：现货/合约交易、钱包、统一账户、子账户） |

- **仅查行情** → 使用 `/mcp`（无需 Gate 账号）
- **交易、余额、划转** → 使用 `/mcp/exchange`（需 OAuth2）

传输协议：Streamable HTTP（支持 SSE 回退）。

## 授权说明（OAuth2）

**仅 `/mcp/exchange` 需要 OAuth2。** 公开端点 `/mcp` 无需任何认证。

### mcporter（推荐）

> **前置条件**：Node.js >= 18、npm。完整安装步骤见 [快速开始 - mcporter](#mcporter--openclaw推荐)。

```bash
# 添加私有 MCP（交易，需 OAuth）
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp/exchange --auth oauth

# 授权登录（打开浏览器）
mcporter auth gate-mcp
```

### scope 说明（用于 `/mcp/exchange`）

| scope | 用途 |
|-------|------|
| `market` | 公开市场数据（行情、深度、K 线等） |
| `profile` | 账户、订单、仓位（只读） |
| `trade` | 下单、撤单、改单 |
| `wallet` | 划转、充值提现 |
| `account` | 统一账户、子账户 |

### MCP Resources（静态参考数据）

公开端点和私有端点均提供以下资源：

| URI | 描述 |
|-----|------|
| `gate://spot/currency_pairs` | 所有现货交易对列表 |
| `gate://spot/currencies` | 所有币种信息列表 |
| `gate://futures/contracts/usdt` | USDT 结算合约列表 |
| `gate://futures/contracts/btc` | BTC 结算合约列表 |
| `gate://futures/contracts/{settle}` | 按结算币种查询合约（模板 URI） |

## 前置条件

- **Gate 账号**（仅使用 `/mcp/exchange` 时需要）
- **Node.js** >= 18（mcporter、Trae 等客户端）
- **Python** >= 3.9（可选，Claude Desktop 代理）

## 快速开始

选择你使用的客户端：

### Cursor

**完整交易能力（连接时 OAuth 登录）：**

编辑 `~/.cursor/mcp.json`：

```json
{
  "mcpServers": {
    "Gate": {
      "url": "https://api.gatemcp.ai/mcp/exchange",
      "transport": "streamable-http",
      "headers": {
        "Content-Type": "application/json",
        "Accept": "application/json, text/event-stream"
      }
    }
  }
}
```

**仅查行情（无需认证）：**

```json
{
  "mcpServers": {
    "Gate": {
      "url": "https://api.gatemcp.ai/mcp",
      "transport": "streamable-http",
      "headers": {
        "Content-Type": "application/json",
        "Accept": "application/json, text/event-stream"
      }
    }
  }
}
```

详见 [Cursor 配置指南](docs/setup-cursor-zh.md)。

### mcporter / OpenClaw（推荐）

#### 安装 mcporter 前置条件

- **Node.js** >= 18（mcporter 依赖 npm）
- **npm**（随 Node.js 安装）— 可用 `node -v` 和 `npm -v` 检查
- **Gate 账号**（使用 `/mcp/exchange` 时用于 OAuth 登录）

#### 安装 mcporter

```bash
# 全局安装
npm install -g mcporter

# 验证安装
mcporter --version
```

若不希望全局安装，可使用 `npx mcporter <命令>` 直接运行（依赖当前环境的 Node.js/npm）。

#### 添加 MCP 并授权

```bash
# 添加私有 MCP（交易，OAuth）
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp/exchange --auth oauth

# 授权登录（会打开浏览器）
mcporter auth gate-mcp
```

详见 [OpenClaw 配置指南](docs/setup-openclaw-zh.md)。

### Claude CLI

```bash
brew install claude-code
# 完整交易（OAuth）
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp/exchange
# 连接时会提示 OAuth 登录
claude mcp list
# 授权完成之后，需要重启
```

### Trae

编辑 Trae 设置，使用 `mcp-remote` 代理 HTTP MCP（使用 `/mcp/exchange` 时首次连接会提示 OAuth 登录）：

```json
{
  "mcpServers": {
    "gate": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/exchange"
      ]
    }
  }
}
```

### Qoder

编辑 Qoder MCP 配置（如 `~/.qoder/mcp.json` 或 Qoder 设置中）：

```json
{
  "mcpServers": {
    "gate": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/exchange"
      ]
    }
  }
}
```

### Claude Desktop

Claude Desktop 需要使用本地 stdio 代理。

1. 下载 [Python 代理文件](gate-mcp-proxy.py)
2. 编辑 `~/Library/Application Support/Claude/claude_desktop_config.json`：

```json
{
  "mcpServers": {
    "Gate": {
      "command": "python3",
      "args": ["/path/to/gate-mcp-proxy.py"]
    }
  }
}
```

详细配置说明请参考 [Claude Desktop 配置指南](docs/setup-claude-desktop-zh.md)。

### 其他客户端

| 客户端 | 配置指南 |
|--------|----------|
| Claude.ai | [配置说明](docs/setup-claude-ai-zh.md) |
| Codex App | [配置说明](docs/setup-codex-app-zh.md) |
| Codex CLI | [配置说明](docs/setup-codex-cli-zh.md) |
| OpenClaw | [配置说明](docs/setup-openclaw-zh.md) |
| Trae | 见上文 Trae 配置 |
| Qoder | 见上文 Qoder 配置 |

### 基础用法

- 「BTC/USDT 当前价格多少？」
- 「查看 ETH/USDT 的订单簿」
- 「获取 BTC 最近 7 天日 K 线」

---

## 工具列表

所有工具均使用 `cex_` 前缀。工具分为 Public MCP（无认证）与 Private MCP（OAuth2）。

### Public MCP（`/mcp` — 无需认证）

| 工具 | 描述 |
|------|------|
| `cex_spot_list_currencies` | 币种列表 |
| `cex_spot_get_currency` | 单个币种详情 |
| `cex_spot_list_currency_pairs` | 交易对列表 |
| `cex_spot_get_currency_pair` | 单个交易对详情 |
| `cex_spot_get_spot_tickers` | 现货行情 |
| `cex_spot_get_spot_order_book` | 现货深度 |
| `cex_spot_get_spot_trades` | 现货成交记录 |
| `cex_spot_get_spot_candlesticks` | 现货 K 线 |
| `cex_fx_list_fx_contracts` | 合约列表 |
| `cex_fx_get_fx_contract` | 单个合约详情 |
| `cex_fx_get_fx_tickers` | 合约行情 |
| `cex_fx_get_fx_order_book` | 合约深度 |
| `cex_fx_get_fx_trades` | 合约成交记录 |
| `cex_fx_get_fx_candlesticks` | 合约 K 线 |
| `cex_fx_get_fx_funding_rate` | 资金费率历史 |
| `cex_fx_get_fx_premium_index` | 溢价指数 K 线 |
| `cex_fx_list_fx_liq_orders` | 强平历史 |

### Private MCP（`/mcp/exchange` — OAuth2）

> **注意**：私有端点不包含公开市场数据工具。如需查询行情，请使用 `/mcp`。

#### 现货交易（scope: `profile` / `trade`）

| 工具 | 描述 |
|------|------|
| `cex_spot_get_spot_accounts` | 现货账户余额 |
| `cex_spot_list_spot_orders` / `cex_spot_get_spot_order` | 订单查询 |
| `cex_spot_list_spot_my_trades` / `cex_spot_list_spot_account_book` | 成交、流水 |
| `cex_spot_get_spot_fee` / `cex_spot_get_spot_batch_fee` | 费率查询 |
| `cex_spot_create_spot_order` / `cex_spot_create_spot_batch_orders` | 下单（单个/批量） |
| `cex_spot_cancel_spot_order` / `cex_spot_cancel_all_spot_orders` / `cex_spot_cancel_spot_batch_orders` | 撤单 |
| `cex_spot_amend_spot_order` / `cex_spot_amend_spot_batch_orders` | 改单 |

#### 合约交易（scope: `profile` / `trade`）

| 工具 | 描述 |
|------|------|
| `cex_fx_get_fx_accounts` | 合约账户 |
| `cex_fx_list_fx_positions` / `cex_fx_get_fx_position` / `cex_fx_get_fx_dual_position` | 仓位查询 |
| `cex_fx_list_fx_orders` / `cex_fx_get_fx_order` | 订单查询 |
| `cex_fx_list_fx_my_trades` / `cex_fx_get_fx_my_trades_timerange` | 成交查询 |
| `cex_fx_list_fx_account_book` / `cex_fx_get_fx_fee` | 流水、费率 |
| `cex_fx_list_fx_risk_limit_tiers` | 风险限额档位 |
| `cex_fx_create_fx_order` / `cex_fx_create_fx_batch_orders` | 下单 |
| `cex_fx_cancel_fx_order` / `cex_fx_cancel_all_fx_orders` / `cex_fx_cancel_fx_batch_orders` | 撤单 |
| `cex_fx_amend_fx_order` / `cex_fx_amend_fx_batch_orders` | 改单 |
| `cex_fx_update_fx_position_leverage` / `cex_fx_update_fx_position_margin` / `cex_fx_update_fx_position_cross_mode` | 仓位设置 |
| `cex_fx_set_fx_dual` / `cex_fx_update_fx_dual_position_margin` / `cex_fx_update_fx_dual_position_leverage` / `cex_fx_update_fx_dual_position_risk_limit` | 双向持仓设置 |
| `cex_fx_update_fx_dual_position_cross_mode` / `cex_fx_update_fx_position_risk_limit` | 逐仓/全仓切换、风险限额 |

#### 钱包与账户（scope: `wallet` / `account`）

| 工具 | 描述 |
|------|------|
| `cex_wallet_get_total_balance` | 总资产 |
| `cex_wallet_create_transfer` | 内部划转 |
| `cex_wallet_get_wallet_fee` / `cex_wallet_get_transfer_order_status` | 交易手续费、划转状态 |
| `cex_wallet_list_deposits` / `cex_wallet_list_withdrawals` | 充值、提现记录 |
| `cex_wallet_create_sa_transfer` / `cex_wallet_create_sa_to_sa_transfer` | 子账户划转 |
| `cex_unified_get_unified_accounts` / `cex_unified_get_unified_mode` / `cex_unified_set_unified_mode` | 统一账户 |
| `cex_unified_list_unified_loans` / `cex_unified_get_unified_risk_units` / `cex_unified_get_unified_borrowable` | 借贷、风险单元 |
| `cex_sa_list_sas` / `cex_sa_get_sa` / `cex_sa_create_sa` | 子账户管理 |
| `cex_sa_list_sa_keys` / `cex_sa_create_sa_key` / `cex_sa_get_sa_key` / `cex_sa_update_sa_key` / `cex_sa_delete_sa_key` | 子账户 API Key |
| `cex_sa_lock_sa` / `cex_sa_unlock_sa` / `cex_sa_get_sa_unified_mode` | 子账户锁定 |

按 scope 分组详见 [授权说明](#授权说明oauth2)。完整参数见 [gate-exchange 详情](gate-exchange/gate-exchange-mcp_zh.md)。

---

## 常见问题

### Q: 需要 Gate 账号吗？

A: **仅在使用交易和私有工具时需要**。使用 `/mcp` 时，可无需账号查询市场数据（行情、深度、K 线等）。使用 `/mcp/exchange`（交易、余额、划转）时，须通过 OAuth2 登录 Gate 账号（如 `mcporter auth gate-mcp`）。

### Q: 支持交易吗？

A: 支持。连接 `https://api.gatemcp.ai/mcp/exchange` 并完成 OAuth2 授权即可。提供现货、合约交易，账户管理，钱包划转，子账户等。各工具需对应 scope。

### Q: 数据更新频率？

A: 实时查询 Gate API。

---

## 隐私与安全

- 通过 Gate 账号 OAuth2 授权，不在配置中存储 API 密钥
- 所有请求使用 HTTPS
- 详见 [Gate 隐私政策](https://www.gate.com/legal/privacy-policy)

---

## 支持与反馈

- **API 文档**：[Gate API](https://www.gate.com/docs/developers/apiv4)
- **问题反馈**：请联系 Gate 客服
- **商务合作**：Gate 官方渠道

---

## 参与贡献

欢迎贡献！请阅读我们的 [贡献指南](CONTRIBUTING.md) 了解更多信息。

## 许可证

[MIT](LICENSE) © gate.com
