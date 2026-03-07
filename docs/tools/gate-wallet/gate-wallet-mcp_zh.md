# Gate Wallet for AI

## 1. 登录认证

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `auth.google_login_start` | 发起 Google OAuth 登录流程，返回验证 URL | - |
| `auth.google_login_poll` | 轮询登录状态，成功后返回 mcp_token | - |
| `auth.login_google_wallet` | 使用 Google OAuth 授权码登录 | `code` |
| `auth.refresh_token` | 刷新登录会话 | - |
| `auth.logout` | 注销当前会话 | - |

## 2. 钱包

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `wallet.get_addresses` | 获取各链钱包地址 | `chain`（EVM / Solana） |
| `wallet.get_token_list` | 获取代币余额（含价格）| `chain`, `page`, `limit` |
| `wallet.get_total_asset` | 获取总资产价值及 24h 变动 | - |
| `wallet.sign_message` | 使用钱包私钥对消息签名 | `chain`, `message` |
| `wallet.sign_transaction` | 使用钱包私钥对原始交易签名 | `chain`, `tx` |

## 3. 链配置

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `chain.config` | 获取链配置信息（链 ID、功能支持等） | `chain` |

## 4. 交易

### 4.1 转账与 Gas

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `tx.gas` | 估算 Gas 价格和 Gas 用量 | `chain`, `tx` |
| `tx.transfer_preview` | 签名前预览转账详情 | `chain`, `to`, `amount`, `token` |
| `tx.get_sol_unsigned` | 构建含最新区块哈希的未签名 Solana SOL 转账 | `to`, `amount` |
| `tx.send_raw_transaction` | 广播已签名交易至链上 | `chain`, `raw_tx` |

### 4.2 兑换

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `tx.quote` | 获取兑换报价（含路由、价格影响和 Gas 估算） | `chain`, `from_token`, `to_token`, `amount` |
| `tx.swap` | 一键兑换：报价 → 构建 → 签名 → 提交 | `chain`, `from_token`, `to_token`, `amount` |
| `tx.swap_detail` | 按订单 ID 查询兑换订单状态 | `order_id` |

### 4.3 交易历史

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `tx.list` | 获取交易历史列表 | `chain`, `limit` |
| `tx.detail` | 按哈希获取交易详情 | `chain`, `hash` |
| `tx.history_list` | 获取兑换 / 跨链桥交易历史 | `chain`, `limit` |

## 5. 市场数据

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `market_get_kline` | 获取 K 线（蜡烛图）数据 | `chain`, `pair`, `interval`(1m/5m/1h/4h/1d), `limit` |
| `market_get_tx_stats` | 获取交易量和交易员统计数据 | `chain`, `pair`, `interval`(5m/1h/4h/24h) |
| `market_get_pair_liquidity` | 获取流动性池添加 / 移除事件 | `chain`, `pair`, `limit` |
| `market_list_swap_tokens` | 列出指定链上可兑换的代币 | `chain` |
| `market_list_cross_chain_bridge_tokens` | 列出可跨链桥接的代币 | `from_chain`, `to_chain` |

## 6. 代币信息

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `token_get_coin_info` | 获取代币信息：价格、市值、供应量、持仓分布 | `chain`, `address` |
| `token_ranking` | 获取 24h 涨幅榜 / 跌幅榜 | `chain`, `type`(gainers/losers) |
| `token_get_coins_range_by_created_at` | 按创建时间范围发现新代币 | `chain`, `from`, `to` |
| `token_get_risk_info` | 安全审计：蜜罐、买卖税、黑名单、权限 | `chain`, `address` |
