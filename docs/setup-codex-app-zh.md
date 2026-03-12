# Codex App 配置指南

## 方式一：一键安装

在 AI 对话中输入：

> Help me auto install Gate Skills and MCPs: https://github.com/gateio/gate-skills

![Codex App 一键安装](../images/codex-app-one-click-installer.png)

## 方式二：手动配置

### 前置条件

- 已安装 OpenAI Codex App
- 拥有 Codex 访问权限的 OpenAI API 密钥

### 第 1 步：打开 Codex 设置

启动 Codex App 并导航到 **设置**

![Codex App 设置](../images/codex-app-settings.png)

### 第 2 步：添加 MCP 服务器

1. 从设置菜单中选择 **MCP 服务器**
2. 点击 **添加服务器**

![Codex App 添加服务器](../images/codex-app-add-server.png)

### 第 3 步：配置 MCP 服务器

输入以下详细信息：

| 字段 | 值 |
|------|-----|
| 名称 | URL | 认证 |
|------|-----|------|
| `Gate` | `https://api.gatemcp.ai/mcp` | 无（行情数据） |
| `Gate` | `https://api.gatemcp.ai/mcp/exchange` | OAuth2（交易） |
| `Gate-Dex` | `https://api.gatemcp.ai/mcp/dex` | Headers: `x-api-key: MCP_AK_8W2N7Q`, `Authorization: Bearer ${GATE_MCP_TOKEN}` |
| `Gate-Info` | `https://api.gatemcp.ai/mcp/info` | 无 |
| `Gate-News` | `https://api.gatemcp.ai/mcp/news` | 无 |

![Codex App 配置](../images/codex-app-config.png)

点击 **保存** 添加服务器。

### 第 4 步：验证并使用

1. 在 Codex App 中开始新对话
2. 尝试："Gate MCP 有哪些可用工具？"
3. 确认后，尝试："BTC/USDT 的当前价格是多少？"

![Codex App 使用示例](../images/codex-app-usage.png)

## 故障排除

### 服务器无法连接

1. 检查网络连接
2. 验证 URL 是否正确
3. 检查 Codex App 是否有网络权限

### 工具不可用

1. 确保 MCP 服务器在设置中已启用
2. 尝试移除并重新添加服务器
3. 重启 Codex App

## 下一步

- 探索所有[可用工具](../README_zh.md#工具列表)
- 了解[合约工具](../README_zh.md#public-mcpmcp--无需认证)
- 查看 [API 文档](https://www.gate.com/docs/developers/apiv4/)
