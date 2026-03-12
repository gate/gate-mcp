# Gate News for AI

## 1. Search & Real-time News

| Tool | Description | Main Parameters |
|---|---|---|
| `news_feed_search_news` | Search news and real-time feeds by keyword, coin, time range, and platform type | `query`, `coin`, `platform_type`(crypto_media/fintech_media/social_ugc/exchange_announcement/all), `lang`, `start_time`, `end_time`, `sort_by`(time/importance/sentiment), `limit` |

## 2. Exchange Announcements

| Tool | Description | Main Parameters |
|---|---|---|
| `news_feed_get_exchange_announcements` | Query exchange announcements (new listings, delistings, maintenance) by exchange or coin | `exchange`, `coin`, `announcement_type`(listing/delisting/maintenance/all), `from`, `limit` |

## 3. Social Sentiment

| Tool | Description | Main Parameters |
|---|---|---|
| `news_feed_get_social_sentiment` | Get a single post's detail: author, content, interactions, sentiment | `post_id`, `coin`, `time_range`(1h/24h/7d) |
