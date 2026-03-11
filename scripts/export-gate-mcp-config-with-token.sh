#!/usr/bin/env bash
#
# Gate MCP Auth & Export Config with Token
# Gate MCP 授权并导出含 Token 的 MCP 配置
#
# Run on local machine (with browser):
# 在本机（有浏览器）执行：
#   1. Complete OAuth authorization (opens browser)
#   2. Extract access_token from mcporter credentials
#   3. Output MCP config JSON for headless servers
#
# Usage / 使用方式：
#   ./export-gate-mcp-config-with-token.sh           # Print to stdout / 输出到终端
#   ./export-gate-mcp-config-with-token.sh -o out.json  # Write to file / 输出到文件
#

set -e

MCP_NAME="gate-mcp"
MCP_URL="https://api.gatemcp.ai/mcp/exchange"
CREDENTIALS_FILE="${MCPORTER_CREDENTIALS_DIR:-$HOME/.mcporter}/credentials.json"
OUTPUT_FILE=""

while getopts "o:" opt; do
  case $opt in
    o) OUTPUT_FILE="$OPTARG" ;;
    *) exit 1 ;;
  esac
done

# Prefer global mcporter, fallback to npx
# 优先使用全局 mcporter，否则用 npx
MCPORTER="mcporter"
command -v mcporter >/dev/null 2>&1 || MCPORTER="npx mcporter"

echo "=== Gate MCP Auth & Export Config ==="
echo "=== Gate MCP 授权并导出配置 ==="
echo ""

# Step 1: Add config
# Step 1: 添加配置
echo "[1/3] Adding MCP config: $MCP_NAME / 添加 MCP 配置: $MCP_NAME"
$MCPORTER config add "$MCP_NAME" --url "$MCP_URL" --auth oauth --scope home
echo ""

# Step 2: OAuth auth (opens browser)
# mcporter auth may hang after saving token due to internal bug when retrying connection.
# Workaround: run auth in background + poll for token; proceed once token appears in credentials.
echo "[2/3] Starting OAuth flow (browser will open) / 启动 OAuth 授权流程（将打开浏览器）"
echo ""
echo "  Tip: After Gate auth, browser should redirect back to localhost."
echo "  提示：完成 Gate 授权后，浏览器应自动跳转回 localhost。"
echo "  If script hangs, mcporter may be stuck; Ctrl+C and re-run. Token saved will skip auth."
echo "  若脚本长时间无响应，可 Ctrl+C 中断后重新运行；token 已保存则会跳过授权直接输出配置。"
echo ""

# Run mcporter auth in background
$MCPORTER auth "$MCP_NAME" --scope home --log-level debug --oauth-timeout 120000 &
AUTH_PID=$!

# Poll: check credentials every 2s for gate-mcp token, max 90s
# First check immediately (handles existing token or fast mcporter completion)
POLL_INTERVAL=2
POLL_MAX=45
i=0
while [[ $i -lt $POLL_MAX ]]; do
  [[ $i -gt 0 ]] && sleep $POLL_INTERVAL
  i=$((i + 1))
  if [[ -f "$CREDENTIALS_FILE" ]]; then
    if CREDS="$CREDENTIALS_FILE" MURL="$MCP_URL" MNAME="$MCP_NAME" python3 -c '
import json, os, sys
try:
    d = json.load(open(os.environ["CREDS"]))
    for k, v in (d.get("entries") or {}).items():
        if isinstance(v, dict) and (os.environ["MURL"] in v.get("serverUrl", "") or os.environ["MNAME"] == v.get("serverName", "")):
            if (v.get("tokens") or {}).get("access_token"):
                sys.exit(0)
    sys.exit(1)
except Exception: sys.exit(1)
' 2>/dev/null; then
      echo ""
      echo "  Token detected, continuing... / 已检测到 token，继续生成配置..."
      kill $AUTH_PID 2>/dev/null || true
      break
    fi
  fi
done

# Allow auth process up to 5s to exit, else kill (avoid infinite wait due to mcporter bug)
(sleep 5; kill $AUTH_PID 2>/dev/null) &
wait $AUTH_PID 2>/dev/null || true
echo ""

# Step 3: Extract token from credentials and output config
echo "[3/3] Extracting token & generating MCP config / 提取 token 并生成 MCP 配置"
echo ""

if [[ ! -f "$CREDENTIALS_FILE" ]]; then
  echo "Error: Credentials file not found: $CREDENTIALS_FILE / 错误: 未找到凭证文件 $CREDENTIALS_FILE" >&2
  exit 1
fi

# 使用 Python 解析 credentials.json 并输出配置
JSON_OUTPUT=$(python3 - "$CREDENTIALS_FILE" "$MCP_URL" "$MCP_NAME" << 'PYTHON'
import json
import sys

def main():
    creds_path = sys.argv[1]
    mcp_url = sys.argv[2]
    mcp_name = sys.argv[3]

    with open(creds_path, "r") as f:
        data = json.load(f)

    entries = data.get("entries", {})
    access_token = None

    for key, entry in entries.items():
        if not isinstance(entry, dict):
            continue
        if entry.get("serverUrl") == mcp_url or entry.get("serverName") == mcp_name:
            tokens = entry.get("tokens") or {}
            access_token = tokens.get("access_token")
            if access_token:
                break

    if not access_token:
        print("Error: No access_token for gate-mcp. Ensure authorization completed. / 错误: 未找到 gate-mcp 的 access_token，请确认已完成授权。", file=sys.stderr)
        sys.exit(1)

    config = {
        "mcpServers": {
            mcp_name: {
                "baseUrl": mcp_url,
                "headers": {
                    "Authorization": f"Bearer {access_token}"
                }
            }
        }
    }

    print(json.dumps(config, indent=2, ensure_ascii=False))

if __name__ == "__main__":
    main()
PYTHON
)

echo "$JSON_OUTPUT"
if [[ -n "$OUTPUT_FILE" ]]; then
  echo "$JSON_OUTPUT" > "$OUTPUT_FILE"
  echo ""
  echo "Written to: $OUTPUT_FILE / 已写入: $OUTPUT_FILE"
fi

echo ""
echo "---"
echo "Copy the JSON above to the MCP config on your headless server."
echo "请将上方 JSON 配置复制到无浏览器服务器的 MCP 配置文件中。"
echo "Note / 注意："
echo "  - access_token expires; re-run this script locally to get fresh config."
echo "  - access_token 有有效期，过期后需在本机重新执行此脚本获取新配置；"
echo "  - Output contains secrets; do not commit or share."
echo "  - 输出含敏感凭证，请勿提交到版本库或分享给他人。"
