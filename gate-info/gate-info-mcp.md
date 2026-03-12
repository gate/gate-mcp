# Gate Info for AI

## 1. Coin Info

| Tool | Description | Main Parameters |
|---|---|---|
| `info_coin_get_coin_info` | Get basic info for a coin by name, symbol, or contract address | `query`, `query_type`(auto/address/symbol/name/gate_symbol/source_id), `scope`(basic/detailed/full), `size`, `fields` |

## 2. Market Snapshot

| Tool | Description | Main Parameters |
|---|---|---|
| `info_marketsnapshot_get_market_snapshot` | Get current market overview: real-time price, recent K-line summary, market cap, FDV, fear & greed index | `symbol`, `timeframe`(15m/1h/4h/1d), `source`(alpha/spot/future), `scope`(basic/detailed/full) |

## 3. Market Trend

### 3.1 K-line

| Tool | Description | Main Parameters |
|---|---|---|
| `info_markettrend_get_kline` | Get OHLCV K-line data, optionally with technical indicators | `symbol`, `timeframe`(1m/5m/15m/1h/4h/1d), `period`(1h/24h/7d/3d/5d/10d), `size`, `start_time`, `end_time`, `with_indicators` |

### 3.2 Indicator History

| Tool | Description | Main Parameters |
|---|---|---|
| `info_markettrend_get_indicator_history` | Get historical series for specified indicators (RSI, MACD, MA, EMA, etc.) | `symbol`, `indicators`(rsi/macd/ma7/ema7/...), `timeframe`(15m/1h/4h/1d), `start_time`, `end_time`, `limit` |

### 3.3 Technical Analysis

| Tool | Description | Main Parameters |
|---|---|---|
| `info_markettrend_get_technical_analysis` | Get multi-timeframe technical signals (RSI zone, MACD cross, MA alignment, support/resistance) | `symbol` |

## 4. On-chain Data

### 4.1 Address

| Tool | Description | Main Parameters |
|---|---|---|
| `info_onchain_get_address_info` | Query on-chain address: labels, risk level, token balances. Supports ETH, TRX, BSC, BTC, SOL, Base, Arbitrum | `address`, `chain`, `scope`(basic/detailed/full), `min_value_usd` |
| `info_onchain_get_address_transactions` | Query address transaction history with filters | `address`, `chain`, `tx_type`(transfer/contract_call/token_transfer/all), `min_value_usd`, `start_time`, `end_time`, `limit` |

### 4.2 Transaction & Token

| Tool | Description | Main Parameters |
|---|---|---|
| `info_onchain_get_transaction` | Get full transaction details by tx hash | `tx_hash`, `chain` |
| `info_onchain_get_token_onchain` | Get token on-chain data: holder distribution, activity, large transfers, smart money | `token`, `chain`, `scope`(holders/activity/transfers/smart_money/full) |

## 5. Compliance

| Tool | Description | Main Parameters |
|---|---|---|
| `info_compliance_check_token_security` | Token contract security check: risk tier, taxes, open source, holder count, name risk | `token` or `address`, `chain`, `scope`(basic/full), `lang` |
