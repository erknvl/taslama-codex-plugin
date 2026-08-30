# Taslama tool catalog

Discover tools at runtime. Availability depends on the account, selected project, OAuth scopes, project features, active admin page, and deployed server version.

## Remote MCP

- `find_documents`: read enabled collections through `collectionSlug`. Depending on role and features, these include bookings, customers, media, service categories, services, professionals, product categories, products, carts, orders, inventory movements, order payments, and promotions.
- `find_global`: read `site-settings` or `landing-page` through `globalSlug`.
- `create_documents`, `update_document`, `delete_documents`: scoped content writes where exposed.
- `upload_media`: download a public HTTPS image into selected-project Media and return its ID. Media document updates may additionally expose upload references, external URLs, or file/base64 input in their runtime schema. Inspect that schema before telling the user to upload manually.
- Booking and customer tools include `create_bookings`, `update_bookings`, `delete_bookings`, `update_booking_status`, `import_historical_bookings`, `extend_booking_session`, `upsert_customers`, and `delete_customers` according to role.

Remote commerce collections are read-only. Guarded order transitions and ledger writes are provided by admin WebMCP.

## Admin WebMCP

These tools require an open, authenticated Taslama admin tab:

- `taslama_admin_context`: active admin path, selected project, locale, roles, commerce mode, and current order ID.
- `taslama_get_site_settings`, `taslama_update_site_settings`: selected-project website and store settings.
- `taslama_get_landing_page`, `taslama_update_landing_page`: ordered landing blocks.
- `taslama_upload_media`: JPEG, PNG, WebP, or AVIF from a public HTTPS URL into selected-project Media.
- `taslama_find_orders`, `taslama_get_order`: selected-project orders when commerce mode is `order-request`.
- `taslama_transition_order`: guarded confirmation, rejection, processing, ready, dispatch, completion, or cancellation.
- `taslama_record_order_payment`, `taslama_record_order_refund`, `taslama_set_order_discount`, `taslama_adjust_inventory`: guarded TMT minor-unit ledger and inventory operations according to role.

Admin WebMCP reuses Payload session cookies, selected-project context, access control, state-transition validation, stock transactions, and append-only ledgers. Never bypass a rejected tool through direct REST.

## Authorization contract

- Remote endpoint: `https://app.taslama.agency/api/mcp`
- Transport: streamable HTTP over HTTPS
- Authentication: OAuth 2.1 authorization code with PKCE S256
- Project scope: bound during Taslama-hosted authorization
- Locales: `tk`, `ru`, `en`
- Time zone: `Asia/Ashgabat`

Accounts, project memberships, and audit logs are not general content collections. Server-side access control remains authoritative.
