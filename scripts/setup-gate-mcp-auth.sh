#!/usr/bin/env bash
#
# Gate MCP OAuth 配置与授权脚本
# 执行：添加 gate-mcp 配置，然后调起 OAuth 授权（会打开浏览器）
# 使用 --log-level debug 确保授权 URL 被打印到终端（便于无头环境手动访问）
#

set -e

MCP_NAME="gate-mcp"
MCP_URL="https://api.gatemcp.ai/mcp/exchange"

echo "=== Gate MCP 配置与授权 ==="
echo ""

# 优先使用全局 mcporter，否则用 npx
MCPORTER="mcporter"
command -v mcporter >/dev/null 2>&1 || MCPORTER="npx mcporter"

# Step 1: 添加配置（若已存在会更新）
echo "[1/2] 添加 MCP 配置: $MCP_NAME"
$MCPORTER config add "$MCP_NAME" --url "$MCP_URL" --auth oauth
echo ""

# Step 2: 授权登录（会打开浏览器，同时打印授权 URL）
echo "[2/2] 启动 OAuth 授权流程"
echo "      浏览器将自动打开；若未打开，请查看下方打印的授权 URL 并手动访问。"
echo "      ----------------------------------------"
$MCPORTER auth "$MCP_NAME" --log-level debug
echo "      ----------------------------------------"
echo ""
echo "授权完成。"
