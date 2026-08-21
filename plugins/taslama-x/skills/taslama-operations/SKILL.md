---
name: taslama-operations
description: Manage Taslama salon projects through the Taslama MCP tools. Use for catalog, service, product, professional, customer, booking, landing-page, site-settings, localization, schedule, and salon-operations requests involving Taslama or app.taslama.agency.
---

# Taslama Operations

Use the project selected during Taslama X OAuth authorization. Never invent or override that project context, bypass project scope, or place passwords, authorization codes, access tokens, or refresh tokens in chat, files, logs, or tool arguments.

## Workflow

1. Inspect the available Taslama tools because access depends on the signed-in account, selected project, approved OAuth scopes, and deployed server version.
2. Start with the narrowest read: use `depth: 0`, a small `limit`, explicit `select`, and the requested locale (`tk`, `ru`, or `en`).
3. Resolve names to IDs before using relationships or mutations. Reuse IDs returned by reads.
4. Summarize the current state and the exact proposed change.
5. For a write, obtain confirmation unless the user already gave an explicit, unambiguous instruction to make that change.
6. Call the narrowest write tool, then read the affected record back and report the result.

## Safety boundaries

- Treat `find*` tools as reads. Treat `create*`, `update*`, `upsertCustomers`, `deleteCustomers`, `updateBookingStatus`, and schedule-changing tools as writes.
- Never call a write tool merely to test connectivity.
- Do not delete a professional or customer without naming the resolved record and consequences before the call.
- Bookings are read-only except for dedicated status and operational-timing tools exposed by the server.
- Preserve original booking timing. When extending a session, explain that later active sessions can move to prevent overlap.
- Use integer minor units for prices and `Asia/Ashgabat` for operational time.
- Respect the server's current account role and OAuth scope checks. Do not retry a denied action through a broader tool.
- If a global or collection is reported missing, treat it as deployment/schema drift, not an empty result; do not attempt the corresponding update.

## Content and localization

- Read the current locale before editing localized text.
- Preserve other locales. Update only the requested locale unless the user explicitly requests a coordinated multilingual change.
- Keep relationship fields as IDs and resolve them through read tools first.
- Use pagination for audits and imports; never assume the first page is complete.

## Operational patterns

- Daily schedule: read bookings for a bounded local-day range, select only timing, customer, service, professional, and status fields, then flag overlaps or incomplete states.
- Catalog audit: list categories before services or products, page through results, and report missing relationships, publication state, price, duration, media, or translation fields.
- Historical booking import: validate past dates and terminal statuses, identify customers by normalized Turkmenistan phone first or email as fallback, submit at most 500 bookings per call, and continue with another call for additional batches.
- Customer import: normalize and preview names, Turkmenistan phone numbers, and emails; batch no more than 100; report each created or updated result.
- Landing/site edits: read the global first, preserve unrelated fields and block order, then update only the requested values.

Read [tool-catalog.md](references/tool-catalog.md) when planning a multi-step operation or when the available tool names are unclear.
