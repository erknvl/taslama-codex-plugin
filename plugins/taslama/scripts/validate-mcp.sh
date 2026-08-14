#!/usr/bin/env bash
set -euo pipefail

: "${TASLAMA_MCP_API_KEY:?Set TASLAMA_MCP_API_KEY to a Taslama MCP API key}"
: "${TASLAMA_PROJECT_COOKIE:?Set TASLAMA_PROJECT_COOKIE to payload-tenant=PROJECT_ID}"

endpoint="${TASLAMA_MCP_URL:-https://app.taslama.agency/api/mcp}"
response_file="$(mktemp)"
headers_file="$(mktemp)"
trap 'rm -f "$response_file" "$headers_file"' EXIT

request() {
  local payload="$1"
  curl --fail-with-body --silent --show-error \
    --dump-header "$headers_file" \
    --output "$response_file" \
    --request POST "$endpoint" \
    --header 'Accept: application/json, text/event-stream' \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer ${TASLAMA_MCP_API_KEY}" \
    --header "Cookie: ${TASLAMA_PROJECT_COOKIE}" \
    --data "$payload"
}

request '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"taslama-plugin-validator","version":"1.0.0"}}}'

session_id="$(awk 'BEGIN{IGNORECASE=1} /^mcp-session-id:/ {gsub(/\r/, "", $2); print $2}' "$headers_file")"
session_header=()
if [[ -n "$session_id" ]]; then
  session_header=(--header "Mcp-Session-Id: ${session_id}")
fi

curl --fail-with-body --silent --show-error \
  --request POST "$endpoint" \
  --header 'Accept: application/json, text/event-stream' \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer ${TASLAMA_MCP_API_KEY}" \
  --header "Cookie: ${TASLAMA_PROJECT_COOKIE}" \
  ${session_header[@]+"${session_header[@]}"} \
  --data '{"jsonrpc":"2.0","method":"notifications/initialized"}' >/dev/null

curl --fail-with-body --silent --show-error \
  --output "$response_file" \
  --request POST "$endpoint" \
  --header 'Accept: application/json, text/event-stream' \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer ${TASLAMA_MCP_API_KEY}" \
  --header "Cookie: ${TASLAMA_PROJECT_COOKIE}" \
  ${session_header[@]+"${session_header[@]}"} \
  --data '{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}'

python3 - "$response_file" <<'PY'
import json
import sys

body = open(sys.argv[1], encoding="utf-8").read()
payload = next((line[6:] for line in body.splitlines() if line.startswith("data: ")), body)
result = json.loads(payload)
tools = result.get("result", {}).get("tools", [])
if not tools:
    raise SystemExit("Taslama MCP returned no tools for this API key.")
print(f"Taslama MCP is ready: {len(tools)} tools")
for tool in tools:
    print(f"- {tool['name']}")
PY
