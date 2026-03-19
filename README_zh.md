# Gate MCP 服务器

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-协议-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

一个 [MCP (Model Context Protocol)](https://modelcontextprotocol.io) 服务器，将 Gate 交易 API 以工具形式提供给 AI 智能体使用。

## 功能特性

- **公开市场数据** — 现货、合约、杠杆、期权、交割、理财、Alpha 行情、深度、K 线、资金费率、强平历史（**无需认证**）
- **交易** — 现货/合约/期权/交割下单、撤单、改单；计划委托；追踪委托
- **账户与钱包** — 余额、划转、充值提现、子账户、统一账户
- **杠杆与理财** — 杠杆借贷、理财产品、闪兑（含多币种）
- **活动中心、卡券、新币挖矿、广场、新手福利** — 活动类型、用户卡券、LaunchPool、AI 搜索、新手任务
- **TradFi、跨所、OTC、P2P** — 传统金融、跨所交易、场外、P2P
- **DEX** — 链上钱包、兑换（单链及跨链）、代币信息、市场数据，支持 20+ 条链
- **Info** — 币种信息、行情快照、技术分析、链上数据、合规检测
- **News** — 实时加密资讯、交易所公告、社交情绪
- **OAuth2 授权** — 交易及私有工具需 Gate 账号登录

## MCP 端点

服务提供五个 MCP 端点：

| 端点 | 认证 | 工具 |
|------|------|------|
| `https://api.gatemcp.ai/mcp` | 无 | 公开市场数据（58 个工具：现货、合约、杠杆、期权、交割、理财、Alpha、活动中心、新币挖矿、广场、闪兑） |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | CEX 交易与账户（400+ 工具：现货/合约/期权/交割/杠杆交易、钱包、统一账户、子账户、理财、闪兑、返佣、TradFi、跨所、P2P、Alpha、活动中心、卡券、新币挖矿、广场、新手福利） |
| `https://api.gatemcp.ai/mcp/dex` | Google / Gate OAuth | DEX 钱包与兑换（33 个工具：链上钱包、Swap、代币信息、市场数据、Agentic、RPC，支持 20+ 条链） |
| `https://api.gatemcp.ai/mcp/info` | 无 | 币种信息与分析（10 个工具：行情快照、技术分析、链上数据、合规检测） |
| `https://api.gatemcp.ai/mcp/news` | 无 | 资讯与情绪（3 个工具：新闻搜索、交易所公告、社交情绪） |

- **仅查行情** → 使用 `/mcp`（无需 Gate 账号）
- **CEX 交易、余额、划转** → 使用 `/mcp/exchange`（需 Gate OAuth2）
- **DEX 钱包、兑换、链上操作** → 使用 `/mcp/dex`（需 Google / Gate OAuth）
- **币种信息、技术分析** → 使用 `/mcp/info`（无需认证）
- **资讯、公告** → 使用 `/mcp/news`（无需认证）

传输协议：Streamable HTTP（支持 SSE 回退）。

## 授权说明（OAuth2）

**`/mcp/exchange` 需要 Gate OAuth2；`/mcp/dex` 需要 Google 或 Gate OAuth。** `/mcp`、`/mcp/info`、`/mcp/news` 无需任何认证。

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

#### 方式一：一键安装（推荐）

在 Cursor AI 对话中粘贴以下内容，AI 会自动安装全部 Gate MCP 服务器和 Skills：

> Help me auto install Gate Skills and MCPs: https://github.com/gate/gate-skills

详见 [gate-skills](https://github.com/gate/gate-skills)。

#### 方式二：手动配置

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

#### 方式一：一键安装（推荐）

在 OpenClaw AI 对话中粘贴以下内容，AI 会自动安装全部 Gate MCP 服务器和 Skills：

> Help me auto install Gate Skills and MCPs: https://github.com/gate/gate-skills

详见 [gate-skills](https://github.com/gate/gate-skills)。

#### 方式二：手动配置

##### 安装 mcporter 前置条件

- **Node.js** >= 18（mcporter 依赖 npm）
- **npm**（随 Node.js 安装）— 可用 `node -v` 和 `npm -v` 检查
- **Gate 账号**（使用 `/mcp/exchange` 时用于 OAuth 登录）

##### 安装 mcporter

```bash
# 全局安装
npm install -g mcporter

# 验证安装
mcporter --version
```

若不希望全局安装，可使用 `npx mcporter <命令>` 直接运行（依赖当前环境的 Node.js/npm）。

##### 添加 MCP 并授权

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

#### 方式一：一键安装（推荐）

在 Claude CLI 中粘贴以下内容，AI 会自动安装全部 Gate MCP 服务器和 Skills：

> Help me auto install Gate Skills and MCPs: https://github.com/gate/gate-skills

详见 [gate-skills](https://github.com/gate/gate-skills)。

#### 方式二：手动配置

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

### 替代方案：gate-local-mcp（本地 stdio + API Key）

本地开发且无需 OAuth 时，可使用 [gate-local-mcp](https://github.com/gateio/gate-local-mcp)（npm 包名：`gate-mcp`）— 以 stdio MCP 服务器方式运行，使用 `GATE_API_KEY` / `GATE_API_SECRET`。在客户端中配置为命令式 MCP（如 `"command": "npx", "args": ["-y", "gate-mcp"]`）。

完整工具列表：[gate-local-mcp-tools.md](gate-exchange/gate-local-mcp-tools.md)。

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

### Public MCP（`/mcp` — 无需认证，58 个工具）

| 业务线 | 数量 | 说明 |
|--------|------|------|
| **现货** | 8 | `cex_spot_list_currencies`、`cex_spot_get_currency`、`cex_spot_list_currency_pairs`、`cex_spot_get_currency_pair`、`cex_spot_get_spot_tickers`、`cex_spot_get_spot_order_book`、`cex_spot_get_spot_trades`、`cex_spot_get_spot_candlesticks` |
| **合约** | 14 | 合约列表、深度、成交、K 线、行情、资金费率、溢价指数、强平、合约统计、保险账本、指数成分、批量资金费率、`cex_fx_get_fx_risk_limit_table` |
| **杠杆** | 3 | `cex_margin_list_uni_currency_pairs`、`cex_margin_get_uni_currency_pair`、`cex_margin_get_market_margin_tier` |
| **期权** | 12 | 标的、到期日、合约、结算、深度、行情、K 线、成交 |
| **交割** | 8 | 合约、深度、成交、K 线、行情、保险账本、风险限额档位 |
| **理财** | 5 | `cex_earn_list_dual_investment_plans`、`cex_earn_list_structured_products`、`cex_earn_list_uni_currencies`、`cex_earn_list_earn_fixed_term_products`、`cex_earn_list_earn_fixed_term_products_by_asset` |
| **Alpha** | 3 | `cex_alpha_list_alpha_currencies`、`cex_alpha_list_alpha_tickers`、`cex_alpha_list_alpha_tokens` |
| **活动中心** | 1 | `cex_activity_list_activity_types` |
| **新币挖矿** | 1 | `cex_launch_list_launch_pool_projects` |
| **广场** | 2 | `cex_square_list_square_ai_search`、`cex_square_list_live_replay` |
| **闪兑** | 1 | `cex_fc_list_fc_currency_pairs` |

### Private MCP（`/mcp/exchange` — OAuth2，400+ 工具）

> **注意**：私有端点不包含公开市场数据工具。如需查询行情，请使用 `/mcp`。

| 业务线 | Scope | 主要工具 |
|--------|-------|----------|
| **现货** | profile / trade | 账户、订单、成交、批量订单、计划委托、倒计时撤单、交叉强平 |
| **合约** | profile / trade | 账户、仓位、订单、成交、双向持仓、追踪委托、计划委托、BBO 订单 |
| **杠杆** | profile / trade | 杠杆账户、借贷、自动还款、统一杠杆借贷 |
| **期权** | profile / trade | 账户、仓位、订单、MMP 设置 |
| **交割** | profile / trade | 账户、仓位、订单、计划委托 |
| **钱包** | wallet | 总资产、划转、充值、提现、充值地址、子账户余额、零头兑换 |
| **统一账户** | account | 统一账户、模式、借贷、风险单元、可借额度、抵押品、杠杆配置 |
| **子账户** | account | 创建/列表/锁定/解锁 SA、API Key |
| **账户管理** | account | 账户详情、主 Key、限频、借币费率、STP 组 |
| **返佣** | profile | 代理/合作伙伴/经纪商返佣历史、用户信息 |
| **闪兑** | profile / trade | `cex_fc_list_fc_currency_pairs`、`cex_fc_list_fc_orders`、`cex_fc_create_fc_order_v1`、多币种闪兑 等 |
| **理财** | profile / trade | 双币/结构化/余币宝产品、订单、ETH2 兑换、出借记录 |
| **Alpha** | profile / trade | Alpha 账户、订单、报价/下单 |
| **TradFi** | profile / trade | 品类、交易对、MT5 账户、资产、订单、仓位 |
| **跨所** | profile / trade | 规则交易对、账户、仓位、订单、划转、兑换 |
| **P2P** | profile / trade | 用户信息、广告、聊天、订单、确认付款/收款 |
| **活动中心** | profile | 活动类型、推荐活动、用户参与状态 |
| **卡券** | profile | 用户卡券列表、卡券详情 |
| **新币挖矿** | profile / trade | LaunchPool 项目列表、质押/赎回、奖励记录 |
| **广场** | market | AI 搜索、直播回放 |
| **新手福利** | profile | 新手资格检查、任务列表和奖励 |

按 scope 分组详见 [授权说明](#授权说明oauth2)。完整参数见 [gate-exchange 详情](gate-exchange/gate-exchange-mcp_zh.md)。

### DEX — 登录认证

| 工具 | 描述 |
|------|------|
| `dex_auth_google_login_start` | 发起 Google OAuth 登录流程 |
| `dex_auth_google_login_poll` | 轮询登录状态，成功后返回 mcp_token |
| `dex_auth_login_google_wallet` | 使用 Google OAuth 授权码登录 |
| `dex_auth_gate_login_start` | 发起 Gate 登录流程 |
| `dex_auth_gate_login_poll` | 轮询 Gate 登录状态，成功后返回 mcp_token |
| `dex_auth_login_gate_wallet` | 使用 Gate 授权码登录 |
| `dex_auth_logout` | 注销当前 MCP 会话 |

### DEX — 钱包

| 工具 | 描述 |
|------|------|
| `dex_wallet_get_addresses` | 获取各链钱包地址（EVM、SOL） |
| `dex_wallet_get_token_list` | 获取代币余额（含价格） |
| `dex_wallet_get_total_asset` | 获取总资产价值及 24h 变动 |
| `dex_wallet_sign_message` | 使用钱包私钥对消息签名 |
| `dex_wallet_sign_transaction` | 使用钱包私钥对原始交易签名 |

### DEX — 链配置与交易

| 工具 | 描述 |
|------|------|
| `dex_chain_config` | 获取链配置信息（networkKey、chainID、endpoint） |
| `dex_tx_gas` | 估算 Gas 价格和 Gas 用量 |
| `dex_tx_transfer_preview` | 签名前预览转账详情 |
| `dex_tx_approve_preview` | 签名前预览代币授权（ERC-20 / SPL approve） |
| `dex_tx_get_sol_unsigned` | 构建未签名 Solana SOL 转账 |
| `dex_tx_send_raw_transaction` | 广播已签名交易至链上 |
| `dex_tx_quote` | 获取兑换报价（含路由与价格影响） |
| `dex_tx_swap` | 一键兑换：报价 → 构建 → 签名 → 提交 |
| `dex_tx_swap_detail` | 按订单 ID 查询兑换状态 |
| `dex_tx_list` / `dex_tx_detail` / `dex_tx_history_list` | 交易历史与兑换记录 |

### DEX — 市场数据与代币信息

| 工具 | 描述 |
|------|------|
| `dex_market_get_kline` | K 线（蜡烛图）数据 |
| `dex_market_get_tx_stats` | 交易量和交易员统计 |
| `dex_market_get_pair_liquidity` | 流动性池添加/移除事件 |
| `dex_token_list_swap_tokens` | 查询指定链上可兑换的代币 |
| `dex_token_list_cross_chain_bridge_tokens` | 查询跨链桥可桥接的目标代币 |
| `dex_token_get_coin_info` | 代币信息：价格、市值、持仓分布 |
| `dex_token_ranking` | 24h 涨幅榜/跌幅榜 |
| `dex_token_get_coins_range_by_created_at` | 按创建时间发现新代币 |
| `dex_token_get_risk_info` | 安全审计：蜜罐、买卖税、黑名单 |

### DEX — Agentic 与 RPC

| 工具 | 描述 |
|------|------|
| `dex_agentic_report` | 上报 Agentic 钱包地址用于追踪 |
| `dex_rpc_call` | 通用 JSON-RPC 调用，直接与链节点交互 |

完整 DEX 工具参数见 [gate-dex-mcp](gate-dex/gate-dex-mcp_zh.md)。Agentic Wallet 子集文档（认证、钱包、市场数据、资源）见 [gate-agentic-wallet-mcp](gate-dex/gate-agentic-wallet-mcp_zh.md)。

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

A: **仅在使用 CEX 交易和 DEX 钱包时需要**。`/mcp`、`/mcp/info`、`/mcp/news` 完全公开，无需账号。`/mcp/exchange`（CEX 交易、余额、划转）须通过 Gate OAuth2 登录。`/mcp/dex`（链上钱包、兑换）须通过 Google 或 Gate OAuth 登录。

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
