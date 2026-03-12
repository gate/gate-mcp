# Gate Exchange MCP 工具

> 本文档描述的是**私有端点**（`/mcp/exchange`，需 OAuth2）上的工具。
> 公开市场数据工具（无需认证）请参见 [README 中的 Public MCP 部分](../README_zh.md#public-mcpmcp--无需认证)。
>
> **OAuth2 Scopes**: `market`, `profile`, `trade`, `wallet`, `account`

所有工具均使用 `cex_` 前缀。

## 1. 现货交易

### 1.1 账户查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_spot_get_spot_accounts` | 获取现货账户余额 | `currency`（可选，不填返回全部） |
| `cex_spot_list_spot_account_book` | 获取现货账户流水 | `currency`, `limit`, `page`, `from`, `to`, `type`, `code` |
| `cex_spot_get_spot_fee` | 获取交易费率 | `currency_pair` |
| `cex_spot_get_spot_batch_fee` | 批量获取交易费率 | `currency_pairs`（必填，最多 50 个交易对） |

### 1.2 订单管理

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_spot_create_spot_order` | 创建现货订单 | `currency_pair`（必填）, `side`（必填，buy/sell）, `amount`（必填）, `price`, `type`(limit/market), `account`, `time_in_force`, `iceberg`, `auto_borrow`, `auto_repay`, `text`, `stp_act`, `action_mode`, `slippage` |
| `cex_spot_create_spot_batch_orders` | 批量创建现货订单 | `orders`（必填，JSON 数组） |
| `cex_spot_list_spot_orders` | 查询订单列表 | `currency_pair`（必填）, `status`(open/finished), `page`, `limit`, `account`, `from`, `to`, `side` |
| `cex_spot_get_spot_order` | 查询单个订单 | `order_id`（必填）, `currency_pair`（必填）, `account` |
| `cex_spot_cancel_spot_order` | 取消单个订单 | `order_id`（必填）, `currency_pair`（必填）, `account`, `action_mode` |
| `cex_spot_cancel_all_spot_orders` | 取消指定交易对所有订单 | `currency_pair`（必填）, `side`, `account`, `action_mode` |
| `cex_spot_cancel_spot_batch_orders` | 批量取消订单 | `order_ids`（必填）, `currency_pair`（必填） |
| `cex_spot_amend_spot_order` | 修改订单 | `order_id`（必填）, `currency_pair`, `account`, `amount`, `price`, `amend_text`, `action_mode` |
| `cex_spot_amend_spot_batch_orders` | 批量修改订单 | `orders`（必填，JSON 数组） |

### 1.3 成交查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_spot_list_spot_my_trades` | 查询个人成交记录 | `currency_pair`, `limit`, `page`, `order_id`, `account`, `from`, `to` |

## 2. 合约交易

### 2.1 账户与仓位

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_get_fx_accounts` | 获取合约账户信息 | `settle`（必填，usdt/btc） |
| `cex_fx_list_fx_account_book` | 获取合约账户流水 | `settle`（必填）, `contract`, `limit`, `offset`, `from`, `to`, `type` |
| `cex_fx_get_fx_position` | 获取单个仓位 | `settle`（必填）, `contract`（必填） |
| `cex_fx_list_fx_positions` | 获取所有仓位 | `settle`（必填）, `holding`, `limit`, `offset` |
| `cex_fx_get_fx_dual_position` | 获取双向持仓 | `settle`（必填）, `contract`（必填） |

### 2.2 仓位设置

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_update_fx_position_leverage` | 修改杠杆倍数 | `settle`（必填）, `contract`（必填）, `leverage`（必填）, `cross_leverage_limit`, `pid` |
| `cex_fx_update_fx_position_margin` | 修改保证金 | `settle`（必填）, `contract`（必填）, `change`（必填，正数增加/负数减少） |
| `cex_fx_update_fx_position_risk_limit` | 修改风险限额 | `settle`（必填）, `contract`（必填）, `risk_limit`（必填） |
| `cex_fx_update_fx_position_cross_mode` | 切换全仓/逐仓 | `settle`（必填）, `contract`, `mode`（必填，CROSS/ISOLATED） |
| `cex_fx_update_fx_dual_position_cross_mode` | 双向持仓切换模式 | `settle`（必填）, `contract`（必填）, `mode`（必填，CROSS/ISOLATED） |
| `cex_fx_update_fx_dual_position_leverage` | 双向持仓修改杠杆 | `settle`（必填）, `contract`（必填）, `leverage`（必填）, `cross_leverage_limit` |
| `cex_fx_update_fx_dual_position_margin` | 双向持仓修改保证金 | `settle`（必填）, `contract`（必填）, `change`（必填）, `dual_side`（必填，long/short） |
| `cex_fx_update_fx_dual_position_risk_limit` | 双向持仓修改风险限额 | `settle`（必填）, `contract`（必填）, `risk_limit`（必填） |
| `cex_fx_set_fx_dual` | 设置双向持仓模式 | `settle`（必填）, `dual_mode`（必填，true/false） |

### 2.3 订单管理

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_create_fx_order` | 创建合约订单 | `settle`（必填）, `contract`（必填）, `size`（必填，正数做多/负数做空）, `price`, `tif`(gtc/ioc/poc/fok), `close`, `reduce_only`, `iceberg`, `text`, `auto_size`, `stp_act`, `market_order_slip_ratio`, `pos_margin_mode` |
| `cex_fx_create_fx_batch_orders` | 批量创建合约订单 | `settle`（必填）, `orders`（必填，JSON 数组） |
| `cex_fx_list_fx_orders` | 查询订单列表 | `settle`（必填）, `status`（必填，open/finished）, `contract`, `limit`, `offset`, `last_id` |
| `cex_fx_get_fx_order` | 查询单个订单 | `settle`（必填）, `order_id`（必填） |
| `cex_fx_cancel_fx_order` | 取消单个订单 | `settle`（必填）, `order_id`（必填） |
| `cex_fx_cancel_all_fx_orders` | 取消所有订单 | `settle`（必填）, `contract`（必填）, `side`, `exclude_reduce_only`, `text` |
| `cex_fx_cancel_fx_batch_orders` | 批量取消订单 | `settle`（必填）, `order_ids`（必填） |
| `cex_fx_amend_fx_order` | 修改订单 | `settle`（必填）, `order_id`（必填）, `size`, `price`, `amend_text`, `text` |
| `cex_fx_amend_fx_batch_orders` | 批量修改订单 | `settle`（必填）, `orders`（必填，JSON 数组）, `order_id`, `text` |

### 2.4 成交查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_list_fx_my_trades` | 查询个人成交记录 | `settle`（必填）, `contract`, `limit`, `offset`, `last_id`, `order` |
| `cex_fx_get_fx_my_trades_timerange` | 按时间范围查询成交 | `settle`（必填）, `contract`, `from`, `to`, `limit`, `offset`, `role` |

### 2.5 费率与风险

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_get_fx_fee` | 获取合约手续费 | `settle`（必填）, `contract` |
| `cex_fx_list_fx_risk_limit_tiers` | 获取风险限额档位 | `settle`（必填）, `contract`, `limit`, `offset` |

## 3. 统一账户

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_unified_get_unified_accounts` | 获取统一账户信息 | `currency`, `sub_uid` |
| `cex_unified_get_unified_mode` | 获取统一账户模式 | - |
| `cex_unified_set_unified_mode` | 设置统一账户模式 | `mode`（必填）, `usdt_futures`, `spot_hedge`, `use_funding`, `options` |
| `cex_unified_get_unified_borrowable` | 获取可借额度 | `currency`（必填） |
| `cex_unified_get_unified_risk_units` | 获取风险单元 | - |
| `cex_unified_list_unified_loans` | 获取统一账户借贷记录 | `currency`, `limit`, `page`, `type` |

## 4. 钱包与划转

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_wallet_create_transfer` | 账户间划转 | `currency`（必填）, `from`（必填）, `to`（必填）, `amount`（必填）, `currency_pair`（杠杆需要）, `settle`（合约/交割需要） |
| `cex_wallet_get_transfer_order_status` | 查询划转状态 | `client_order_id`, `tx_id` |
| `cex_wallet_get_total_balance` | 获取总资产 | `currency`（可选，BTC/CNY/USD/USDT） |
| `cex_wallet_get_wallet_fee` | 获取交易手续费 | `currency_pair`, `settle`（合约手续费） |
| `cex_wallet_list_deposits` | 获取充值记录 | `currency`, `limit`, `offset`, `from`, `to` |
| `cex_wallet_list_withdrawals` | 获取提现记录 | `currency`, `limit`, `offset`, `from`, `to` |
| `cex_wallet_create_sa_transfer` | 主账户与子账户划转 | `sub_account`（必填）, `currency`（必填）, `amount`（必填）, `direction`（必填，to/from）, `sub_account_type`, `client_order_id` |
| `cex_wallet_create_sa_to_sa_transfer` | 子账户间划转 | `currency`（必填）, `sub_account_from`（必填）, `sub_account_from_type`（必填）, `sub_account_to`（必填）, `sub_account_to_type`（必填）, `amount`（必填） |

## 5. 子账户

### 5.1 子账户管理

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_sa_create_sa` | 创建子账户 | `login_name`（必填）, `password`, `email`, `remark` |
| `cex_sa_get_sa` | 获取子账户信息 | `user_id`（必填） |
| `cex_sa_list_sas` | 获取子账户列表 | `type` |
| `cex_sa_lock_sa` | 锁定子账户 | `user_id`（必填） |
| `cex_sa_unlock_sa` | 解锁子账户 | `user_id`（必填） |
| `cex_sa_get_sa_unified_mode` | 获取子账户统一账户模式 | - |

### 5.2 子账户 API Key

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_sa_create_sa_key` | 创建子账户 API Key | `user_id`（必填）, `mode`, `name`, `perms`（JSON 数组）, `ip_whitelist` |
| `cex_sa_get_sa_key` | 获取子账户 API Key | `user_id`（必填）, `key`（必填） |
| `cex_sa_list_sa_keys` | 获取子账户 API Key 列表 | `user_id`（必填） |
| `cex_sa_update_sa_key` | 更新子账户 API Key | `user_id`（必填）, `key`（必填）, `mode`, `name`, `perms`（JSON 数组）, `ip_whitelist` |
| `cex_sa_delete_sa_key` | 删除子账户 API Key | `user_id`（必填）, `key`（必填） |
