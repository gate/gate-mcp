# CEX MCP 工具与参数说明

[English](gate-exchange-mcp.md) | [中文](gate-exchange-mcp_zh.md)

工具清单参考服务版本 `v1.16.7`，核对日期为 2026-11-04。公开 `/mcp` 为 **83** 个工具；私有 `/mcp/exchange` 的源码注册上限为 **310** 个。私有端点不包含公开工具，实际可见集合取决于授权与运行策略。表中每个工具名后均标明端点。

普通 OAuth 与 Agentic 的逐工具权限及全部 393 个名称见 [完整工具表](gateapi-mcp-service-tools_zh.md)。下表保留常用参数，不能替代当前连接的 `tools/list` Schema；未列出的可选参数、默认值和限制应从该 Schema 读取。此处仅说明远程服务，不改变独立 gate-local-mcp 的能力。 必填标记指当前 MCP Schema；下游仍可能按业务条件要求其他字段。

远程服务已撤下子账户管理/API Key 管理、CrossEx、P2P、活动、卡券、福利及 Launch 系列。钱包中仍注册的子账户余额与划转工具不属于子账户管理下线范围。旧 `cex_tradfi_*` 名称不可调用，CFD 使用 `cex_cfd_*`。旧结构化产品及 ETH2 工具名不在当前目录；请按当前理财工具契约调用。

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

## 1. 现货交易

### 1.1 账户查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_spot_get_spot_accounts` (/mcp/exchange) | 获取现货账户余额 | `currency`（可选）；未指定时使用 `page`（默认 1）、`limit`（默认 10，上限 1000），返回 `accounts` 和 `pagination`；指定币种时不分页。 |
| `cex_spot_list_spot_account_book` (/mcp/exchange) | 获取现货账户流水 | `currency`, `limit`, `page`, `from`, `to`, `type`, `code` |
| `cex_spot_get_spot_fee` (/mcp/exchange) | 获取交易费率 | `currency_pair` |
| `cex_spot_get_spot_batch_fee` (/mcp/exchange) | 批量获取交易费率 | `currency_pairs`（必填，最多 50 个交易对） |
| `cex_spot_list_all_open_orders` (/mcp/exchange) | 查询所有未成交订单 | `account`, `page`, `limit` |
| `cex_spot_get_spot_price_triggered_order` (/mcp/exchange) | 获取计划委托订单 | `order_id` |
| `cex_spot_list_spot_price_triggered_orders` (/mcp/exchange) | 查询计划委托列表 | `status`（必填）, `market`, `account`, `limit`, `offset` |
| `cex_spot_get_spot_insurance_history` (/mcp) | 获取保险基金历史 | `business`, `currency`, `from`, `to`（必填）；`limit`, `page` |

### 1.2 订单管理

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_spot_create_spot_order` (/mcp/exchange) | 创建现货订单 | `currency_pair`（必填）, `side`（必填，buy/sell）, `amount`（必填）, `price`, `type`(limit/market), `account`, `time_in_force`, `iceberg`, `auto_borrow`, `auto_repay`, `text`, `stp_act`, `action_mode`, `slippage`; `stop_profit`, `stop_loss`, `trade_quote` |
| `cex_spot_create_spot_batch_orders` (/mcp/exchange) | 批量创建现货订单 | `orders`（必填，JSON 数组） |
| `cex_spot_list_spot_orders` (/mcp/exchange) | 查询订单列表 | `currency_pair`（必填）, `status`(open/finished), `page`, `limit`, `account`, `from`, `to`, `side` |
| `cex_spot_get_spot_order` (/mcp/exchange) | 查询单个订单 | `order_id`（必填）, `currency_pair`（必填）, `account` |
| `cex_spot_cancel_spot_order` (/mcp/exchange) | 取消单个订单 | `order_id`（必填）, `currency_pair`（必填）, `account`, `action_mode` |
| `cex_spot_cancel_all_spot_orders` (/mcp/exchange) | 按过滤条件撤销现货订单 | `currency_pair`（当前 MCP Schema 中可选）, `side`, `account`, `action_mode`; `trade_quote` |
| `cex_spot_cancel_spot_batch_orders` (/mcp/exchange) | 批量取消订单 | `order_ids`（必填）, `currency_pair`（必填） |
| `cex_spot_amend_spot_order` (/mcp/exchange) | 修改订单 | `order_id`（必填）, `currency_pair`, `account`, `amount`, `price`, `amend_text`, `action_mode`; `stop_profit`, `stop_loss` |
| `cex_spot_amend_spot_batch_orders` (/mcp/exchange) | 批量修改订单 | `orders`（必填，JSON 数组） |
| `cex_spot_create_spot_price_triggered_order` (/mcp/exchange) | 创建计划委托 | `body`（必填 JSON 字符串，内含 `market`、`trigger`、`put` 及适用选项） |
| `cex_spot_cancel_spot_price_triggered_order` (/mcp/exchange) | 取消计划委托 | `order_id` |
| `cex_spot_cancel_spot_price_triggered_order_list` (/mcp/exchange) | 撤销全部匹配条件单 | `market`, `account`；撤销匹配范围内的全部条件单，不是按 `order_ids` 批量撤销 |
| `cex_spot_countdown_cancel_all_spot` (/mcp/exchange) | 倒计时撤单 | `body`（必填 JSON 字符串）；内含 `timeout` 和可选 `currency_pair` |
| `cex_spot_create_cross_liquidate_order` (/mcp/exchange) | 创建交叉强平订单 | `body`（必填 JSON 字符串）；内含 `currency_pair`、`amount`、`price` 及可选 `text`、`action_mode` |

### 1.3 成交查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_spot_list_spot_my_trades` (/mcp/exchange) | 查询个人成交记录 | `currency_pair`, `limit`, `page`, `order_id`, `account`, `from`, `to` |

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_spot_cancel_spot_pov_order` (/mcp/exchange) | 撤销单个现货 POV 订单 |
| `cex_spot_cancel_spot_pov_orders` (/mcp/exchange) | 撤销现货 POV 订单 |
| `cex_spot_create_spot_pov_order` (/mcp/exchange) | 创建现货 POV 订单 |
| `cex_spot_get_spot_pov_order` (/mcp/exchange) | 查询现货 POV 订单详情 |
| `cex_spot_list_spot_pov_orders` (/mcp/exchange) | 查询现货 POV 订单列表 |
| `cex_spot_list_spot_rpi_order_book` (/mcp) | 查询现货 RPI 深度 |


## 2. 合约交易

### 2.1 账户与仓位

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_get_fx_accounts` (/mcp/exchange) | 获取合约账户信息 | `settle`（必填，btc/usdt/usd1） |
| `cex_fx_list_fx_account_book` (/mcp/exchange) | 获取合约账户流水 | `settle`（必填）, `contract`, `limit`, `offset`, `from`, `to`, `type` |
| `cex_fx_get_fx_position` (/mcp/exchange) | 获取单个仓位 | `settle`（必填）, `contract`（必填） |
| `cex_fx_list_fx_positions` (/mcp/exchange) | 获取所有仓位 | `settle`（必填）, `holding`, `limit`, `offset` |
| `cex_fx_get_fx_dual_position` (/mcp/exchange) | 获取双向持仓 | `settle`（必填）, `contract`（必填） |

### 2.2 仓位设置

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_update_fx_position_leverage` (/mcp/exchange) | 修改杠杆倍数 | `settle`（必填）, `contract`（必填）, `leverage`（必填）, `cross_leverage_limit`, `pid` |
| `cex_fx_update_fx_position_margin` (/mcp/exchange) | 修改保证金 | `settle`（必填）, `contract`（必填）, `change`（必填，正数增加/负数减少） |
| `cex_fx_update_fx_position_risk_limit` (/mcp/exchange) | 修改风险限额 | `settle`（必填）, `contract`（必填）, `risk_limit`（必填） |
| `cex_fx_update_fx_position_cross_mode` (/mcp/exchange) | 切换全仓/逐仓 | `settle`（必填）, `contract`（当前 MCP Schema 必填）, `mode`（必填，CROSS/ISOLATED） |
| `cex_fx_update_fx_dual_position_cross_mode` (/mcp/exchange) | 双向持仓切换模式 | `settle`（必填）, `contract`（必填）, `mode`（必填，CROSS/ISOLATED） |
| `cex_fx_update_fx_dual_position_leverage` (/mcp/exchange) | 双向持仓修改杠杆 | `settle`（必填）, `contract`（必填）, `leverage`（必填）, `cross_leverage_limit` |
| `cex_fx_update_fx_dual_position_margin` (/mcp/exchange) | 双向持仓修改保证金 | `settle`（必填）, `contract`（必填）, `change`（必填）, `dual_side`（必填，long/short） |
| `cex_fx_update_fx_dual_position_risk_limit` (/mcp/exchange) | 双向持仓修改风险限额 | `settle`（必填）, `contract`（必填）, `risk_limit`（必填） |
| `cex_fx_set_fx_dual` (/mcp/exchange) | 设置双向持仓模式 | `settle`（必填）, `dual_mode`（必填，true/false） |

### 2.3 订单管理

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_create_fx_order` (/mcp/exchange) | 创建合约订单 | `settle`（必填）, `contract`（必填）, `size`（必填，正数做多/负数做空）, `price`, `tif`(gtc/ioc/poc/fok), `close`, `reduce_only`, `iceberg`, `text`, `auto_size`, `stp_act`, `market_order_slip_ratio`, `pos_margin_mode`; `action_mode`, `pid`, `tpsl_sl_bbo_type`, `tpsl_sl_trigger_price`, `tpsl_tp_bbo_type`, `tpsl_tp_trigger_price` |
| `cex_fx_create_fx_batch_orders` (/mcp/exchange) | 批量创建合约订单 | `settle`（必填）, `orders`（必填，JSON 数组） |
| `cex_fx_list_fx_orders` (/mcp/exchange) | 查询订单列表 | `settle`（必填）, `status`（必填，open/finished）, `contract`, `limit`, `offset`, `last_id` |
| `cex_fx_get_fx_order` (/mcp/exchange) | 查询单个订单 | `settle`（必填）, `order_id`（必填） |
| `cex_fx_cancel_fx_order` (/mcp/exchange) | 取消单个订单 | `settle`（必填）, `order_id`（必填）; `action_mode` |
| `cex_fx_cancel_all_fx_orders` (/mcp/exchange) | 按过滤条件撤销合约订单 | `settle`（必填）, `contract`（可选；不指定时不限于单个合约）, `side`, `exclude_reduce_only`, `text`; `action_mode` |
| `cex_fx_cancel_fx_batch_orders` (/mcp/exchange) | 批量取消订单 | `settle`（必填）, `order_ids`（必填） |
| `cex_fx_amend_fx_order` (/mcp/exchange) | 修改订单 | `settle`（必填）, `order_id`（必填）, `size`, `price`, `amend_text`, `text`; `action_mode` |
| `cex_fx_amend_fx_batch_orders` (/mcp/exchange) | 批量修改订单 | `settle`（必填）、`orders`（必填 JSON 数组）；`order_id`／`text` 放在适用的各个订单项中 |

### 2.4 成交查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_list_fx_my_trades` (/mcp/exchange) | 查询个人成交记录 | `settle`（必填）, `contract`, `limit`, `offset`, `last_id`, `order` |
| `cex_fx_get_fx_my_trades_timerange` (/mcp/exchange) | 按时间范围查询成交 | `settle`（必填）, `contract`, `from`, `to`, `limit`, `offset`, `role` |

### 2.5 费率与风险

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_fx_get_fx_fee` (/mcp/exchange) | 获取合约手续费 | `settle`（必填）, `contract` |
| `cex_fx_list_fx_risk_limit_tiers` (/mcp) | 获取风险限额档位 | `settle`（必填）, `contract`, `limit`, `offset` |

### 2.6 合约扩展工具

| 工具名称 | 说明 |
|------|-------------|
| `cex_fx_get_fx_orders_with_time_range` (/mcp/exchange) | 按时间范围查询订单 |
| `cex_fx_get_leverage` (/mcp/exchange) | 获取杠杆设置 |
| `cex_fx_list_position_close` (/mcp/exchange) | 平仓记录 |
| `cex_fx_list_auto_deleverages` (/mcp/exchange) | 自动减仓记录 |
| `cex_fx_list_price_triggered_orders` (/mcp/exchange) / `cex_fx_get_fx_price_triggered_order` (/mcp/exchange) | 计划委托 |
| `cex_fx_get_trail_orders` (/mcp/exchange) / `cex_fx_get_trail_order_detail` (/mcp/exchange) / `cex_fx_get_trail_order_change_log` (/mcp/exchange) | 追踪委托 |
| `cex_fx_create_fx_bbo_order` (/mcp/exchange) | 创建 BBO 订单 |
| `cex_fx_create_fx_price_triggered_order` (/mcp/exchange) / `cex_fx_cancel_fx_price_triggered_order` (/mcp/exchange) / `cex_fx_cancel_fx_price_triggered_order_list` (/mcp/exchange) / `cex_fx_update_fx_price_triggered_order` (/mcp/exchange) | 计划委托管理 |
| `cex_fx_countdown_cancel_all_fx` (/mcp/exchange) | 倒计时撤单 |
| `cex_fx_create_trail_order` (/mcp/exchange) / `cex_fx_update_trail_order` (/mcp/exchange) / `cex_fx_stop_trail_order` (/mcp/exchange) | 追踪委托管理 |
| `cex_fx_stop_all_trail_orders` (/mcp/exchange) | 停止所有追踪委托 |
| `cex_fx_get_fx_risk_limit_table` (/mcp) | 按表ID查询风险限额阶梯 |
| `cex_fx_list_liquidated_orders` (/mcp/exchange) | 查询用户强平历史 |
| `cex_fx_list_positions_timerange` (/mcp/exchange) | 按时间范围查询仓位历史 |
| `cex_fx_set_position_mode` (/mcp/exchange) | 设置持仓模式（单向/双向） |
| `cex_fx_update_fx_contract_position_leverage` (/mcp/exchange) | 更新指定保证金模式的杠杆 |

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_fx_create_chase_order` (/mcp/exchange) | 创建追价委托 |
| `cex_fx_get_chase_order_detail` (/mcp/exchange) | 查询追价委托详情 |
| `cex_fx_get_chase_orders` (/mcp/exchange) | 查询追价委托列表 |
| `cex_fx_list_fx_adl_risk_states` (/mcp) | 查询市场 ADL 风险状态 |
| `cex_fx_list_fx_contracts_all` (/mcp) | 查询所有合约（含下架） |
| `cex_fx_list_fx_rpi_order_book` (/mcp) | 查询合约 RPI 深度 |
| `cex_fx_stop_all_chase_orders` (/mcp/exchange) | 批量停止追价委托 |
| `cex_fx_stop_chase_order` (/mcp/exchange) | 停止单个追价委托 |


## 3. 杠杆

| 工具名称 | 说明 |
|------|-------------|
| `cex_margin_list_margin_accounts` (/mcp/exchange) / `cex_margin_list_margin_account_book` (/mcp/exchange) | 杠杆账户、流水 |
| `cex_margin_list_funding_accounts` (/mcp/exchange) / `cex_margin_get_auto_repay_status` (/mcp/exchange) | 资金账户、自动还款 |
| `cex_margin_get_margin_transferable` (/mcp/exchange) / `cex_margin_get_user_margin_tier` (/mcp/exchange) | 可转、档位 |
| `cex_margin_list_uni_loans` (/mcp/exchange) / `cex_margin_list_uni_loan_records` (/mcp/exchange) / `cex_margin_list_uni_loan_interest_records` (/mcp/exchange) | 统一杠杆借贷 |
| `cex_margin_get_uni_borrowable` (/mcp/exchange) / `cex_margin_list_cross_margin_loans` (/mcp/exchange) / `cex_margin_list_cross_margin_repayments` (/mcp/exchange) | 可借额度、全仓借贷 |
| `cex_margin_set_auto_repay` (/mcp/exchange) / `cex_margin_set_user_market_leverage` (/mcp/exchange) | 自动还款、杠杆 |
| `cex_margin_create_uni_loan` (/mcp/exchange) | 创建统一杠杆借贷 |

## 4. 期权

| 工具名称 | 说明 |
|------|-------------|
| `cex_options_list_my_options_settlements` (/mcp/exchange) / `cex_options_list_options_account` (/mcp/exchange) / `cex_options_list_options_account_book` (/mcp/exchange) | 账户、结算 |
| `cex_options_list_options_positions` (/mcp/exchange) / `cex_options_get_options_position` (/mcp/exchange) / `cex_options_list_options_position_close` (/mcp/exchange) | 仓位 |
| `cex_options_list_options_orders` (/mcp/exchange) / `cex_options_get_options_order` (/mcp/exchange) / `cex_options_list_my_options_trades` (/mcp/exchange) | 订单、成交 |
| `cex_options_get_options_mmp` (/mcp/exchange) | MMP（做市商保护） |
| `cex_options_create_options_order` (/mcp/exchange) / `cex_options_cancel_options_orders` (/mcp/exchange) / `cex_options_cancel_options_order` (/mcp/exchange) | 订单管理 |
| `cex_options_amend_options_order` (/mcp/exchange) | 修改期权订单（价格/数量） |
| `cex_options_countdown_cancel_all_options` (/mcp/exchange) / `cex_options_set_options_mmp` (/mcp/exchange) / `cex_options_reset_options_mmp` (/mcp/exchange) | 倒计时、MMP |

## 5. 交割

| 工具名称 | 说明 |
|------|-------------|
| `cex_dc_list_dc_accounts` (/mcp/exchange) / `cex_dc_list_dc_account_book` (/mcp/exchange) | 账户、流水 |
| `cex_dc_list_dc_positions` (/mcp/exchange) / `cex_dc_get_dc_position` (/mcp/exchange) | 仓位 |
| `cex_dc_list_dc_orders` (/mcp/exchange) / `cex_dc_get_dc_order` (/mcp/exchange) | 订单 |
| `cex_dc_get_my_dc_trades` (/mcp/exchange) / `cex_dc_list_dc_position_close` (/mcp/exchange) / `cex_dc_list_dc_liquidates` (/mcp/exchange) / `cex_dc_list_dc_settlements` (/mcp/exchange) | 成交、结算 |
| `cex_dc_list_price_triggered_dc_orders` (/mcp/exchange) / `cex_dc_get_price_triggered_dc_order` (/mcp/exchange) | 计划委托 |
| `cex_dc_update_dc_position_margin` (/mcp/exchange) / `cex_dc_update_dc_position_leverage` (/mcp/exchange) / `cex_dc_update_dc_position_risk_limit` (/mcp/exchange) | 仓位设置 |
| `cex_dc_create_dc_order` (/mcp/exchange) / `cex_dc_cancel_dc_orders` (/mcp/exchange) / `cex_dc_cancel_dc_order` (/mcp/exchange) | 订单管理 |
| `cex_dc_create_price_triggered_dc_order` (/mcp/exchange) / `cex_dc_cancel_price_triggered_dc_order` (/mcp/exchange) / `cex_dc_cancel_price_triggered_dc_order_list` (/mcp/exchange) | 计划委托管理 |

## 6. 统一账户

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_unified_get_unified_accounts` (/mcp/exchange) | 获取统一账户信息 | `currency`, `sub_uid` |
| `cex_unified_get_unified_mode` (/mcp/exchange) | 获取统一账户模式 | - |
| `cex_unified_set_unified_mode` (/mcp/exchange) | 设置统一账户模式 | `mode`（必填）、`settings`（JSON 字符串）；兼容 `usdt_futures`、`spot_hedge`、`use_funding`、`options`；显式 settings 优先。 |
| `cex_unified_get_unified_borrowable` (/mcp/exchange) | 获取可借额度 | `currency`（必填） |
| `cex_unified_get_unified_risk_units` (/mcp/exchange) | 获取风险单元 | - |
| `cex_unified_list_unified_loans` (/mcp/exchange) | 获取统一账户借贷记录 | `currency`, `limit`, `page`, `type` |
| `cex_unified_calculate_portfolio_margin` (/mcp) / `cex_unified_create_unified_loan` (/mcp/exchange) | 组合保证金、创建借贷 | 见 `tools/list` |
| `cex_unified_get_history_loan_rate` (/mcp) / `cex_unified_get_unified_borrowable_list` (/mcp/exchange) / `cex_unified_get_unified_estimate_rate` (/mcp/exchange) | 利率、可借列表 | 见 `tools/list` |
| `cex_unified_get_unified_transferable` (/mcp/exchange) / `cex_unified_get_unified_transferables` (/mcp/exchange) | 可转额度 | 见 `tools/list` |
| `cex_unified_get_user_leverage_currency_config` (/mcp/exchange) / `cex_unified_get_user_leverage_currency_setting` (/mcp/exchange) / `cex_unified_set_user_leverage_currency_setting` (/mcp/exchange) | 杠杆配置 | 见 `tools/list` |
| `cex_unified_list_currency_discount_tiers` (/mcp) / `cex_unified_list_loan_margin_tiers` (/mcp) | 折扣档位 | 见 `tools/list` |
| `cex_unified_list_unified_currencies` (/mcp) / `cex_unified_list_unified_loan_interest_records` (/mcp/exchange) / `cex_unified_list_unified_loan_records` (/mcp/exchange) | 币种、借贷记录 | 见 `tools/list` |
| `cex_unified_set_unified_collateral` (/mcp/exchange) | 设置抵押品 | 见 `tools/list` |

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_unified_create_quick_repayment` (/mcp/exchange) | 执行快捷还款 |
| `cex_unified_get_estimated_quick_repayment` (/mcp/exchange) | 查询快捷还款估算 |
| `cex_unified_get_unified_delta_neutral` (/mcp/exchange) | 查询 Delta 中性策略模式 |
| `cex_unified_set_unified_delta_neutral` (/mcp/exchange) | 设置 Delta 中性策略模式 |
| `cex_unified_set_user_leverage` (/mcp/exchange) | 设置用户借款币种杠杆 |


## 7. 钱包与划转

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_wallet_get_transfer_order_status` (/mcp/exchange) | 查询划转状态 | `client_order_id`, `tx_id` |
| `cex_wallet_get_total_balance` (/mcp/exchange) | 获取总资产 | `currency`（可选，BTC/CNY/USD/USDT） |
| `cex_wallet_get_wallet_fee` (/mcp/exchange) | 获取交易手续费 | `currency_pair`, `settle`（合约手续费） |
| `cex_wallet_list_deposits` (/mcp/exchange) | 获取充值记录 | `currency`, `limit`, `offset`, `from`, `to` |
| `cex_wallet_list_withdrawals` (/mcp/exchange) | 获取提现记录 | `currency`, `limit`, `offset`, `from`, `to`, `asset_class`, `withdraw_id`, `withdraw_order_id` |
| `cex_wallet_create_sa_transfer` (/mcp/exchange) | 主账户与子账户划转 | `sub_account`（必填）, `currency`（必填）, `amount`（必填）, `direction`（必填，to/from）, `sub_account_type`, `client_order_id` |
| `cex_wallet_create_sa_to_sa_transfer` (/mcp/exchange) | 子账户间划转 | `currency`（必填）, `sub_account_from`（必填）, `sub_account_from_type`（必填）, `sub_account_to`（必填）, `sub_account_to_type`（必填）, `amount`（必填） |
| `cex_wallet_get_deposit_address` (/mcp/exchange) / `cex_wallet_list_currency_chains` (/mcp) | 充值地址、链列表 | 见 `tools/list` |
| `cex_wallet_list_sa_balances` (/mcp/exchange) / `cex_wallet_list_sa_cross_margin_balances` (/mcp/exchange) / `cex_wallet_list_sa_fx_balances` (/mcp/exchange) / `cex_wallet_list_sa_margin_balances` (/mcp/exchange) / `cex_wallet_list_sa_transfers` (/mcp/exchange) | 子账户余额、划转 | 见 `tools/list` |
| `cex_wallet_list_small_balance` (/mcp/exchange) / `cex_wallet_list_small_balance_history` (/mcp/exchange) / `cex_wallet_convert_small_balance` (/mcp/exchange) | 零头兑换 | 见 `tools/list` |

### 补充工具

| 工具（端点） | 说明 | 主要参数 |
|---|---|---|
| `cex_wallet_create_transfer` (/mcp/exchange) | 交易账户之间划转 | `currency`、`from`、`to`、`amount`（必填）；涉及 margin 时还需 `currency_pair`，涉及 futures/delivery 时还需 `settle` |
| `cex_wallet_get_transfer` (/mcp/exchange) | 查询交易账户划转 | `tx_id`（必填字符串） |


## 8. 账户管理

| 工具名称 | 说明 |
|------|-------------|
| `cex_account_get_account_detail` (/mcp/exchange) | 获取账户详情 |
| `cex_account_get_account_main_keys` (/mcp/exchange) | 获取主 Key |
| `cex_account_get_account_rate_limit` (/mcp/exchange) | 获取限频 |
| `cex_account_get_debit_fee` (/mcp/exchange) / `cex_account_set_debit_fee` (/mcp/exchange) | GT 手续费抵扣设置；修改时 `enabled` 必填且为布尔值，显式 false 表示关闭 |
| `cex_account_list_stp_groups` (/mcp/exchange) / `cex_account_list_stp_groups_users` (/mcp/exchange) | STP 组 |
| `cex_account_create_stp_group` (/mcp/exchange) | 创建 STP 组 |
| `cex_account_add_stp_group_users` (/mcp/exchange) / `cex_account_delete_stp_group_users` (/mcp/exchange) | 管理 STP 用户 |

## 9. 返佣

| 工具名称 | 说明 |
|------|-------------|
| `cex_rebate_partner_commissions_history` (/mcp/exchange) / `cex_rebate_partner_sub_list` (/mcp/exchange) / `cex_rebate_partner_transaction_history` (/mcp/exchange) | 合作伙伴返佣 |
| `cex_rebate_broker_commission_history` (/mcp/exchange) / `cex_rebate_broker_transaction_history` (/mcp/exchange) | 经纪商返佣 |
| `cex_rebate_user_info` (/mcp/exchange) / `cex_rebate_user_sub_relation` (/mcp/exchange) | 用户返佣信息 |
| `cex_rebate_get_partner_application_recent` (/mcp/exchange) | 获取最近30天合伙人申请记录 |
| `cex_rebate_get_partner_eligibility` (/mcp/exchange) | 检查用户是否有合伙人申请资格 |

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_rebate_get_partner_agent_data_aggregated` (/mcp/exchange) | 查询合作伙伴代理聚合统计 |


## 10. 闪兑

| 工具名称 | 说明 |
|------|-------------|
| `cex_fc_list_fc_currency_pairs` (/mcp) | 闪兑交易对列表 |
| `cex_fc_list_fc_orders` (/mcp/exchange) / `cex_fc_get_fc_order` (/mcp/exchange) | 查询订单 |
| `cex_fc_preview_fc_order_v1` (/mcp/exchange) | 一对一闪兑预览 |
| `cex_fc_create_fc_order_v1` (/mcp/exchange) | 创建一对一闪兑订单 |
| `cex_fc_preview_fc_multi_currency_many_to_one_order` (/mcp/exchange) | 多对一闪兑预览 |
| `cex_fc_preview_fc_multi_currency_one_to_many_order` (/mcp/exchange) | 一对多闪兑预览 |
| `cex_fc_create_fc_multi_currency_many_to_one_order` (/mcp/exchange) | 创建多对一闪兑订单 |
| `cex_fc_create_fc_multi_currency_one_to_many_order` (/mcp/exchange) | 创建一对多闪兑订单 |

## 11. 理财

| 工具名称 | 说明 |
|------|-------------|
| `cex_earn_asset_list` (/mcp/exchange) / `cex_earn_award_list` (/mcp/exchange) | 资产、奖励 |
| `cex_earn_list_dual_balance` (/mcp/exchange) / `cex_earn_list_dual_orders` (/mcp/exchange) | 双币理财 |
| `cex_earn_order_list` (/mcp/exchange) | 理财订单列表 |
| `cex_earn_get_uni_currency` (/mcp) / `cex_earn_get_uni_interest` (/mcp/exchange) / `cex_earn_get_uni_interest_status` (/mcp/exchange) | 余币宝 |
| `cex_earn_list_uni_chart` (/mcp/exchange) / `cex_earn_list_uni_interest_records` (/mcp/exchange) / `cex_earn_list_uni_lend_records` (/mcp/exchange) | 余币宝记录 |
| `cex_earn_change_uni_lend` (/mcp/exchange) | 修改余币宝借出 |
| `cex_earn_list_earn_fixed_term_products` (/mcp) / `cex_earn_list_earn_fixed_term_products_by_asset` (/mcp) | 定期理财产品 |
| `cex_earn_list_earn_fixed_term_lends` (/mcp/exchange) / `cex_earn_list_earn_fixed_term_history` (/mcp/exchange) | 定期理财记录 |
| `cex_earn_create_earn_fixed_term_lend` (/mcp/exchange) / `cex_earn_create_earn_fixed_term_pre_redeem` (/mcp/exchange) | 定期理财操作 |

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_earn_add_position_auto_invest_plan` (/mcp/exchange) | 立即为定投计划加仓 |
| `cex_earn_create_auto_invest_plan` (/mcp/exchange) | 创建定投计划 |
| `cex_earn_create_uni_lend` (/mcp/exchange) | 创建借出或赎回 |
| `cex_earn_get_auto_invest_min_amount` (/mcp/exchange) | 查询最低定投金额 |
| `cex_earn_get_auto_invest_plan_detail` (/mcp/exchange) | 查询定投计划详情 |
| `cex_earn_get_dual_order_refund_preview` (/mcp/exchange) | 预览普通双币提前赎回 |
| `cex_earn_get_dual_project_recommend` (/mcp/exchange) | 查询普通双币推荐项目 |
| `cex_earn_get_dual_stock_order_refund_preview` (/mcp/exchange) | 预览股票双币赎回 |
| `cex_earn_get_dual_stock_project_recommend` (/mcp) | 查询股票双币推荐产品 |
| `cex_earn_list_auto_invest_coins` (/mcp/exchange) | 查询定投支持币种 |
| `cex_earn_list_auto_invest_config` (/mcp/exchange) | 查询定投币种配置 |
| `cex_earn_list_auto_invest_orders` (/mcp/exchange) | 查询定投执行订单详情 |
| `cex_earn_list_auto_invest_plan_records` (/mcp/exchange) | 查询定投执行记录 |
| `cex_earn_list_auto_invest_plans` (/mcp/exchange) | 查询定投计划列表 |
| `cex_earn_list_dual_stock_balance` (/mcp/exchange) | 查询股票双币资产统计 |
| `cex_earn_list_dual_stock_investment_plans` (/mcp) | 查询股票双币产品 |
| `cex_earn_list_dual_stock_orders` (/mcp/exchange) | 查询股票双币订单 |
| `cex_earn_modify_dual_order_reinvest` (/mcp/exchange) | 修改普通双币复投 |
| `cex_earn_modify_dual_stock_order_reinvest` (/mcp/exchange) | 修改股票双币复投 |
| `cex_earn_place_dual_order` (/mcp/exchange) | 创建普通双币订单 |
| `cex_earn_place_dual_order_refund` (/mcp/exchange) | 执行普通双币提前赎回 |
| `cex_earn_place_dual_stock_order` (/mcp/exchange) | 创建股票双币订单 |
| `cex_earn_place_dual_stock_order_refund` (/mcp/exchange) | 执行股票双币赎回 |
| `cex_earn_stop_auto_invest_plan` (/mcp/exchange) | 停止定投计划 |
| `cex_earn_swap_staking_coin` (/mcp/exchange) | 兑换理财质押币种 |
| `cex_earn_update_auto_invest_plan` (/mcp/exchange) | 修改定投计划 |


## 12. Alpha

| 工具名称 | 说明 |
|------|-------------|
| `cex_alpha_list_alpha_accounts` (/mcp/exchange) / `cex_alpha_list_alpha_account_book` (/mcp/exchange) | Alpha 账户 |
| `cex_alpha_list_alpha_orders` (/mcp/exchange) / `cex_alpha_get_alpha_order` (/mcp/exchange) | Alpha 订单 |
| `cex_alpha_quote_alpha_order` (/mcp/exchange) / `cex_alpha_place_alpha_order` (/mcp/exchange) | 报价、下单 |

## 13. CFD／传统金融

| 工具名称 | 说明 |
|------|-------------|
| `cex_cfd_query_categories` (/mcp) / `cex_cfd_query_symbols` (/mcp) / `cex_cfd_query_symbol_detail` (/mcp/exchange) | 品类、交易对 |
| `cex_cfd_query_symbol_kline` (/mcp) / `cex_cfd_query_symbol_ticker` (/mcp) | 行情数据 |
| `cex_cfd_query_mt5_account_info` (/mcp/exchange) / `cex_cfd_query_user_assets` (/mcp/exchange) | MT5 账户、资产 |
| `cex_cfd_query_transaction` (/mcp/exchange) / `cex_cfd_query_order_list` (/mcp/exchange) / `cex_cfd_query_order_history_list` (/mcp/exchange) | 交易、订单 |
| `cex_cfd_query_position_list` (/mcp/exchange) / `cex_cfd_query_position_history_list` (/mcp/exchange) | 仓位 |
| `cex_cfd_create_transaction` (/mcp/exchange) | CFD 资金划转 |
| `cex_cfd_create_tradfi_order` (/mcp/exchange) / `cex_cfd_delete_order` (/mcp/exchange) / `cex_cfd_update_order` (/mcp/exchange) | 订单管理 |
| `cex_cfd_close_position` (/mcp/exchange) / `cex_cfd_update_position` (/mcp/exchange) | 仓位管理 |

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_cfd_query_order_log` (/mcp/exchange) | 按日志 ID 查询订单详情 |
| `cex_cfd_query_symbol_commissions` (/mcp/exchange) | 查询品种佣金费率 |


## 14. 广场

| 工具名称 | 说明 |
|------|-------------|
| `cex_square_list_square_ai_search` (/mcp) | AI 搜索 Gate 广场帖子 |
| `cex_square_list_live_replay` (/mcp) | 搜索 Gate 直播和回放视频 |

## 15. 股票

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_stock_close_stock_position` (/mcp/exchange) | 股票平仓 |
| `cex_stock_create_stock_order` (/mcp/exchange) | 创建股票订单 |
| `cex_stock_create_stock_transaction` (/mcp/exchange) | 股票资金划转 |
| `cex_stock_delete_all_stock_orders` (/mcp/exchange) | 撤销全部股票挂单 |
| `cex_stock_delete_stock_order` (/mcp/exchange) | 撤销单个股票订单 |
| `cex_stock_query_stock_exchanges` (/mcp) | 查询支持的股票交易所 |
| `cex_stock_query_stock_fee_rate` (/mcp) | 查询日本及韩国股票费率 |
| `cex_stock_query_stock_order_book` (/mcp) | 查询股票盘口 |
| `cex_stock_query_stock_order_history` (/mcp/exchange) | 查询股票历史订单 |
| `cex_stock_query_stock_order_list` (/mcp/exchange) | 查询股票挂单 |
| `cex_stock_query_stock_positions` (/mcp/exchange) | 查询股票持仓 |
| `cex_stock_query_stock_symbol_detail` (/mcp) | 查询股票品种详情 |
| `cex_stock_query_stock_symbols` (/mcp) | 查询股票品种列表 |
| `cex_stock_query_stock_transactions` (/mcp/exchange) | 查询股票资金流水 |
| `cex_stock_query_stock_user_assets` (/mcp/exchange) | 查询股票资产 |
| `cex_stock_update_stock_order` (/mcp/exchange) | 修改股票订单 |


## 16. 多币种抵押借贷

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_mcl_create_multi_collateral` (/mcp/exchange) | 创建多币种抵押借贷订单 |
| `cex_mcl_get_multi_collateral_current_rate` (/mcp) | 查询币种当前利率 |
| `cex_mcl_get_multi_collateral_fix_rate` (/mcp) | 查询 7 天及 30 天固定利率 |
| `cex_mcl_get_multi_collateral_ltv` (/mcp) | 查询抵押率 |
| `cex_mcl_get_multi_collateral_order_detail` (/mcp/exchange) | 查询抵押借贷订单详情 |
| `cex_mcl_list_multi_collateral_currencies` (/mcp) | 查询支持借入及抵押的币种 |
| `cex_mcl_list_multi_collateral_orders` (/mcp/exchange) | 查询抵押借贷订单列表 |
| `cex_mcl_list_multi_collateral_records` (/mcp/exchange) | 查询抵押物调整记录 |
| `cex_mcl_list_multi_repay_records` (/mcp/exchange) | 查询还款记录 |
| `cex_mcl_list_user_currency_quota` (/mcp/exchange) | 查询用户币种抵押及借款额度 |
| `cex_mcl_operate_multi_collateral` (/mcp/exchange) | 增加或提取抵押物 |
| `cex_mcl_repay_mcl` (/mcp/exchange) | 执行多币种抵押借贷还款 |


## 17. 量化机器人／AIHub

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_bot_get_ai_hub_portfolio_detail` (/mcp/exchange) | 查询策略详情 |
| `cex_bot_get_ai_hub_portfolio_running` (/mcp/exchange) | 查询运行中的策略 |
| `cex_bot_get_ai_hub_strategy_recommend` (/mcp/exchange) | 查询 AIHub 策略推荐 |
| `cex_bot_post_ai_hub_contract_martingale_create` (/mcp/exchange) | 创建合约马丁策略 |
| `cex_bot_post_ai_hub_futures_grid_create` (/mcp/exchange) | 创建合约网格 |
| `cex_bot_post_ai_hub_fx_combo_create` (/mcp/exchange) | 创建合约拼盘 |
| `cex_bot_post_ai_hub_infinite_grid_create` (/mcp/exchange) | 创建无限网格 |
| `cex_bot_post_ai_hub_margin_grid_create` (/mcp/exchange) | 创建杠杆网格 |
| `cex_bot_post_ai_hub_portfolio_stop` (/mcp/exchange) | 停止单个运行策略 |
| `cex_bot_post_ai_hub_smart_position_create` (/mcp/exchange) | 创建智能调仓 |
| `cex_bot_post_ai_hub_spot_grid_create` (/mcp/exchange) | 创建现货网格 |
| `cex_bot_post_ai_hub_spot_martingale_create` (/mcp/exchange) | 创建现货马丁策略 |


## 18. 资产配置优化／AssetSwap

### 补充工具

| 工具（端点） | 说明 |
|---|---|
| `cex_assetswap_create_asset_swap_order_v1` (/mcp/exchange) | 创建资产配置优化订单 |
| `cex_assetswap_evaluate_asset_swap` (/mcp/exchange) | 资产配置优化估值 |
| `cex_assetswap_get_asset_swap_config` (/mcp/exchange) | 查询资产配置优化配置 |
| `cex_assetswap_get_asset_swap_order_v1` (/mcp/exchange) | 查询单个资产配置优化订单 |
| `cex_assetswap_list_asset_swap_assets` (/mcp/exchange) | 查询资产配置支持币种 |
| `cex_assetswap_list_asset_swap_orders_v1` (/mcp/exchange) | 查询资产配置优化订单列表 |
| `cex_assetswap_preview_asset_swap_order_v1` (/mcp/exchange) | 预览资产配置优化 |


<a id="authorization"></a>
## 授权与工具可见性

- 私有调用需要 Gate OAuth2。`tools/list` 按权限过滤，`tools/call` 也检查权限；授权不完整时不能据完整表推断某个工具一定可见。
- `base` 在普通 scope 匹配中包含 `read` 和 `asset`，因此不是“只读开关”。普通 Token 还保留 `market`、`profile`、`trade`、`wallet`、`account` 的逐工具 OR 兼容；不能把旧 scope 与新 scope 做全局一对一替换。
- `spot_trade`、`futures_trade`、`earn`、`cfd`、`stock` 用于对应业务；逐工具要求见完整表。Agentic 的 CFD/股票部分私有查询及股票资金划转使用 `base`，CFD 交易写操作用 `cfd`，股票订单写操作用 `stock`。Bot 创建和停止按 `strategy_type` 区分现货与合约权限，普通 OAuth 的 Bot 映射另列在完整表；部分创建/停止操作仍为 `read OR profile`，所以展开包含 read 的 base 也可匹配，不能当作只读模式。
- 下列仍注册的工具不允许 Agentic 调用：`cex_wallet_create_sa_to_sa_transfer`、`cex_account_create_stp_group`、`cex_account_add_stp_group_users`、`cex_account_delete_stp_group_users`、`cex_account_get_account_main_keys`。不要将此账户类型限制扩展为所有用户的工具下线。
- 空或畸形 scope 不会获得默认权限。OAuth 登录失效需重新登录，缺业务权限需重新授权；已退役工具不会因重新授权恢复。`mcp:tools` 不能替代业务 scope。
- PKCE 接入的 `resource` 使用 `https://api.gatemcp.ai/mcp/exchange`；不要复用为 CLI APIv4 等其他资源签发的 Token。客户端应按 HTTP 401 的 `WWW-Authenticate` 中 `resource_metadata` 发现授权信息，完成自己的授权流程。服务默认 scope 展示不等于所有环境授权页的实际申请范围。

<a id="input-contracts"></a>
## 请求参数约定与示例

同名 `body` 在不同工具中可能是 JSON 字符串或对象；应遵守该工具 Schema，而不是照搬 REST 请求结构。下列下单和账户设置示例只说明请求形状，不表示当前账户满足交易条件，也不应在只读验证中执行。

| 工具或场景 | 当前约定 |
|---|---|
| 现货条件单创建、现货倒计时撤单、跨仓强平 | 使用 JSON 字符串 `body`；不能把其内部字段移到顶层 |
| 现货条件单全撤 `cex_spot_cancel_spot_price_triggered_order_list` | 选择条件为 `market` / `account`，操作影响匹配范围内全部条件单；单撤用 `cex_spot_cancel_spot_price_triggered_order` |
| 现货下单/改单 | 补充 `stop_profit` / `stop_loss`，在该工具 Schema 中以 JSON 字符串展示；`trade_quote` 在现货下单和全撤中适用。省略、null、空对象不能擅自视为等价 |
| 合约下单 | 包含 `action_mode`、`pid`、`tpsl_sl_bbo_type`、`tpsl_sl_trigger_price`、`tpsl_tp_bbo_type`、`tpsl_tp_trigger_price` 等可选字段；撤单/改单中适用的 `action_mode` 见对应 Schema |
| 合约批量改单 | 每个 `orders[i]` 携带对应 `order_id` / `text`；顶层同名字段不能代替逐单字段 |
| `cex_fx_update_fx_price_triggered_order` | 顶层路径 `order_id` 与 JSON 字符串 `body` 内的 `order_id` 分别透传；修改 body 为扁平修改结构，不是创建的 `initial` / `trigger` 嵌套结构 |
| CFD/股票对象 body | 下方列出的 9 个工具只接收对象 `body`，不接收旧 JSON 字符串；必填、枚举、精确整数及 ID 类型按该工具 Schema |
| `cex_unified_set_unified_mode` | `settings` 为 JSON 字符串；兼容旧扁平开关，显式 settings 优先，不合并旧开关覆盖 settings |
| `cex_earn_list_earn_fixed_term_products` | 可选 `status` 为 int32 整数、`show_status` 为字符串；显式 0 和空字符串会保留传递，省略沿用后端默认行为 |
| `cex_earn_get_auto_invest_min_amount` | JSON 字符串 `body_json` 中 `asset_type` 必填：1=加密货币，2=TradFi 股票；还需 `money` / `items` |
| Alpha 的 currency | 使用 Alpha 币种 ID，不是展示符号；先无 currency 分页查询 `cex_alpha_list_alpha_currencies`，按 name、chain、address 匹配并使用返回的 currency |
| 合约仓位与账簿 | `cex_fx_list_fx_positions` 省略 limit 时查询当前仓位，提供时范围 1—100；账簿 type 使用当前 Schema 的类型说明 |

这 9 个工具使用对象 `body`：

- `cex_cfd_close_position`
- `cex_cfd_create_tradfi_order`
- `cex_cfd_create_transaction`
- `cex_cfd_update_order`
- `cex_cfd_update_position`
- `cex_stock_close_stock_position`
- `cex_stock_create_stock_order`
- `cex_stock_create_stock_transaction`
- `cex_stock_update_stock_order`

### 现货条件单：JSON 字符串 body

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "tools/call",
  "params": {
    "name": "cex_spot_create_spot_price_triggered_order",
    "arguments": {
      "body": "{\"market\":\"BTC_USDT\",\"trigger\":{\"price\":\"10000\",\"rule\":\">=\",\"expiration\":3600},\"put\":{\"type\":\"limit\",\"side\":\"buy\",\"price\":\"9900\",\"amount\":\"0.001\",\"account\":\"normal\",\"time_in_force\":\"gtc\"}}"
    }
  }
}
```

### CFD 下单：对象 body

```json
{
  "jsonrpc": "2.0",
  "id": 2,
  "method": "tools/call",
  "params": {
    "name": "cex_cfd_create_tradfi_order",
    "arguments": {
      "body": {
        "price": "0.9",
        "price_type": "trigger",
        "side": 2,
        "symbol": "EURUSD",
        "volume": "10"
      }
    }
  }
}
```

### 股票下单：对象 body

```json
{
  "jsonrpc": "2.0",
  "id": 3,
  "method": "tools/call",
  "params": {
    "name": "cex_stock_create_stock_order",
    "arguments": {
      "body": {
        "volume": "10",
        "symbol": "AAPL",
        "side": 2,
        "price_type": "limit",
        "trading_session": "all",
        "time_in_force": "day",
        "price": "200.12",
        "client_order_id": "documentation-example"
      }
    }
  }
}
```

### Unified 设置：JSON 字符串 settings

```json
{
  "jsonrpc": "2.0",
  "id": 4,
  "method": "tools/call",
  "params": {
    "name": "cex_unified_set_unified_mode",
    "arguments": {
      "mode": "portfolio",
      "settings": "{\"spot_hedge\":true}"
    }
  }
}
```

### 最低定投金额：JSON 字符串 body_json

```json
{
  "jsonrpc": "2.0",
  "id": 5,
  "method": "tools/call",
  "params": {
    "name": "cex_earn_get_auto_invest_min_amount",
    "arguments": {
      "body_json": "{\"money\":\"USDT\",\"asset_type\":1,\"items\":[{\"asset\":\"BTC\",\"ratio\":\"100\"}]}"
    }
  }
}
```

<a id="trail-contracts"></a>
## Trail 请求与响应

`cex_fx_create_trail_order` 使用 `settle` 和 JSON 字符串 `body`；body 的 `price_type` 必须显式提供整数 1（最新价）、2（指数价）或 3（标记价），没有默认值。

| 工具 | 响应数据位置 |
|---|---|
| `cex_fx_get_trail_orders` | `data.orders` |
| `cex_fx_update_trail_order` / `cex_fx_stop_trail_order` | `data.order` |
| `cex_fx_get_trail_order_change_log` | `data.change_log`；省略 page_num 时请求第一页 |

保留外层 `code`、`message`、`timestamp`。订单内 `id`、`user_id`、`user`、`suborder_id` 以及 `created_at`、`activated_at`、`finished_at`、`create_time`、`active_time`、`finish_time`、`updated_at` 使用字符串；日志 updated_at 为字符串，外层 timestamp 仍为整数。文本 JSON 与 `structuredContent` 保留上述形状。更新、停止和变更日志的非零业务码返回 `isError: true`。

<a id="errors"></a>
## 错误、精度与结果查询

- 区分 JSON-RPC `error`、工具 `isError` 与后端业务 `code`。HTTP 200 不能单独证明业务成功，也不能给所有工具统一假定一个成功码或响应 envelope。
- 后端公开错误可能包含 `code`、`label`、`message`、`detail`、`error`、`errors`、`trace_id`；保留实际返回字段，不把 detail 拼接成另一个 message。
- 写请求超时、取消或重定向拒绝后可能结果未知，应先查询原订单、交易或策略状态，再决定是否重提；返回任务 ID 不代表已成交或已完成资金结算。
- 非扁平工具的 JSON 字符串 `body` / `body_json` 有 10 MiB（10,485,760 字节）大小限制；上述 9 个 CFD/股票工具按对象序列化后的 JSON 检查同一限制。这不是所有 HTTP 请求或全部批次的统一上限。
- 按工具 Schema 保留金额和数量的字符串精度；ID 和时间类型逐字段处理，不能把所有 ID/时间统一转换。分页、时间窗口和批量大小也按具体工具限制，不因存在 page_size 参数就断言所有后端均已实测分页正确。

<a id="cfd-stock-fields"></a>
## CFD／股票对象 body 字段

以下为 9 个对象 body 工具的请求字段。列为可选不表示业务条件下永不必填；例如部分平仓仍须 close_volume。MCP 顶层 order_id/position_id 使用精确的 int64 ID 字符串，不能放入 body 代替路径参数。

### `cex_cfd_close_position`

必填顶层路径参数：`position_id`

| body 字段 | 类型 | 必填 | 枚举 | 说明 |
|---|---|---|---|---|
| `close_type` | integer | 是 | `1`, `2` | 1=部分平仓，2=全部平仓 |
| `close_volume` | string / null | 否 | — | close_type=1 时必填；close_type=2 时忽略 |

响应：可选的空 `data` 可能被 SDK 省略。 外层 timestamp 为 int64。

### `cex_cfd_create_tradfi_order`

| body 字段 | 类型 | 必填 | 枚举 | 说明 |
|---|---|---|---|---|
| `price` | string | 是 | — | 价格；CFD 下单及改单必填，股票限价单使用 |
| `price_type` | string | 是 | `"trigger"`, `"market"` | 价格类型，按该工具枚举 |
| `side` | integer | 是 | `1`, `2` | 1=卖出，2=买入 |
| `symbol` | string | 是 | — | 交易品种代码 |
| `volume` | string | 是 | — | 订单数量 |
| `price_tp` | string | 否 | — | 止盈价格（可选） |
| `price_sl` | string | 否 | — | 止损价格（可选） |
| `leverage` | integer | 否 | — | 杠杆须取自交易品种详情返回的允许倍数 |

响应：`data.id` 为字符串队列任务 ID，不是订单 ID。 外层 timestamp 为 int64。

### `cex_cfd_create_transaction`

| body 字段 | 类型 | 必填 | 枚举 | 说明 |
|---|---|---|---|---|
| `asset` | string | 是 | — | 资产；当前支持 USDT |
| `change` | string | 是 | — | 支持至多两位小数的金额字符串 |
| `type` | string | 是 | `"deposit"`, `"withdraw"` | deposit=转入，withdraw=转出 |

响应：可选的空 `data` 可能被 SDK 省略。 外层 timestamp 为 int64。

### `cex_cfd_update_order`

必填顶层路径参数：`order_id`

| body 字段 | 类型 | 必填 | 枚举 | 说明 |
|---|---|---|---|---|
| `price` | string | 是 | — | 价格；CFD 下单及改单必填，股票限价单使用 |
| `price_tp` | string / null | 否 | — | 止盈：省略或传 "0" 清除原值；保留时显式传回原价格 |
| `price_sl` | string / null | 否 | — | 止损：省略或传 "0" 清除原值；保留时显式传回原价格 |

响应：`data.order_id` 为 int64；data 还包含 symbol、state、volume、price、price_tp、price_sl。 外层 timestamp 为 int64。

### `cex_cfd_update_position`

必填顶层路径参数：`position_id`

| body 字段 | 类型 | 必填 | 枚举 | 说明 |
|---|---|---|---|---|
| `price_tp` | string / null | 否 | — | 止盈：省略或传 "0" 清除原值；保留时显式传回原价格 |
| `price_sl` | string / null | 否 | — | 止损：省略或传 "0" 清除原值；保留时显式传回原价格 |

响应：可选的空 `data` 可能被 SDK 省略。 外层 timestamp 为 int64。

### `cex_stock_close_stock_position`

| body 字段 | 类型 | 必填 | 枚举 | 说明 |
|---|---|---|---|---|
| `symbol` | string | 是 | — | 交易品种代码 |
| `close_volume` | string | 否 | — | 部分平仓时必填的平仓数量 |
| `close_type` | integer | 是 | `1`, `2` | 1=部分平仓，2=全部平仓 |

响应：`data.order_id` 为 int64 订单 ID。 外层 timestamp 为 int64。

### `cex_stock_create_stock_order`

| body 字段 | 类型 | 必填 | 枚举 | 说明 |
|---|---|---|---|---|
| `volume` | string | 是 | — | 订单数量 |
| `symbol` | string | 是 | — | 交易品种代码 |
| `side` | integer | 是 | `1`, `2` | 1=卖出，2=买入 |
| `price_type` | string | 是 | `"market"`, `"limit"` | 价格类型，按该工具枚举 |
| `trading_session` | string | 是 | `"regular"`, `"all"` | 限价单仅 all，市价单仅 regular |
| `time_in_force` | string | 是 | `"day"` | day=当日有效 |
| `price` | string | 否 | — | 限价单价格 |
| `client_order_id` | string | 否 | — | 客户端自定义订单 ID |

响应：`data.id` 为字符串订单 ID。 外层 timestamp 为 int64。

### `cex_stock_create_stock_transaction`

| body 字段 | 类型 | 必填 | 枚举 | 说明 |
|---|---|---|---|---|
| `asset` | string | 是 | `"USDT"` | 资产；当前支持 USDT |
| `change` | string | 是 | — | 大于 0 的金额字符串 |
| `type` | string | 是 | `"deposit"`, `"withdraw"` | deposit：现货转股票；withdraw：股票转现货 |
| `ref_id` | string | 是 | — | 业务幂等 ID |

响应：可选的空 `data` 可能被 SDK 省略。 外层 timestamp 为 int64。

### `cex_stock_update_stock_order`

必填顶层路径参数：`order_id`

| body 字段 | 类型 | 必填 | 枚举 | 说明 |
|---|---|---|---|---|
| `volume` | string | 是 | — | 修改后的订单数量 |
| `price` | string | 是 | — | 修改后的订单价格 |

响应：`data.order_id` 为 int64 订单 ID。 外层 timestamp 为 int64。
