# Gate MCP 服务器

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-协议-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

一个 [MCP (Model Context Protocol)](https://modelcontextprotocol.io) 服务器，将 Gate 交易 API 以工具形式提供给 AI 智能体使用。

## 功能特性

- **公开市场数据** — 现货/合约行情、深度、K 线、资金费率、强平历史（**无需认证**）
- **交易** — 现货/合约下单、撤单、改单
- **账户与钱包** — 余额、划转、充值提现、子账户
- **DEX** — 链上钱包、兑换（单链及跨链）、代币信息、市场数据，支持 20+ 条链
- **Info** — 币种信息、行情快照、技术分析、链上数据、合规检测
- **News** — 实时加密资讯、交易所公告、社交情绪
- **OAuth2 授权** — 交易及私有工具需 Gate 账号登录

## MCP 端点

服务提供五个 MCP 端点：

| 端点 | 认证 | 工具 |
|------|------|------|
| `https://api.gatemcp.ai/mcp` | 无 | 公开市场数据（17 个工具：现货+合约行情、深度、K 线等） |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | CEX 交易与账户（66 个工具：现货/合约交易、钱包、统一账户、子账户） |
| `https://api.gatemcp.ai/mcp/dex` | Google OAuth | DEX 钱包与兑换（25 个工具：链上钱包、Swap、代币信息、市场数据，支持 20+ 条链） |
| `https://api.gatemcp.ai/mcp/info` | 无 | 币种信息与分析（10 个工具：行情快照、技术分析、链上数据、合规检测） |
| `https://api.gatemcp.ai/mcp/news` | 无 | 资讯与情绪（3 个工具：新闻搜索、交易所公告、社交情绪） |

- **仅查行情** → 使用 `/mcp`（无需 Gate 账号）
- **CEX 交易、余额、划转** → 使用 `/mcp/exchange`（需 Gate OAuth2）
- **DEX 钱包、兑换、链上操作** → 使用 `/mcp/dex`（需 Google OAuth）
- **币种信息、技术分析** → 使用 `/mcp/info`（无需认证）
- **资讯、公告** → 使用 `/mcp/news`（无需认证）

传输协议：Streamable HTTP（支持 SSE 回退）。

## 授权说明（OAuth2）

**`/mcp/exchange` 需要 Gate OAuth2；`/mcp/dex` 需要 Google OAuth。** `/mcp`、`/mcp/info`、`/mcp/news` 无需任何认证。

### mcporter

> **前置条件**：Node.js >= 18、npm。完整安装步骤见 [快速开始 - mcporter](#mcporter--openclaw)。

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

**DEX（链上钱包、兑换）：**

```json
{
  "mcpServers": {
    "Gate-Dex": {
      "url": "https://api.gatemcp.ai/mcp/dex",
      "headers": {
        "x-api-key": "MCP_AK_8W2N7Q",
        "Authorization": "Bearer ${GATE_MCP_TOKEN}"
      }
    }
  }
}
```

**Info 与 News（无需认证）：**

```json
{
  "mcpServers": {
    "Gate-Info": {
      "url": "https://api.gatemcp.ai/mcp/info"
    },
    "Gate-News": {
      "url": "https://api.gatemcp.ai/mcp/news"
    }
  }
}
```

详见 [Cursor 配置指南](docs/setup-cursor-zh.md)。

### mcporter / OpenClaw

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

# 添加 DEX MCP
mcporter config add gate-dex --url https://api.gatemcp.ai/mcp/dex

# 添加 Info MCP（无需认证）
mcporter config add gate-info --url https://api.gatemcp.ai/mcp/info

# 添加 News MCP（无需认证）
mcporter config add gate-news --url https://api.gatemcp.ai/mcp/news
```

详见 [OpenClaw 配置指南](docs/setup-openclaw-zh.md)。

### Claude CLI

```bash
brew install claude-code
# 完整交易（OAuth）
claude mcp add --transport http Gate https://api.gatemcp.ai/mcp/exchange
# 授权完成之后，需要重启

# Info（无需认证）
claude mcp add --transport http Gate-Info https://api.gatemcp.ai/mcp/info

# News（无需认证）
claude mcp add --transport http Gate-News https://api.gatemcp.ai/mcp/news

claude mcp list
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
    },
    "gate-info": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/info"
      ]
    },
    "gate-news": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/news"
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
    },
    "gate-info": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/info"
      ]
    },
    "gate-news": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://api.gatemcp.ai/mcp/news"
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

### DEX — 登录认证

| 工具 | 描述 |
|------|------|
| `auth_google_login_start` | 发起 Google OAuth 登录流程 |
| `auth_google_login_poll` | 轮询登录状态，成功后返回 mcp_token |
| `auth_login_google_wallet` | 使用 Google OAuth 授权码登录 |
| `auth_logout` | 注销当前 MCP 会话 |

### DEX — 钱包

| 工具 | 描述 |
|------|------|
| `wallet_get_addresses` | 获取各链钱包地址（EVM、SOL） |
| `wallet_get_token_list` | 获取代币余额（含价格） |
| `wallet_get_total_asset` | 获取总资产价值及 24h 变动 |
| `wallet_sign_message` | 使用钱包私钥对消息签名 |
| `wallet_sign_transaction` | 使用钱包私钥对原始交易签名 |

### DEX — 链配置与交易

| 工具 | 描述 |
|------|------|
| `chain_config` | 获取链配置信息（networkKey、chainID、endpoint） |
| `tx_gas` | 估算 Gas 价格和 Gas 用量 |
| `tx_transfer_preview` | 签名前预览转账详情 |
| `tx_get_sol_unsigned` | 构建未签名 Solana SOL 转账 |
| `tx_send_raw_transaction` | 广播已签名交易至链上 |
| `tx_quote` | 获取兑换报价（含路由与价格影响） |
| `tx_swap` | 一键兑换：报价 → 构建 → 签名 → 提交 |
| `tx_swap_detail` | 按订单 ID 查询兑换状态 |
| `tx_list` / `tx_detail` / `tx_history_list` | 交易历史与兑换记录 |

### DEX — 市场数据与代币信息

| 工具 | 描述 |
|------|------|
| `market_get_kline` | K 线（蜡烛图）数据 |
| `market_get_tx_stats` | 交易量和交易员统计 |
| `market_get_pair_liquidity` | 流动性池添加/移除事件 |
| `token_get_coin_info` | 代币信息：价格、市值、持仓分布 |
| `token_ranking` | 24h 涨幅榜/跌幅榜 |
| `token_get_coins_range_by_created_at` | 按创建时间发现新代币 |
| `token_get_risk_info` | 安全审计：蜜罐、买卖税、黑名单 |

完整 DEX 工具参数见 [gate-dex-mcp](gate-dex/gate-dex-mcp_zh.md)。

### Info — 币种与行情

| 工具 | 描述 |
|------|------|
| `info_coin_get_coin_info` | 按名称、符号或合约地址查询币种信息 |
| `info_marketsnapshot_get_market_snapshot` | 行情一览：价格、K 线概况、市值、FDV、恐惧贪婪指数 |

### Info — 行情趋势与技术分析

| 工具 | 描述 |
|------|------|
| `info_markettrend_get_kline` | OHLCV K 线数据，可附带指标 |
| `info_markettrend_get_indicator_history` | 指标历史序列（RSI、MACD、MA、EMA） |
| `info_markettrend_get_technical_analysis` | 多粒度技术面综合信号 |

### Info — 链上数据

| 工具 | 描述 |
|------|------|
| `info_onchain_get_address_info` | 链上地址：标签、风险等级、代币余额 |
| `info_onchain_get_address_transactions` | 地址交易记录 |
| `info_onchain_get_transaction` | 按交易哈希查询完整详情 |
| `info_onchain_get_token_onchain` | 代币链上数据：持仓分布、活跃度、Smart Money |

### Info — 合规检测

| 工具 | 描述 |
|------|------|
| `info_compliance_check_token_security` | 代币安全检测：风险分级、税率、是否开源、持币人数 |

完整 Info 工具参数见 [gate-info-mcp](gate-info/gate-info-mcp_zh.md)。

### News — 资讯与公告

| 工具 | 描述 |
|------|------|
| `news_feed_search_news` | 按关键词、币种、时间范围、媒体类型搜索资讯 |
| `news_feed_get_exchange_announcements` | 交易所公告：上新、下架、维护 |
| `news_feed_get_social_sentiment` | 推文详情：作者、内容、互动、情绪 |

完整 News 工具参数见 [gate-news-mcp](gate-news/gate-news-mcp_zh.md)。

---

## 常见问题

### Q: 需要 Gate 账号吗？

A: **仅在使用 CEX 交易和 DEX 钱包时需要**。`/mcp`、`/mcp/info`、`/mcp/news` 完全公开，无需账号。`/mcp/exchange`（CEX 交易、余额、划转）须通过 Gate OAuth2 登录。`/mcp/dex`（链上钱包、兑换）须通过 Google OAuth 登录。

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
