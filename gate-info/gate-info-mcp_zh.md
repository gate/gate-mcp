# Gate Info for AI

## 1. 币种信息

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `info_coin_get_coin_info` | 按名称、符号或合约地址查询币种基本信息 | `query`, `query_type`(auto/address/symbol/name/gate_symbol/source_id), `scope`(basic/detailed/full), `size`, `fields` |

## 2. 行情快照

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `info_marketsnapshot_get_market_snapshot` | 获取当前行情一览：实时价格、近期 K 线概况、市值、FDV、恐惧贪婪指数等 | `symbol`, `timeframe`(15m/1h/4h/1d), `source`(alpha/spot/future), `scope`(basic/detailed/full) |

## 3. 行情趋势

### 3.1 K 线

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `info_markettrend_get_kline` | 查询 OHLCV K 线数据，可附带技术指标 | `symbol`, `timeframe`(1m/5m/15m/1h/4h/1d), `period`(1h/24h/7d/3d/5d/10d), `size`, `start_time`, `end_time`, `with_indicators` |

### 3.2 指标历史

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `info_markettrend_get_indicator_history` | 获取指定指标的历史序列（RSI、MACD、MA、EMA 等） | `symbol`, `indicators`(rsi/macd/ma7/ema7/...), `timeframe`(15m/1h/4h/1d), `start_time`, `end_time`, `limit` |

### 3.3 技术分析

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `info_markettrend_get_technical_analysis` | 多粒度技术面综合信号（RSI 区间、MACD 交叉、均线排列、支撑/阻力） | `symbol` |

## 4. 链上数据

### 4.1 地址

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `info_onchain_get_address_info` | 查询链上地址：标签、风险等级、代币余额。支持 ETH、TRX、BSC、BTC、SOL、Base、Arbitrum | `address`, `chain`, `scope`(basic/detailed/full), `min_value_usd` |
| `info_onchain_get_address_transactions` | 查询地址交易记录，支持按类型、时间、金额过滤 | `address`, `chain`, `tx_type`(transfer/contract_call/token_transfer/all), `min_value_usd`, `start_time`, `end_time`, `limit` |

### 4.2 交易与代币

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `info_onchain_get_transaction` | 根据交易哈希查询完整交易详情 | `tx_hash`, `chain` |
| `info_onchain_get_token_onchain` | 查询代币链上数据：持仓分布、活跃度、大额转账、Smart Money | `token`, `chain`, `scope`(holders/activity/transfers/smart_money/full) |

## 5. 合规检测

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `info_compliance_check_token_security` | 代币合约安全检测：风险分级、税率、是否开源、持币人数、名称风险 | `token` 或 `address`, `chain`, `scope`(basic/full), `lang` |
