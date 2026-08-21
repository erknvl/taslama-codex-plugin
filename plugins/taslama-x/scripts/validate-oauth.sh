#!/usr/bin/env bash
set -euo pipefail

endpoint="${TASLAMA_MCP_URL:-https://app.taslama.agency/api/mcp}"
origin="${endpoint%/api/mcp}"
resource_metadata="${origin}/.well-known/oauth-protected-resource/api/mcp"
authorization_metadata="${origin}/.well-known/oauth-authorization-server"
work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT

status="$(curl --silent --show-error \
  --dump-header "$work_dir/mcp.headers" \
  --output "$work_dir/mcp.body" \
  --write-out '%{http_code}' \
  --request POST "$endpoint" \
  --header 'Accept: application/json, text/event-stream' \
  --header 'Content-Type: application/json' \
  --data '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-11-25","capabilities":{},"clientInfo":{"name":"taslama-x-validator","version":"1.0.0"}}}')"

if [[ "$status" != "401" ]]; then
  echo "Expected an unauthenticated MCP request to return 401, got ${status}." >&2
  exit 1
fi

if ! grep -Eiq '^www-authenticate: Bearer .*resource_metadata=' "$work_dir/mcp.headers"; then
  echo 'MCP 401 response is missing the OAuth protected-resource challenge.' >&2
  exit 1
fi

curl --fail --silent --show-error "$resource_metadata" >"$work_dir/resource.json"
curl --fail --silent --show-error "$authorization_metadata" >"$work_dir/authorization.json"

python3 - "$endpoint" "$origin" "$work_dir/resource.json" "$work_dir/authorization.json" <<'PY'
import json
import sys

endpoint, origin, resource_path, authorization_path = sys.argv[1:]
with open(resource_path, encoding="utf-8") as source:
    resource = json.load(source)
with open(authorization_path, encoding="utf-8") as source:
    authorization = json.load(source)

expected_resource = {
    "resource": endpoint,
    "authorization_servers": [origin],
}
for key, value in expected_resource.items():
    if resource.get(key) != value:
        raise SystemExit(f"Protected-resource metadata has invalid {key!r}.")

required_scopes = {"mcp:read", "mcp:write"}
if not required_scopes.issubset(set(resource.get("scopes_supported", []))):
    raise SystemExit("Protected-resource metadata is missing Taslama MCP scopes.")

expected_authorization = {
    "issuer": origin,
    "authorization_endpoint": f"{origin}/oauth/authorize",
    "token_endpoint": f"{origin}/oauth/token",
    "registration_endpoint": f"{origin}/oauth/register",
}
for key, value in expected_authorization.items():
    if authorization.get(key) != value:
        raise SystemExit(f"Authorization-server metadata has invalid {key!r}.")

if "S256" not in authorization.get("code_challenge_methods_supported", []):
    raise SystemExit("Authorization server does not advertise PKCE S256.")
if "authorization_code" not in authorization.get("grant_types_supported", []):
    raise SystemExit("Authorization server does not advertise authorization_code.")
if authorization.get("token_endpoint_auth_methods_supported") != ["none"]:
    raise SystemExit("Taslama X requires public OAuth clients without a client secret.")

print("Taslama X OAuth discovery is ready.")
print(f"- resource: {resource['resource']}")
print(f"- issuer: {authorization['issuer']}")
print("- flow: authorization code + PKCE S256")
PY
