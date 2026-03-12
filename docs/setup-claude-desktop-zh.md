# Claude Desktop 配置指南

Claude Desktop 需要使用本地 stdio 代理来连接 Gate MCP 服务器。

> **说明：** stdio 代理连接的是公开端点（`/mcp`），仅提供市场数据。如需完整交易功能，请使用支持 HTTP 传输的客户端（如 Cursor、Claude CLI）。

## 第 1 步：下载 Python 代理

从仓库下载代理文件：

```bash
curl -O https://raw.githubusercontent.com/gate/gate-mcp/main/gate-mcp-proxy.py
```

或将以下内容保存为 `gate-mcp-proxy.py`：

```python
#!/usr/bin/env python3
"""
Gate CEX MCP 服务器的 MCP 代理
为 Claude Desktop 兼容性提供 stdio 到 HTTP 的转换
"""

import sys
import json
import urllib.request
import urllib.error

MCP_SERVER_URL = "https://api.gatemcp.ai/mcp"

def send_request(method, params=None):
    """向 MCP 服务器发送请求"""
    data = json.dumps({
        "jsonrpc": "2.0",
        "method": method,
        "params": params or {},
        "id": 1
    }).encode('utf-8')

    req = urllib.request.Request(
        MCP_SERVER_URL,
        data=data,
        headers={
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
    )

    try:
        with urllib.request.urlopen(req) as response:
            return json.loads(response.read().decode('utf-8'))
    except urllib.error.URLError as e:
        return {"error": str(e)}

def main():
    """stdio 通信的主循环"""
    while True:
        try:
            line = sys.stdin.readline()
            if not line:
                break

            message = json.loads(line)
            method = message.get('method')
            params = message.get('params', {})

            result = send_request(method, params)

            response = {
                "jsonrpc": "2.0",
                "id": message.get('id'),
                "result": result.get('result', {})
            }

            print(json.dumps(response), flush=True)

        except json.JSONDecodeError:
            continue
        except KeyboardInterrupt:
            break

if __name__ == "__main__":
    main()
```

## 第 2 步：编辑 Claude Desktop 配置

打开 Claude Desktop 配置文件：

- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

![Claude Desktop 配置](../images/claude-desktop-config.png)

添加以下配置（将 `/path/to/gate-mcp-proxy.py` 替换为实际路径）：

```json
{
  "mcpServers": {
    "Gate": {
      "command": "python3",
      "args": ["/path/to/gate-mcp-proxy.py"]
    }
  }
}
```

## 第 3 步：重启并验证

1. **完全重启 Claude Desktop**
2. 打开新的对话
3. 尝试："列出 gate mcp 的可用工具"

![Claude Desktop 验证](../images/claude-desktop-verify.png)

## 第 4 步：开始使用

示例查询：

- "查询 BTC/USDT 的当前价格"
- "显示 ETH/USDT 的资金费率"
- "获取最近 24 小时的强平历史"

![Claude Desktop 使用示例](../images/claude-desktop-usage.png)

## 故障排除

### "Cannot find module" 错误

确保 Python 3 已安装并可访问：

```bash
python3 --version
```

### Permission Denied

使代理脚本可执行：

```bash
chmod +x /path/to/gate-mcp-proxy.py
```

### 连接超时

1. 检查网络连接
2. 验证 MCP 服务器 URL 是否可访问
3. 检查防火墙是否阻止连接

## 下一步

- 探索所有[可用工具](../README_zh.md#工具列表)
- 了解[合约工具](../README_zh.md#public-mcpmcp--无需认证)
- 查看 [API 文档](https://www.gate.com/docs/developers/apiv4/)
