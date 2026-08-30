---
name: taslama-operations
description: Route Taslama admin and remote MCP work to focused catalog, media, website, order, booking, customer, and professional workflows in one selected project.
---

# Taslama Operations

Use the project selected by the authenticated Taslama session. Never invent, override, or bypass project context, and never place passwords, authorization codes, access tokens, or refresh tokens in chat, files, logs, or tool arguments.

## Workflow

1. Inspect available tools because access depends on the signed-in account, selected project, active admin page, project features, approved OAuth scopes, and deployed server version. `taslama_*` tools are browser WebMCP tools from an open Taslama admin tab; remote MCP tools come from the OAuth server. Do not assume one channel exposes the other channel's tools.
2. Start with the narrowest read. Use `depth: 0`, a small `limit`, explicit `select`, and the requested locale (`tk`, `ru`, or `en`).
3. Resolve names to selected-project IDs before relationship writes. Reuse IDs returned by reads.
4. Summarize current state and the exact proposed change.
5. Obtain confirmation before a write unless the user's current instruction already confirms the same records and values.
6. Call the narrowest write tool, re-read the affected record, and report the result.

## Safety boundaries

- Treat `find_*`, `get_*`, and `taslama_get_*` tools as reads.
- Treat create, update, delete, booking timing, `taslama_transition_order`, payment, refund, discount, inventory, and media tools as writes. Never call a write merely to test connectivity.
- Respect current role, OAuth scope, feature, and server checks. Do not retry a denied action through a broader tool or direct REST.
- Use integer minor units for prices and payments. Operational time zone is `Asia/Ashgabat`.
- Resolve relationships through reads, preserve unrelated fields and locales, and page through audits or imports.
- If a singleton is reported missing, treat it as deployment/schema drift rather than empty content.

Use `$taslama-orders` for orders, payments, refunds, discounts, promotions, and inventory. Use `$taslama-store-content` for catalog, media, site settings, and landing pages. Use the focused booking, import, and professional skills for those workflows.

Read [tool-catalog.md](references/tool-catalog.md) when tool names or channel boundaries are unclear.
