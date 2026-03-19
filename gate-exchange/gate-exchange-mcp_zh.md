# Gate Exchange MCP 工具

> 本文档描述的是**私有端点**（`/mcp/exchange`，需 OAuth2）上的工具。
> 公开市场数据工具（无需认证）请参见 [README 中的 Public MCP 部分](../README_zh.md#public-mcpmcp--无需认证)。
>
> **OAuth2 Scopes**: `market`, `profile`, `trade`, `wallet`, `account`

所有工具均使用 `cex_` 前缀。端点提供 400+ 工具，涵盖现货、合约、杠杆、期权、交割、钱包、统一账户、子账户、理财、闪兑、返佣、TradFi、跨所、P2P、Alpha、活动中心、卡券、新币挖矿、广场、新手福利。

> **api.gatemcp.ai**：工具列表见 [gateapi-mcp-service-tools.md](gateapi-mcp-service-tools.md)。**gate-local-mcp**：工具列表见 [gate-local-mcp-tools.md](gate-local-mcp-tools.md)。

## 1. 现货交易（scope: profile / trade）

### 1.1 账户查询

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_spot_get_spot_accounts` | 获取现货账户余额 | `currency`（可选，不填返回全部） |
| `cex_spot_list_spot_account_book` | 获取现货账户流水 | `currency`, `limit`, `page`, `from`, `to`, `type`, `code` |
| `cex_spot_get_spot_fee` | 获取交易费率 | `currency_pair` |
| `cex_spot_get_spot_batch_fee` | 批量获取交易费率 | `currency_pairs`（必填，最多 50 个交易对） |
| `cex_spot_list_all_open_orders` | 查询所有未成交订单 | - |
| `cex_spot_get_spot_price_triggered_order` | 获取计划委托订单 | `order_id` |
| `cex_spot_list_spot_price_triggered_orders` | 查询计划委托列表 | `status`, `page`, `limit` |
| `cex_spot_get_spot_insurance_history` | 获取保险基金历史 | `currency_pair`, `limit` |

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
| `cex_spot_create_spot_price_triggered_order` | 创建计划委托 | `market`, `trigger`, `put`, `options` |
| `cex_spot_cancel_spot_price_triggered_order` | 取消计划委托 | `order_id` |
| `cex_spot_cancel_spot_price_triggered_order_list` | 批量取消计划委托 | `order_ids` |
| `cex_spot_countdown_cancel_all_spot` | 倒计时撤单 | `timeout`, `currency_pair`, `market` |
| `cex_spot_create_cross_liquidate_order` | 创建交叉强平订单 | `currency_pair`, `side`, `amount`, `price` |

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

### 2.6 合约扩展工具

| 工具名称 | 说明 |
|------|-------------|
| `cex_fx_get_fx_orders_with_time_range` | 按时间范围查询订单 |
| `cex_fx_get_leverage` | 获取杠杆设置 |
| `cex_fx_list_position_close` | 平仓记录 |
| `cex_fx_list_auto_deleverages` | 自动减仓记录 |
| `cex_fx_list_price_triggered_orders` / `cex_fx_get_fx_price_triggered_order` | 计划委托 |
| `cex_fx_get_trail_orders` / `cex_fx_get_trail_order_detail` / `cex_fx_get_trail_order_change_log` | 追踪委托 |
| `cex_fx_create_fx_bbo_order` | 创建 BBO 订单 |
| `cex_fx_create_fx_price_triggered_order` / `cex_fx_cancel_fx_price_triggered_order` / `cex_fx_update_fx_price_triggered_order` | 计划委托管理 |
| `cex_fx_countdown_cancel_all_fx` | 倒计时撤单 |
| `cex_fx_create_trail_order` / `cex_fx_update_trail_order` / `cex_fx_stop_trail_order` | 追踪委托管理 |
| `cex_fx_stop_all_trail_orders` | 停止所有追踪委托 |
| `cex_fx_get_fx_risk_limit_table` | 按表ID查询风险限额阶梯 |
| `cex_fx_list_fx_liquidates` | 查询用户强平历史 |
| `cex_fx_list_fx_positions_timerange` | 按时间范围查询仓位历史 |
| `cex_fx_set_fx_position_mode` | 设置持仓模式（单向/双向） |
| `cex_fx_update_fx_contract_position_leverage` | 更新指定保证金模式的杠杆 |

## 3. 杠杆（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_margin_list_margin_accounts` / `cex_margin_list_margin_account_book` | 杠杆账户、流水 |
| `cex_margin_list_funding_accounts` / `cex_margin_get_auto_repay_status` | 资金账户、自动还款 |
| `cex_margin_get_margin_transferable` / `cex_margin_get_user_margin_tier` | 可转、档位 |
| `cex_margin_list_uni_loans` / `cex_margin_list_uni_loan_records` / `cex_margin_list_uni_loan_interest_records` | 统一杠杆借贷 |
| `cex_margin_get_uni_borrowable` / `cex_margin_list_cross_margin_loans` / `cex_margin_list_cross_margin_repayments` | 可借额度、全仓借贷 |
| `cex_margin_set_auto_repay` / `cex_margin_set_user_market_leverage` | 自动还款、杠杆 |
| `cex_margin_create_uni_loan` | 创建统一杠杆借贷 |

## 4. 期权（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_options_list_my_options_settlements` / `cex_options_list_options_account` / `cex_options_list_options_account_book` | 账户、结算 |
| `cex_options_list_options_positions` / `cex_options_get_options_position` / `cex_options_list_options_position_close` | 仓位 |
| `cex_options_list_options_orders` / `cex_options_get_options_order` / `cex_options_list_my_options_trades` | 订单、成交 |
| `cex_options_get_options_mmp` | MMP（做市商保护） |
| `cex_options_create_options_order` / `cex_options_cancel_options_orders` / `cex_options_cancel_options_order` | 订单管理 |
| `cex_options_amend_options_order` | 修改期权订单（价格/数量） |
| `cex_options_countdown_cancel_all_options` / `cex_options_set_options_mmp` / `cex_options_reset_options_mmp` | 倒计时、MMP |

## 5. 交割（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_dc_list_dc_accounts` / `cex_dc_list_dc_account_book` | 账户、流水 |
| `cex_dc_list_dc_positions` / `cex_dc_get_dc_position` | 仓位 |
| `cex_dc_list_dc_orders` / `cex_dc_get_dc_order` | 订单 |
| `cex_dc_get_my_dc_trades` / `cex_dc_list_dc_position_close` / `cex_dc_list_dc_liquidates` / `cex_dc_list_dc_settlements` | 成交、结算 |
| `cex_dc_list_price_triggered_dc_orders` / `cex_dc_get_price_triggered_dc_order` | 计划委托 |
| `cex_dc_update_dc_position_margin` / `cex_dc_update_dc_position_leverage` / `cex_dc_update_dc_position_risk_limit` | 仓位设置 |
| `cex_dc_create_dc_order` / `cex_dc_cancel_dc_orders` / `cex_dc_cancel_dc_order` | 订单管理 |
| `cex_dc_create_price_triggered_dc_order` / `cex_dc_cancel_price_triggered_dc_order` / `cex_dc_cancel_price_triggered_dc_order_list` | 计划委托管理 |

## 6. 统一账户（scope: account）

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_unified_get_unified_accounts` | 获取统一账户信息 | `currency`, `sub_uid` |
| `cex_unified_get_unified_mode` | 获取统一账户模式 | - |
| `cex_unified_set_unified_mode` | 设置统一账户模式 | `mode`（必填）, `usdt_futures`, `spot_hedge`, `use_funding`, `options` |
| `cex_unified_get_unified_borrowable` | 获取可借额度 | `currency`（必填） |
| `cex_unified_get_unified_risk_units` | 获取风险单元 | - |
| `cex_unified_list_unified_loans` | 获取统一账户借贷记录 | `currency`, `limit`, `page`, `type` |
| `cex_unified_calculate_portfolio_margin` / `cex_unified_create_unified_loan` | 组合保证金、创建借贷 |
| `cex_unified_get_history_loan_rate` / `cex_unified_get_unified_borrowable_list` / `cex_unified_get_unified_estimate_rate` | 利率、可借列表 |
| `cex_unified_get_unified_transferable` / `cex_unified_get_unified_transferables` | 可转额度 |
| `cex_unified_get_user_leverage_currency_config` / `cex_unified_get_user_leverage_currency_setting` / `cex_unified_set_user_leverage_currency_setting` | 杠杆配置 |
| `cex_unified_list_currency_discount_tiers` / `cex_unified_list_loan_margin_tiers` | 折扣档位 |
| `cex_unified_list_unified_currencies` / `cex_unified_list_unified_loan_interest_records` / `cex_unified_list_unified_loan_records` | 币种、借贷记录 |
| `cex_unified_set_unified_collateral` | 设置抵押品 |

## 7. 钱包与划转（scope: wallet）

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_wallet_get_transfer_order_status` | 查询划转状态 | `client_order_id`, `tx_id` |
| `cex_wallet_get_total_balance` | 获取总资产 | `currency`（可选，BTC/CNY/USD/USDT） |
| `cex_wallet_get_wallet_fee` | 获取交易手续费 | `currency_pair`, `settle`（合约手续费） |
| `cex_wallet_list_deposits` | 获取充值记录 | `currency`, `limit`, `offset`, `from`, `to` |
| `cex_wallet_list_withdrawals` | 获取提现记录 | `currency`, `limit`, `offset`, `from`, `to` |
| `cex_wallet_create_sa_transfer` | 主账户与子账户划转 | `sub_account`（必填）, `currency`（必填）, `amount`（必填）, `direction`（必填，to/from）, `sub_account_type`, `client_order_id` |
| `cex_wallet_create_sa_to_sa_transfer` | 子账户间划转 | `currency`（必填）, `sub_account_from`（必填）, `sub_account_from_type`（必填）, `sub_account_to`（必填）, `sub_account_to_type`（必填）, `amount`（必填） |
| `cex_wallet_get_deposit_address` / `cex_wallet_list_currency_chains` | 充值地址、链列表 |
| `cex_wallet_list_sa_balances` / `cex_wallet_list_sa_cross_margin_balances` / `cex_wallet_list_sa_futures_balances` / `cex_wallet_list_sa_margin_balances` / `cex_wallet_list_sa_transfers` | 子账户余额、划转 |
| `cex_wallet_list_small_balance` / `cex_wallet_list_small_balance_history` / `cex_wallet_convert_small_balance` | 零头兑换 |

## 8. 子账户（scope: account）

### 8.1 子账户管理

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_sa_create_sa` | 创建子账户 | `login_name`（必填）, `password`, `email`, `remark` |
| `cex_sa_get_sa` | 获取子账户信息 | `user_id`（必填） |
| `cex_sa_list_sas` | 获取子账户列表 | `type` |
| `cex_sa_lock_sa` | 锁定子账户 | `user_id`（必填） |
| `cex_sa_unlock_sa` | 解锁子账户 | `user_id`（必填） |
| `cex_sa_get_sa_unified_mode` | 获取子账户统一账户模式 | - |

### 8.2 子账户 API Key

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `cex_sa_create_sa_key` | 创建子账户 API Key | `user_id`（必填）, `mode`, `name`, `perms`（JSON 数组）, `ip_whitelist` |
| `cex_sa_get_sa_key` | 获取子账户 API Key | `user_id`（必填）, `key`（必填） |
| `cex_sa_list_sa_keys` | 获取子账户 API Key 列表 | `user_id`（必填） |
| `cex_sa_update_sa_key` | 更新子账户 API Key | `user_id`（必填）, `key`（必填）, `mode`, `name`, `perms`（JSON 数组）, `ip_whitelist` |
| `cex_sa_delete_sa_key` | 删除子账户 API Key | `user_id`（必填）, `key`（必填） |

## 9. 账户管理（scope: account）

| 工具名称 | 说明 |
|------|-------------|
| `cex_account_get_account_detail` | 获取账户详情 |
| `cex_account_get_account_main_keys` | 获取主 Key |
| `cex_account_get_account_rate_limit` | 获取限频 |
| `cex_account_get_debit_fee` / `cex_account_set_debit_fee` | 借币费率 |
| `cex_account_list_stp_groups` / `cex_account_list_stp_groups_users` | STP 组 |
| `cex_account_create_stp_group` | 创建 STP 组 |
| `cex_account_add_stp_group_users` / `cex_account_delete_stp_group_users` | 管理 STP 用户 |

## 10. 返佣（scope: profile）

| 工具名称 | 说明 |
|------|-------------|
| `cex_rebate_partner_commissions_history` / `cex_rebate_partner_sub_list` / `cex_rebate_partner_transaction_history` | 合作伙伴返佣 |
| `cex_rebate_broker_commission_history` / `cex_rebate_broker_transaction_history` | 经纪商返佣 |
| `cex_rebate_user_info` / `cex_rebate_user_sub_relation` | 用户返佣信息 |
| `cex_rebate_get_partner_application_recent` | 获取最近30天合伙人申请记录 |
| `cex_rebate_get_partner_eligibility` | 检查用户是否有合伙人申请资格 |

## 11. 闪兑（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_fc_list_fc_currency_pairs` | 闪兑交易对列表 |
| `cex_fc_list_fc_orders` / `cex_fc_get_fc_order` | 查询订单 |
| `cex_fc_preview_fc_order_v1` | 一对一闪兑预览 |
| `cex_fc_create_fc_order_v1` | 创建一对一闪兑订单 |
| `cex_fc_preview_fc_multi_currency_many_to_one_order` | 多对一闪兑预览 |
| `cex_fc_preview_fc_multi_currency_one_to_many_order` | 一对多闪兑预览 |
| `cex_fc_create_fc_multi_currency_many_to_one_order` | 创建多对一闪兑订单 |
| `cex_fc_create_fc_multi_currency_one_to_many_order` | 创建一对多闪兑订单 |

## 12. 理财（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_earn_asset_list` / `cex_earn_award_list` | 资产、奖励 |
| `cex_earn_list_dual_balance` / `cex_earn_list_dual_orders` | 双币理财 |
| `cex_earn_list_structured_orders` / `cex_earn_order_list` | 结构化产品 |
| `cex_earn_get_uni_currency` / `cex_earn_get_uni_interest` / `cex_earn_get_uni_interest_status` | 余币宝 |
| `cex_earn_list_uni_chart` / `cex_earn_list_uni_interest_records` / `cex_earn_list_uni_lend_records` | 余币宝记录 |
| `cex_earn_place_structured_order` / `cex_earn_swap_eth2` / `cex_earn_change_uni_lend` | 交易操作 |
| `cex_earn_list_earn_fixed_term_products` / `cex_earn_list_earn_fixed_term_products_by_asset` | 定期理财产品 |
| `cex_earn_list_earn_fixed_term_lends` / `cex_earn_list_earn_fixed_term_history` | 定期理财记录 |
| `cex_earn_create_earn_fixed_term_lend` / `cex_earn_create_earn_fixed_term_pre_redeem` | 定期理财操作 |

## 13. Alpha（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_alpha_list_alpha_accounts` / `cex_alpha_list_alpha_account_book` | Alpha 账户 |
| `cex_alpha_list_alpha_orders` / `cex_alpha_get_alpha_order` | Alpha 订单 |
| `cex_alpha_quote_alpha_order` / `cex_alpha_place_alpha_order` | 报价、下单 |

## 14. TradFi（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_tradfi_query_categories` / `cex_tradfi_query_symbols` / `cex_tradfi_query_symbol_detail` | 品类、交易对 |
| `cex_tradfi_query_symbol_kline` / `cex_tradfi_query_symbol_ticker` | 行情数据 |
| `cex_tradfi_query_mt5_account_info` / `cex_tradfi_query_user_assets` | MT5 账户、资产 |
| `cex_tradfi_query_transaction` / `cex_tradfi_query_order_list` / `cex_tradfi_query_order_history_list` | 交易、订单 |
| `cex_tradfi_query_position_list` / `cex_tradfi_query_position_history_list` | 仓位 |
| `cex_tradfi_create_transaction` | 创建交易 |
| `cex_tradfi_create_tradfi_order` / `cex_tradfi_delete_order` / `cex_tradfi_update_order` | 订单管理 |
| `cex_tradfi_close_position` / `cex_tradfi_update_position` | 仓位管理 |

## 15. 跨所（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_crx_list_crx_rule_symbols` / `cex_crx_list_crx_rule_risk_limits` | 规则交易对、风险限额 |
| `cex_crx_list_crx_transfer_coins` / `cex_crx_list_crx_transfers` | 划转币种、划转记录 |
| `cex_crx_get_crx_account` / `cex_crx_get_crx_fee` / `cex_crx_get_crx_interest_rate` | 账户、费率、利率 |
| `cex_crx_list_crx_positions` / `cex_crx_list_crx_margin_positions` | 仓位 |
| `cex_crx_list_crx_open_orders` / `cex_crx_get_crx_order` | 订单 |
| `cex_crx_create_crx_transfer` / `cex_crx_create_crx_order` / `cex_crx_cancel_crx_order` / `cex_crx_update_crx_order` | 划转、订单 |
| `cex_crx_close_crx_position` / `cex_crx_create_crx_convert_quote` / `cex_crx_create_crx_convert_order` | 平仓、兑换 |
| `cex_crx_update_crx_account` / `cex_crx_update_crx_positions_leverage` / `cex_crx_update_crx_margin_positions_leverage` | 更新账户、杠杆 |

## 16. P2P（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_p2p_get_user_info` / `cex_p2p_get_counterparty_user_info` / `cex_p2p_get_myself_payment` | 用户信息 |
| `cex_p2p_ads_detail` / `cex_p2p_ads_list` / `cex_p2p_my_ads_list` | 广告 |
| `cex_p2p_get_chats_list` | 聊天 |
| `cex_p2p_get_completed_transaction_list` / `cex_p2p_get_pending_transaction_list` / `cex_p2p_get_transaction_details` | 订单 |
| `cex_p2p_ads_update_status` / `cex_p2p_place_biz_push_order` | 广告、推送订单 |
| `cex_p2p_send_chat_message` / `cex_p2p_upload_chat_file` | 聊天 |
| `cex_p2p_transaction_cancel` / `cex_p2p_transaction_confirm_payment` / `cex_p2p_transaction_confirm_receipt` | 订单操作 |

## 17. 活动中心（scope: profile）

| 工具名称 | 说明 |
|------|-------------|
| `cex_activity_list_activity_types` | 查询活动中心支持的所有活动类型 |
| `cex_activity_list_activities` | 查询活动中心推荐活动列表 |
| `cex_activity_get_my_activity_entry` | 查询用户活动中心入口信息和参与状态 |

## 18. 卡券（scope: profile）

| 工具名称 | 说明 |
|------|-------------|
| `cex_coupon_list_user_coupons` | 获取用户卡券列表 |
| `cex_coupon_get_user_coupon_detail` | 根据卡券类型和ID获取卡券详情 |

## 19. 新币挖矿（scope: profile / trade）

| 工具名称 | 说明 |
|------|-------------|
| `cex_launch_list_launch_pool_projects` | 查询 LaunchPool 项目列表 |
| `cex_launch_list_launch_pool_pledge_records` | 查询用户质押/赎回记录 |
| `cex_launch_list_launch_pool_reward_records` | 查询用户质押奖励记录 |
| `cex_launch_create_launch_pool_order` | 创建 LaunchPool 质押订单 |
| `cex_launch_redeem_launch_pool` | 赎回 LaunchPool 质押资产 |

## 20. 广场（scope: market）

| 工具名称 | 说明 |
|------|-------------|
| `cex_square_list_square_ai_search` | AI 搜索 Gate 广场帖子 |
| `cex_square_list_live_replay` | 搜索 Gate 直播和回放视频 |

## 21. 新手福利（scope: profile）

| 工具名称 | 说明 |
|------|-------------|
| `cex_welfare_get_user_identity` | 检查用户是否有新手福利资格 |
| `cex_welfare_get_beginner_task_list` | 获取新手引导任务列表和奖励信息 |
