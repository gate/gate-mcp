#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
import logging
import os
import ssl
import sys
import urllib.error
import urllib.request
from typing import Any, Dict, List, Optional, Tuple

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[logging.StreamHandler(sys.stderr)],
)
logger = logging.getLogger("mcp-streamable-http-proxy")

MCP_URL = os.getenv("MCP_URL", "https://api.gatemcp.ai/mcp")
TIMEOUT_SECONDS = int(os.getenv("MCP_TIMEOUT", "60"))

BASE_HEADERS = {
    "Content-Type": "application/json",
    "Accept": "application/json",
}

session_id: Optional[str] = None


def parse_json_sequence(text: str) -> List[Any]:
    """
    解析一个或多个连续 JSON 对象（支持中间有空白）。
    """
    s = text.strip()
    if not s:
        return []

    decoder = json.JSONDecoder()
    idx = 0
    n = len(s)
    out = []

    while idx < n:
        while idx < n and s[idx].isspace():
            idx += 1
        if idx >= n:
            break
        obj, end = decoder.raw_decode(s, idx)
        out.append(obj)
        idx = end

    return out


def parse_streamable_http_body(resp_text: str, content_type: str) -> List[Any]:
    """
    streamable HTTP 场景：优先按 JSON/JSON-sequence 解析。
    不做 SSE 解析。
    """
    ct = (content_type or "").lower()

    # 常见 JSON 类型
    if "json" in ct or ct == "":
        return parse_json_sequence(resp_text)

    # 兜底：即使 content-type 不标准，也尝试 JSON 解析
    return parse_json_sequence(resp_text)


def post_json(url: str, body: Dict[str, Any], headers: Dict[str, str], timeout: int) -> Tuple[int, Any, str]:
    data = json.dumps(body, ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(url=url, data=data, headers=headers, method="POST")
    context = ssl.create_default_context()

    try:
        with urllib.request.urlopen(req, timeout=timeout, context=context) as resp:
            status = resp.getcode()
            resp_headers = resp.headers
            charset = resp_headers.get_content_charset() or "utf-8"
            text = resp.read().decode(charset, errors="replace")
            return status, resp_headers, text
    except urllib.error.HTTPError as e:
        charset = e.headers.get_content_charset() or "utf-8"
        text = e.read().decode(charset, errors="replace")
        return e.code, e.headers, text


def emit_error(request_id: Any, message: str, code: int = -32603) -> None:
    if request_id is None:
        return
    err = {
        "jsonrpc": "2.0",
        "id": request_id,
        "error": {
            "code": code,
            "message": message,
        },
    }
    print(json.dumps(err, ensure_ascii=False), flush=True)


def main() -> None:
    global session_id

    logger.info("Starting MCP streamable-http proxy (stdlib-only)...")
    logger.info("Connecting to: %s", MCP_URL)

    try:
        for raw in sys.stdin:
            line = raw.rstrip("\r\n")
            if not line:
                continue

            request_id = None
            method = "unknown"

            try:
                request_data = json.loads(line)
                request_id = request_data.get("id")
                method = request_data.get("method", "unknown")
                is_notification = request_id is None

                logger.info(">>> Request [%s]: %s", request_id, method)

                headers = dict(BASE_HEADERS)
                if session_id:
                    headers["mcp-session-id"] = session_id

                status, resp_headers, resp_text = post_json(
                    MCP_URL, request_data, headers, TIMEOUT_SECONDS
                )

                content_type = resp_headers.get("Content-Type", "")
                logger.info("<<< Response status: %s, content-type: %s", status, content_type)

                new_session_id = resp_headers.get("mcp-session-id")
                if new_session_id and new_session_id != session_id:
                    session_id = new_session_id
                    logger.info("Got session ID: %s", session_id)

                if 200 <= status < 300:
                    try:
                        results = parse_streamable_http_body(resp_text, content_type)
                    except json.JSONDecodeError as e:
                        snippet = (resp_text or "")[:500]
                        logger.error("JSON parse error: %s, body=%r", e, snippet)
                        emit_error(request_id, f"Invalid JSON from upstream: {e}")
                        continue

                    if results:
                        for item in results:
                            print(json.dumps(item, ensure_ascii=False), flush=True)
                        logger.info("<<< Sent %d message(s) for [%s]", len(results), request_id)
                    else:
                        # 对 notification 可无响应；对 request 若空响应，返回明确错误便于排障
                        if is_notification:
                            logger.info("No body for notification [%s], skip output", method)
                        else:
                            logger.error("Empty body for request id=%s", request_id)
                            emit_error(request_id, "Empty response body from upstream")
                else:
                    snippet = (resp_text or "")[:2000]
                    msg = f"HTTP {status}: {snippet}"
                    logger.error(msg)
                    emit_error(request_id, msg)

            except json.JSONDecodeError as e:
                logger.error("Input JSON decode error: %s", e)
            except urllib.error.URLError as e:
                logger.error("Network error: %s", e)
                emit_error(request_id, f"Connection error: {e}")
            except Exception as e:
                logger.error("Unexpected error: %s", e, exc_info=True)
                emit_error(request_id, f"Unexpected error: {e}")

    except KeyboardInterrupt:
        logger.info("Proxy stopped by user")
    except Exception as e:
        logger.error("Fatal error: %s", e, exc_info=True)


if __name__ == "__main__":
    main()
