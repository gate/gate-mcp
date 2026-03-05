# Cursor 配置指南

## 第 1 步：打开 Cursor 设置

导航到 `Settings` → `Tools & MCP` → `Add Custom MCP`

![Cursor 添加 MCP](../images/cursor-add-mcp.png)

## 第 2 步：编辑 MCP 配置

编辑你的 `mcp.json` 文件：

```json
{
  "mcpServers": {
    "Gate": {
      "url": "https://api.gatemcp.ai/mcp",
      "transport": "streamable-http",
      "headers": {
        "Content-Type": "application/json",
        "Accept": "application/json, text/event-stream"
      }
    }
  }
}
```

![Cursor MCP JSON 配置](../images/cursor-mcp-json.png)

## 第 3 步：开始使用

打开 Cursor AI 对话，尝试：

- "查询 BTC/USDT 的当前价格"
- "显示 ETH/USDT 的订单簿"
- "获取 SOL/USDT 的 1 小时 K 线数据"

![Cursor 使用示例](../images/cursor-usage.png)

## 故障排除

### 连接问题

1. 检查网络连接
2. 验证 MCP 服务器 URL 是否正确
3. 查看 Cursor 的 MCP 日志获取错误信息

### 工具不可用

1. 确保 MCP 配置正确保存
2. 重启 Cursor
3. 检查 MCP 服务器是否可访问

## 下一步

- 探索所有[可用工具](../README_zh.md#工具列表)
- 了解[合约市场工具](../README_zh.md#合约市场)
- 查看 [API 文档](https://www.gate.io/docs/developers/apiv4/)
