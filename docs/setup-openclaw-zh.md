# OpenClaw 配置指南

## 方式一：一键安装

在 AI 对话中输入：

> Help me auto install Gate Skills and MCPs: https://github.com/gateio/gate-skills

![OpenClaw 一键安装](../images/openclaw-one-click-isntaller.png)

## 方式二：手动配置

Gate 提供两种方式在 OpenClaw 中连接 MCP：

| 方式 | 说明 | 认证 | 工具数 |
|------|------|------|--------|
| **本地 MCP**（推荐） | 通过 `npx gate-mcp` 本地运行，支持 API Key 认证 | API Key | 161 个工具（11 个模块） |
| **远程 MCP**（通过 mcporter） | 连接远程服务器，支持 OAuth2 | OAuth2 | 17 个公开 / 66 个私有 |

## 前置条件

- 已安装 OpenClaw（访问 [openclaw.io](https://openclaw.io)）
- Node.js >= 18
- Gate API Key 和 Secret（本地 MCP 交易用）或 Gate 账号（远程 MCP OAuth 用）

---

## 方式 A：本地 MCP（推荐）

> 使用 [gate-local-mcp](https://github.com/gate/gate-local-mcp) — 通过 `npx gate-mcp` 运行的本地 stdio MCP 服务器，涵盖 11 个模块的 161 个工具（现货、合约、交割、杠杆、钱包、账户、期权、理财、闪兑、统一账户、子账户）。

### 第 1 步：创建 Gate API Key（交易用）

> 如果只需要查询行情数据，可跳过此步（公开端点无需认证）。

1. 注册或登录 [Gate.io](https://www.gate.com) 账号
2. 前往 [API Key 管理页面](https://www.gate.com/zh/myaccount/profile/api-key/manage)
3. 点击 **创建 API Key**，设置权限（如现货交易、合约交易、钱包），保存好 **API Key** 和 **API Secret**

> **重要提示：** API Secret 仅在创建时显示一次，请妥善保管。详细 API 文档请参阅 [Gate API 文档](https://www.gate.com/docs/developers/apiv4/zh_CN/)。

### 第 2 步：在 OpenClaw 中配置

编辑 OpenClaw MCP 配置：

**仅查行情（无需认证）：**

```json
{
  "mcpServers": {
    "gate": {
      "command": "npx",
      "args": ["-y", "gate-mcp"]
    }
  }
}
```

**带交易功能（API Key）：**

```json
{
  "mcpServers": {
    "gate": {
      "command": "npx",
      "args": ["-y", "gate-mcp"],
      "env": {
        "GATE_API_KEY": "your-api-key",
        "GATE_API_SECRET": "your-api-secret"
      }
    }
  }
}
```

**测试网：**

```json
{
  "mcpServers": {
    "gate": {
      "command": "npx",
      "args": ["-y", "gate-mcp"],
      "env": {
        "GATE_BASE_URL": "https://api-testnet.gateapi.io",
        "GATE_API_KEY": "your-testnet-key",
        "GATE_API_SECRET": "your-testnet-secret"
      }
    }
  }
}
```

### 第 3 步：模块过滤（可选）

默认加载全部 161 个工具（11 个模块）。可通过 `GATE_MODULES` 和 `GATE_READONLY` 精简工具数量：

```json
{
  "mcpServers": {
    "gate": {
      "command": "npx",
      "args": ["-y", "gate-mcp"],
      "env": {
        "GATE_MODULES": "spot,futures",
        "GATE_READONLY": "true",
        "GATE_API_KEY": "your-api-key",
        "GATE_API_SECRET": "your-api-secret"
      }
    }
  }
}
```

| 环境变量 | 说明 |
|---------|------|
| `GATE_API_KEY` | Gate API Key（设置后启用交易工具） |
| `GATE_API_SECRET` | Gate API Secret |
| `GATE_BASE_URL` | 覆盖 API 端点（如测试网） |
| `GATE_MODULES` | 逗号分隔的模块列表：`spot`、`futures`、`delivery`、`margin`、`wallet`、`account`、`options`、`earn`、`flash_swap`、`unified`、`sub_account` |
| `GATE_READONLY` | 设为 `true` 禁用写操作 |

### 第 4 步：开始使用

1. 在 OpenClaw 中开始新会话
2. 尝试："BTC/USDT 的当前价格是多少？"

更多详情请参阅 [gate-local-mcp 仓库](https://github.com/gate/gate-local-mcp)。

---

## 方式 B：远程 MCP（通过 mcporter）

> 连接远程 Gate MCP 服务器（`api.gatemcp.ai`），使用 OAuth2 认证。

### 第 1 步：启用 mcporter Skill

在 OpenClaw 中，导航到 **Skills** 并搜索 `mcporter`。启用它。

![OpenClaw 启用 mcporter](../images/openclaw-enable-mcporter.png)

### 第 2 步：本地安装 mcporter

```bash
npm install -g mcporter
```

或使用 npx 运行而无需安装：

```bash
npx mcporter --version
```

### 第 3 步：添加 Gate MCP 配置

**完整交易能力（OAuth）：**

```bash
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp/exchange --auth oauth
```

**仅查行情（无需认证）：**

```bash
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp
```

**DEX（链上钱包、兑换）：**

```bash
mcporter config add gate-dex --url https://api.gatemcp.ai/mcp/dex
```

**Info（无需认证）：**

```bash
mcporter config add gate-info --url https://api.gatemcp.ai/mcp/info
```

**News（无需认证）：**

```bash
mcporter config add gate-news --url https://api.gatemcp.ai/mcp/news
```

### 第 4 步：授权登录（仅 `/mcp/exchange` 需要）

使用 Gate 账号登录（会打开浏览器）：

```bash
mcporter auth gate-mcp
```

### 第 5 步：验证连接

```bash
mcporter config get gate-mcp
mcporter list gate-mcp --schema
```

> 若能返回工具列表，说明连接成功。

### 第 6 步：在 OpenClaw 中使用

1. 在 OpenClaw 中开始新会话
2. mcporter skill 应该会自动检测并使用 Gate MCP 配置
3. 尝试："BTC/USDT 的当前价格是多少？"

![OpenClaw 使用示例](../images/openclaw-usage.png)

### 管理配置

```bash
# 列出所有配置
mcporter config list

# 移除配置
mcporter config remove gate-mcp

# 更新配置
mcporter config add gate-mcp --url https://api.gatemcp.ai/mcp/exchange --auth oauth --force
```

---

## 故障排除

### npx / mcporter 未找到

确保 Node.js >= 18 和 npm 已安装：

```bash
node -v
npm -v
```

### 连接失败

1. **本地 MCP**：验证 `npx gate-mcp` 能否正常运行
2. **远程 MCP**：验证 URL `https://api.gatemcp.ai/mcp/exchange` 或 `https://api.gatemcp.ai/mcp` 是否可访问
3. 检查网络连接

## 下一步

- 探索所有[可用工具](../README_zh.md#工具列表)
- 了解 [gate-local-mcp](https://github.com/gate/gate-local-mcp) 完整本地配置详情
- 查看 [API 文档](https://www.gate.com/docs/developers/apiv4/)
