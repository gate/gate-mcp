# Gate Exchange for AI

## 1. 现货交易 (Spot Trading)

### 1.1 账户查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `get_spot_accounts` | 获取现货账户余额 | `currency`（可选，不填返回全部） |
| `list_spot_account_book` | 获取现货账户流水 | `currency`, `from`, `to`, `limit` |
| `get_spot_fee` | 获取交易费率 | `currency_pair` |
| `get_spot_batch_fee` | 批量获取交易费率 | `currency_pairs`（交易对列表） |

### 1.2 订单管理

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `create_spot_order` | 创建现货订单 | `currency_pair`, `side`(buy/sell), `amount`, `price`, `type`(limit/market), `time_in_force` |
| `list_spot_orders` | 查询订单列表 | `currency_pair`, `status`(open/finished), `side`, `limit` |
| `get_spot_order` | 查询单个订单 | `order_id`, `currency_pair` |
| `cancel_spot_order` | 取消单个订单 | `order_id`, `currency_pair` |
| `cancel_all_spot_orders` | 取消所有订单 | `currency_pair`（可选）, `side`（可选） |
| `amend_spot_order` | 修改订单 | `order_id`, `currency_pair`, `price`, `amount` |

### 1.3 成交查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `list_spot_my_trades` | 查询个人成交记录 | `currency_pair`, `order_id`, `limit`, `from`, `to` |

### 1.4 市场数据

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `get_spot_tickers` | 获取行情数据 | `currency_pair`（可选，不填返回全部） |
| `get_spot_order_book` | 获取深度数据 | `currency_pair`, `limit`（深度档位） |
| `get_spot_candlesticks` | 获取 K 线数据 | `currency_pair`, `interval`(1m/5m/1h/1d 等), `limit` |
| `get_spot_trades` | 获取公开成交 | `currency_pair`, `limit` |

## 2. 合约交易 (Futures Trading)

### 2.1 账户与仓位

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `get_futures_accounts` | 获取合约账户信息 | `settle`（结算币种，usdt/btc） |
| `list_futures_account_book` | 获取合约账户流水 | `settle`, `type`, `limit` |
| `get_futures_position` | 获取单个仓位 | `settle`, `contract` |
| `list_futures_positions` | 获取所有仓位 | `settle`, `holding`（是否只返回持仓） |
| `get_futures_dual_mode_position` | 获取双向持仓 | `settle`, `contract` |

### 2.2 仓位设置

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `update_futures_position_leverage` | 修改杠杆倍数 | `settle`, `contract`, `leverage` |
| `update_futures_position_margin` | 修改保证金 | `settle`, `contract`, `change`（增减金额） |
| `update_futures_position_risk_limit` | 修改风险限额 | `settle`, `contract`, `risk_limit` |
| `update_futures_position_cross_mode` | 切换全仓/逐仓 | `settle`, `contract`, `cross_leverage_limit` |
| `update_futures_dual_comp_position_cross_mode` | 双向持仓切换模式 | `settle`, `contract`, `mode`(CROSS/ISOLATED) |
| `update_futures_dual_mode_position_leverage` | 双向持仓修改杠杆 | `settle`, `contract`, `leverage` |
| `update_futures_dual_mode_position_margin` | 双向持仓修改保证金 | `settle`, `contract`, `change` |
| `update_futures_dual_mode_position_risk_limit` | 双向持仓修改风险限额 | `settle`, `contract`, `risk_limit` |
| `set_futures_dual_mode` | 设置双向持仓模式 | `settle`, `dual_mode`(true/false) |

### 2.3 订单管理

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `create_futures_order` | 创建合约订单 | `settle`, `contract`, `size`（正数做多/负数做空）, `price`, `tif`(gtc/ioc/poc/fok), `reduce_only` |
| `list_futures_orders` | 查询订单列表 | `settle`, `contract`, `status`(open/finished), `limit` |
| `get_futures_order` | 查询单个订单 | `settle`, `order_id` |
| `get_futures_orders_timerange` | 按时间范围查询订单 | `settle`, `contract`, `from`, `to` |
| `cancel_futures_order` | 取消单个订单 | `settle`, `order_id` |
| `cancel_all_futures_orders` | 取消所有订单 | `settle`, `contract`, `side`（可选） |
| `amend_futures_order` | 修改订单 | `settle`, `order_id`, `price`, `size` |

### 2.4 成交查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `list_futures_my_trades` | 查询个人成交记录 | `settle`, `contract`, `order`, `limit` |
| `get_futures_my_trades_timerange` | 按时间范围查询成交 | `settle`, `contract`, `from`, `to` |
| `list_futures_liq_orders` | 查询强平订单 | `settle`, `contract`, `limit` |

### 2.5 市场数据

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `get_futures_tickers` | 获取合约行情 | `settle`, `contract`（可选） |
| `get_futures_order_book` | 获取合约深度 | `settle`, `contract`, `limit` |
| `get_futures_candlesticks` | 获取合约 K 线 | `settle`, `contract`, `interval`, `limit` |
| `get_futures_trades` | 获取公开成交 | `settle`, `contract`, `limit` |
| `get_futures_funding_rate` | 获取资金费率 | `settle`, `contract`, `limit` |
| `get_futures_premium_index` | 获取溢价指数 | `settle`, `contract` |
| `get_futures_fee` | 获取合约手续费 | `settle`, `contract` |

### 2.6 合约信息

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `get_futures_contract` | 获取单个合约信息 | `settle`, `contract` |
| `list_futures_contracts` | 获取所有合约列表 | `settle` |
| `list_futures_risk_limit_tiers` | 获取风险限额档位 | `settle`, `contract` |

## 3. 统一账户 (Unified Account)

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `get_unified_accounts` | 获取统一账户信息 | `currency`（可选） |
| `get_unified_mode` | 获取统一账户模式 | - |
| `set_unified_mode` | 设置统一账户模式 | `mode` |
| `get_unified_borrowable` | 获取可借额度 | `currency` |
| `get_unified_risk_units` | 获取风险单元 | - |
| `list_unified_loans` | 获取统一账户借贷记录 | `currency`, `limit` |

## 4. 资金划转 (Transfer)

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `create_transfer` | 账户间划转 | `currency`, `from`（账户类型）, `to`（账户类型）, `amount` |
| `get_transfer_order_status` | 查询划转状态 | `tx_id` |
| `get_total_balance` | 获取总资产 | `currency`（可选） |
| `get_wallet_fee` | 获取提现费用 | `currency` |
| `list_deposits` | 获取充值记录 | `currency`, `limit` |
| `list_withdrawals` | 获取提现记录 | `currency`, `limit` |

## 5. 子账户 (Sub Account)

### 5.1 子账户管理

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `create_sub_account` | 创建子账户 | `login_name`, `email`, `password` |
| `get_sub_account` | 获取子账户信息 | `user_id` |
| `list_sub_accounts` | 获取子账户列表 | `limit` |
| `lock_sub_account` | 锁定子账户 | `user_id` |
| `unlock_sub_account` | 解锁子账户 | `user_id` |
| `get_sub_account_unified_mode` | 获取子账户统一账户模式 | `user_id` |

### 5.2 子账户 API Key

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `create_sub_account_key` | 创建子账户 API Key | `user_id`, `name`, `perms` |
| `get_sub_account_key` | 获取子账户 API Key | `user_id`, `key` |
| `list_sub_account_keys` | 获取子账户 API Key 列表 | `user_id` |
| `update_sub_account_key` | 更新子账户 API Key | `user_id`, `key`, `perms` |
| `delete_sub_account_key` | 删除子账户 API Key | `user_id`, `key` |

### 5.3 子账户划转

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `create_sub_account_transfer` | 主账户与子账户划转 | `currency`, `sub_account`, `direction`(to/from), `amount` |
| `create_sub_account_to_sub_account_transfer` | 子账户间划转 | `currency`, `sub_account_from`, `sub_account_to`, `amount` |

## 6. 公共数据 (Public Data)

### 6.1 币种信息

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `get_currency` | 获取单个币种信息 | `currency` |
| `list_currencies` | 获取所有币种列表 | - |
| `get_currency_pair` | 获取单个交易对信息 | `currency_pair` |
| `list_currency_pairs` | 获取所有交易对列表 | - |