# Gate MCP 服务器

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MCP](https://img.shields.io/badge/MCP-协议-blue)](https://modelcontextprotocol.io)

[English](README.md) | [中文](README_zh.md)

一个 [MCP (Model Context Protocol)](https://modelcontextprotocol.io) 服务器，将 Gate 交易 API 以工具形式提供给 AI 智能体使用。

## 功能特性

- **公开数据** — 现货/合约普通与 RPI 深度、期权、交割、杠杆、理财、Alpha、CFD、股票、抵押借贷参数、统一账户试算、广场（无需 OAuth）
- **交易与策略** — 现货/合约/期权/交割交易、POV、Chase、条件单、Trail、量化机器人
- **账户与钱包** — 余额、账户间划转、充值提现记录、充值地址、统一账户及钱包中的子账户余额/划转
- **理财与配置** — 定投、普通/股票双币、定期和余币宝、多币种抵押借贷、闪兑及资产配置优化
- **CFD 与股票** — 分别提供市场信息和经授权的账户、订单、仓位、资金操作
- **DEX** — 链上钱包、兑换（单链及跨链）、代币信息、市场数据，支持 20+ 条链
- **Info** — 币种发现、行情快照、技术/平台指标、链上与宏观数据
- **News** — 加密资讯、社交洞察、市场事件、预测市场
- **Docs** — 研报、论文与文档检索
- **OAuth2 授权** — 交易及私有工具需 Gate 账号登录

## MCP 端点

服务提供以下 MCP 端点：

| 端点 | 认证 | 工具 |
|------|------|------|
| `https://api.gatemcp.ai/mcp` | 无 | CEX 公开数据及试算（83 个工具；范围见下方业务表） |
| `https://api.gatemcp.ai/mcp/exchange` | OAuth2 | CEX 私有交易与账户工具（源码注册上限 310，实际按授权及运行策略过滤） |
| `https://api.gatemcp.ai/mcp/dex` | Google / Gate OAuth | DEX 钱包与兑换（33 个工具：链上钱包、Swap、代币信息、市场数据、Agentic、RPC，支持 20+ 条链） |
| `https://api.gatemcp.ai/mcp/info` | 无 | 币种信息与分析（32 个工具：币种、快照、趋势、链上、平台指标、宏观、盘口细节） |
| `https://api.gatemcp.ai/mcp/open/info` | 无 | Gate Info 送审面（恰好 7 个工具：币种资料、市场概览/快照、K 线、盘口、近期成交） |
| `https://api.gatemcp.ai/mcp/news` | 无 | 资讯与研究（18 个工具：新闻/UGC/X/网页、公告、情绪、事件、预测市场） |
| `https://api.gatemcp.ai/mcp/docs` | 无 | 文档研究（3 个工具：研究检索、币种研报、论文） |

- **仅查行情** → 使用 `/mcp`（无需 Gate 账号）
- **CEX 交易、余额、划转** → 使用 `/mcp/exchange`（需 Gate OAuth2）
- **DEX 钱包、兑换、链上操作** → 使用 `/mcp/dex`（需 Google / Gate OAuth）
- **币种信息、技术分析** → 使用 `/mcp/info`（无需认证）
- **ChatGPT / OpenAI Apps Gate Info 上架** → 使用 `/mcp/open/info`（7 工具 allowlist；无需认证）
- **资讯、公告** → 使用 `/mcp/news`（无需认证）
- **研报与论文** → 使用 `/mcp/docs`（无需认证）

传输协议：Streamable HTTP（支持 SSE 回退）。

## 授权说明（OAuth2）

**`/mcp/exchange` 需要 Gate OAuth2；`/mcp/dex` 需要 Google 或 Gate OAuth。** `/mcp`、`/mcp/info`、`/mcp/open/info`、`/mcp/news`、`/mcp/docs` 无需任何认证。

### mcporter

> **前置条件**：Node.js >= 18、npm。完整安装步骤见 [快速开始 - mcporter](#mcporter--openclaw)。

```bash
# 添加私有 MCP（交易，需 OAuth）
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp/exchange --auth oauth

# 授权登录（打开浏览器）
mcporter auth gate-mcp
```

### scope 说明（用于 `/mcp/exchange`）

`base`、`spot_trade`、`futures_trade`、`earn`、`cfd`、`stock` 的要求按工具和账户类型区分；`base` 在普通匹配中包含 `read` 和 `asset`，不是纯只读。普通 Token 保留历史 scope 的逐工具 OR 兼容，Agentic 的查询、交易和禁止调用规则另有覆盖。`mcp:tools` 不能替代业务 scope。

逐工具权限见 [完整工具表](gate-exchange/gateapi-mcp-service-tools_zh.md)，接入与 PKCE resource 约定见 [授权说明](gate-exchange/gate-exchange-mcp_zh.md#authorization)。当前连接的 `tools/list` 决定可见工具；服务默认 scope 不代表所有环境授权页的实际申请范围。

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

Claude Desktop 可使用远程 custom connector；不要求所有用户使用本地代理。连接 `https://api.gatemcp.ai/mcp` 查询公开数据，连接 `https://api.gatemcp.ai/mcp/exchange` 并完成 Gate OAuth2 使用授权范围内的私有工具。

本仓 Python stdio 代理仅作为公开行情兼容选项，不实现 OAuth 或 SSE 解析。步骤见 [Claude Desktop 配置指南](docs/setup-claude-desktop-zh.md)。

### 替代方案：gate-local-mcp（本地 stdio + API Key）

本地开发且无需 OAuth 时，可使用 [gate-local-mcp](https://github.com/gate/gate-local-mcp)（npm 包名：`gate-mcp`）— 以 stdio MCP 方式运行；公开行情可不配密钥，交易/钱包等需设置 `GATE_API_KEY` / `GATE_API_SECRET`。在客户端中配置为命令式 MCP（如 `"command": "npx", "args": ["-y", "gate-mcp"]`）。默认注册 **384** 个工具、**22** 个模块（spot、futures、delivery、margin、wallet、account、options、earn、flash_swap、unified、sub_account、multi_collateral_loan、p2p、tradfi、crossex、alpha、rebate、activity、coupon、launch、square、welfare）。可用环境变量 `GATE_MODULES` 或参数 `--modules=spot,futures` 裁剪模块；`GATE_READONLY=true` 或 `--readonly` 仅保留只读工具。

**注意：** gate-local-mcp 注册到 MCP 的工具名会做缩写（如 `futures`→`fx`、`delivery`→`dc`、`sub_account`→`sa`），与远端 `api.gatemcp.ai` 私有端点上的命名不一致；请以 `tools/list` 返回或 [gate-local-mcp-tools.md](gate-exchange/gate-local-mcp-tools.md) 为准。

完整工具列表：[gate-local-mcp-tools.md](gate-exchange/gate-local-mcp-tools.md)。

#### LobeHub（桌面端）

[LobeHub MCP 市场](https://lobehub.com/zh/mcp/gate-gate-mcp) 中插件标识为 `gate-gate-mcp`，**实际 npm 包名为 `gate-mcp`**，安装时请使用 `npx -y gate-mcp`，不要使用 `gate-gate-mcp`。

按 [LobeHub 自定义 MCP 说明](https://lobehub.com/zh/docs/usage/community/custom-mcp)，stdio 技能需在**桌面客户端**配置，并通过 **环境变量** 注入 Gate API 密钥（交易、钱包、账户类工具）。在「添加自定义技能」中可使用 **导入 JSON 配置**，例如：

**仅公开行情（无需密钥）：**

```json
{
  "mcpServers": {
    "gate-mcp": {
      "command": "npx",
      "args": ["-y", "gate-mcp"],
      "type": "stdio"
    }
  }
}
```

**含 API Key 认证：**

```json
{
  "mcpServers": {
    "gate-mcp": {
      "command": "npx",
      "args": ["-y", "gate-mcp"],
      "type": "stdio",
      "env": {
        "GATE_API_KEY": "your-api-key",
        "GATE_API_SECRET": "your-api-secret"
      }
    }
  }
}
```

可在 `env` 中按需增加 `GATE_MODULES`、`GATE_READONLY`、`GATE_BASE_URL`（测试网等）。保存前请点击 **测试连接**。

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

<a id="cex-public"></a>
### Public MCP（`/mcp` — 无需 OAuth，83 个工具）

工具清单参考服务版本 `v1.16.7`，核对日期 2026-11-04；公开名称集合已与该日期线上目录核对。以下按两端点分别统计，私有端点不包含公开工具。

| 业务域 | 公开 `/mcp` | 私有 `/mcp/exchange` |
|---|---:|---:|
| 现货 | 10 | 27 |
| 永续合约 | 18 | 54 |
| 杠杆 | 3 | 17 |
| 期权 | 12 | 17 |
| 交割合约 | 8 | 21 |
| 钱包 | 1 | 22 |
| 统一账户 | 5 | 22 |
| 账户管理 | 0 | 10 |
| 返佣 | 0 | 10 |
| 闪兑 | 1 | 8 |
| 理财 | 7 | 42 |
| Alpha | 3 | 6 |
| CFD／传统金融 | 4 | 16 |
| 股票 | 5 | 11 |
| 多币种抵押借贷 | 4 | 8 |
| 量化机器人／AIHub | 0 | 12 |
| 资产配置优化／AssetSwap | 0 | 7 |
| 广场 | 2 | 0 |
| **合计** | **83** | **310** |

<a id="cex-private"></a>
### Private MCP（`/mcp/exchange` — OAuth2，源码注册上限 310 个工具）

实际可见集合受 Token 权限、账户类型与运行策略影响，不是任意用户均可看到 310 个工具。远程服务已撤下子账户/API Key 管理、CrossEx、P2P、活动、卡券、福利及 Launch 系列；钱包子账户余额与划转不随管理工具一起删除。

完整名称与逐工具权限见 [远程工具表](gate-exchange/gateapi-mcp-service-tools_zh.md)，参数、请求示例、Trail 响应及错误处理见 [CEX 详情](gate-exchange/gate-exchange-mcp_zh.md)。

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

### Info（`/mcp/info` — 32 个工具，无需认证）

公开、只读的行情与研究数据。分类总览（完整参数表见 [gate-info-mcp](gate-info/gate-info-mcp_zh.md)）：

| 分类 | 工具 |
|------|------|
| 币种 | `info_coin_get_coin_info`、`info_coin_search_coins`、`info_coin_get_coin_rankings` |
| 行情快照 | `info_marketsnapshot_get_market_snapshot`、`info_marketsnapshot_batch_market_snapshot`、`info_marketsnapshot_get_market_overview`、`info_marketsnapshot_get_institutional_metrics` |
| 行情趋势 | `info_markettrend_get_kline`、`info_markettrend_get_indicator_history`、`info_markettrend_get_technical_analysis` |
| 链上 | `info_onchain_get_address_info`、`info_onchain_get_address_transactions`、`info_onchain_get_transaction`、`info_onchain_get_token_onchain` |
| 合规 | `info_compliance_check_token_security` |
| 平台指标 | `info_platformmetrics_get_platform_info`、`info_platformmetrics_search_platforms`、`info_platformmetrics_get_defi_overview`、`info_platformmetrics_get_stablecoin_info`、`info_platformmetrics_get_bridge_metrics`、`info_platformmetrics_get_yield_pools`、`info_platformmetrics_get_platform_history`、`info_platformmetrics_get_exchange_reserves`、`info_platformmetrics_get_liquidation_heatmap`、`info_platformmetrics_get_cex_orderbook_depth`、`info_platformmetrics_get_chain_activity` |
| 宏观 | `info_macro_get_macro_indicator`、`info_macro_get_economic_calendar`、`info_macro_get_macro_summary` |
| 盘口细节 | `info_marketdetail_get_orderbook`、`info_marketdetail_get_recent_trades`、`info_marketdetail_get_kline` |

### Open Info（`/mcp/open/info` — 7 个工具，无需认证）

ChatGPT / OpenAI Apps 送审 allowlist。完整参数表见 [gate-open-info-mcp](gate-open-info/gate-open-info-mcp_zh.md)。

| 分类 | 工具 |
|------|------|
| 币种 | `info_coin_get_coin_info` |
| 行情快照 | `info_marketsnapshot_get_market_overview`、`info_marketsnapshot_get_market_snapshot`、`info_marketsnapshot_batch_market_snapshot` |
| 盘口细节 | `info_marketdetail_get_kline`、`info_marketdetail_get_orderbook`、`info_marketdetail_get_recent_trades` |

### News（`/mcp/news` — 18 个工具，无需认证）

公开、只读的资讯与社交研究。分类总览（完整参数表见 [gate-news-mcp](gate-news/gate-news-mcp_zh.md)）：

| 分类 | 工具 |
|------|------|
| 资讯快讯 | `news_feed_search_news`、`news_feed_web_search`、`news_feed_search_x`、`news_feed_search_ugc`、`news_feed_get_exchange_announcements`、`news_feed_get_social_sentiment`、`news_feed_get_mention_burst`、`news_feed_get_hot_topics` |
| 事件 | `news_events_get_latest_events`、`news_events_get_event_detail`、`news_events_explain_market_move`、`news_events_get_market_move_report`、`news_events_list_market_move_reports` |
| 预测市场 | `news_prediction_get_volume_delta_ranking`、`news_prediction_get_fastest_rising_ranking`、`news_prediction_get_market_orderbook`、`news_prediction_search_events`、`news_prediction_get_event_signal` |

---

## 常见问题

### Q: 需要 Gate 账号吗？

A: **仅在使用 CEX 交易和 DEX 钱包时需要**。`/mcp`、`/mcp/info`、`/mcp/open/info`、`/mcp/news`、`/mcp/docs` 完全公开，无需账号。`/mcp/exchange`（CEX 交易、余额、划转）须通过 Gate OAuth2 登录。`/mcp/dex`（链上钱包、兑换）须通过 Google 或 Gate OAuth 登录。

### Q: 支持交易吗？

A: 支持。连接 `/mcp/exchange` 并完成 Gate OAuth2；按工具及账户类型授权现货、合约、CFD、股票、理财或策略操作。公开数据另连 `/mcp`；子账户管理已撤下，钱包中的子账户余额和划转另按权限提供。

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

可通过本仓库的 [Issues](https://github.com/gate/gate-mcp/issues) 反馈文档问题。

## 许可证

[MIT](LICENSE) © gate.com
