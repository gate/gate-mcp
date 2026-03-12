# Gate DEX for AI

支持链：ETH、BSC、Base、Solana、Arbitrum、Polygon、Avalanche、Fantom、zkSync、Linea、Optimism、Sui、Blast、Tron、Merlin、World、Eni、Bera、GateLayer、TON。

## 1. 登录认证

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `auth_google_login_start` | 发起 Google OAuth 登录流程，返回验证 URL 供用户在浏览器中打开 | - |
| `auth_google_login_poll` | 轮询登录状态；返回 `pending` / `ok`（含 mcp_token）/ `error` | `flow_id` |
| `auth_login_google_wallet` | 使用 Google OAuth 授权码登录 | `code`, `redirect_url` |
| `auth_logout` | 注销当前 MCP 会话 | `mcp_token` |

## 2. 钱包

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `wallet_get_addresses` | 获取各链钱包地址（EVM、SOL 等） | `account_id` |
| `wallet_get_token_list` | 获取代币余额（含价格），支持分页 | `network_keys`, `page`, `page_size` |
| `wallet_get_total_asset` | 获取总资产价值及 24h 变动 | `account_id` |
| `wallet_sign_message` | 使用钱包私钥对消息签名（32 字节 hex） | `chain`, `message` |
| `wallet_sign_transaction` | 使用钱包私钥对原始交易签名 | `chain`, `raw_tx` |

## 3. 链配置

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `chain_config` | 获取链配置信息（networkKey、chainID、endpoint） | `chain` |

## 4. 交易

### 4.1 转账与 Gas

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `tx_gas` | 估算 Gas 价格和 Gas 用量 | `chain`, `from`, `to`, `value`, `data` |
| `tx_transfer_preview` | 签名前预览转账详情（支持 EVM 原生币/ERC-20 及 Solana SOL/SPL） | `from`, `to`, `amount`, `chain`, `token`, `token_contract`, `token_mint` |
| `tx_get_sol_unsigned` | 构建含最新 blockhash 的未签名 Solana SOL 转账 | `from`, `to`, `amount`, `priority_fee_micro_lamports` |
| `tx_send_raw_transaction` | 广播已签名交易至链上 | `chain`, `signed_tx` |

### 4.2 兑换（Swap）

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `tx_quote` | 获取兑换报价（含路由、价格影响和 Gas 估算），调用 `tx_swap` 前必须先调用 | `chain_id_in`, `chain_id_out`, `token_in`, `token_out`, `amount`, `slippage`, `user_wallet`, `native_in`, `native_out` |
| `tx_swap` | 一键兑换：报价 → 构建 → 签名 → 提交 | `chain_id_in`, `chain_id_out`, `token_in`, `token_out`, `amount`, `slippage`, `user_wallet`, `account_id`, `native_in`, `native_out` |
| `tx_swap_detail` | 按订单 ID 查询兑换订单状态 | `tx_order_id` |

### 4.3 交易历史

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `tx_list` | 获取交易历史列表 | `account_id`, `page_num`, `page_size` |
| `tx_detail` | 按哈希获取交易详情 | `hash_id` |
| `tx_history_list` | 获取兑换/跨链桥交易历史（支持分页） | `account_id`, `src_chain`, `dst_chain`, `page_num`, `page_size` |

## 5. 市场数据

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `market_get_kline` | 获取 K 线（蜡烛图）数据 | `chain`, `token_address`, `period`(1m/5m/1h/4h/1d), `limit` |
| `market_get_tx_stats` | 获取交易量和交易员统计数据（5m/1h/4h/24h） | `chain`, `token_address` |
| `market_get_pair_liquidity` | 获取流动性池添加/移除事件 | `chain`, `token_address`, `page_index`, `page_size` |

## 6. 代币信息

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `token_get_coin_info` | 获取代币信息：价格、市值、供应量、持仓分布 | `chain`, `address`, `include_holders` |
| `token_ranking` | 获取 24h 涨幅榜/跌幅榜 | `direction`(desc/asc), `chain`, `top_n` |
| `token_get_coins_range_by_created_at` | 按创建时间范围发现新代币 | `start`, `end`, `chain`, `limit` |
| `token_get_risk_info` | 安全审计：蜜罐、买卖税、黑名单、权限 | `chain`, `address` |
