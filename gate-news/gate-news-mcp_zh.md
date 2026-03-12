# Gate News for AI

## 1. 搜索与实时快讯

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `news_feed_search_news` | 按关键词、币种、时间范围、媒体类型搜索新闻与实时快讯 | `query`, `coin`, `platform_type`(crypto_media/fintech_media/social_ugc/exchange_announcement/all), `lang`, `start_time`, `end_time`, `sort_by`(time/importance/sentiment), `limit` |

## 2. 交易所公告

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `news_feed_get_exchange_announcements` | 按交易所或币种查询上新、下架、维护等公告 | `exchange`, `coin`, `announcement_type`(listing/delisting/maintenance/all), `from`, `limit` |

## 3. 社交情绪

| 工具名称 | 说明 | 主要参数 |
|---|---|---|
| `news_feed_get_social_sentiment` | 根据推文 ID 获取单条推文详情：作者、内容、互动、情绪 | `post_id`, `coin`, `time_range`(1h/24h/7d) |
