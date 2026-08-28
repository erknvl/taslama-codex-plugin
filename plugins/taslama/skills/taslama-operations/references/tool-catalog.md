# Taslama MCP tool catalog

The available tool set depends on the signed-in account, selected project, approved OAuth scopes, and deployed server version, so discover tools at runtime.

## Read tools

- `find_documents`: read enabled collections by passing `collectionSlug`. Available collections include bookings, customers, media, service categories, services, professionals, product categories, and products.
- `find_global`: read `site-settings` or `landing-page` by passing `globalSlug`.
- `get_config_info`: inspect the available MCP configuration when exposed.
- `get_my_professional_schedule`: read the signed-in professional's bounded schedule when authorized.

Collection reads support bounded pagination, sorting, a JSON `where` value, explicit selection, locale/fallback locale, and relationship depth. Prefer `depth: 0` and explicit selection.

## Catalog and content writes

- `create_documents`: create service categories, services, professionals, product categories, or products by passing the corresponding `collectionSlug`.
- `update_document`: update enabled content collections by ID or bounded filter.
- `delete_documents`: currently reserved for explicitly enabled deletion flows such as professionals; treat every deletion as high impact.
- `update_global`: update `site-settings` or `landing-page` by passing `globalSlug`.
- `upload_media`: securely download and store an HTTPS image, returning the Media ID used by entity image galleries.

## Booking and customer operations

- `create_bookings`, `update_bookings`, `delete_bookings`: bounded booking CRUD operations for accounts that can manage bookings.
- `update_booking_status`: set up to 100 bookings to `pending`, `confirmed`, `cancelled`, `completed`, or `no-show`.
- `import_historical_bookings`: import up to 500 validated past bookings with terminal statuses.
- `upsert_customers`: create or update up to 100 customers while enforcing the global Account hierarchy.
- `delete_customers`: unlink or remove up to 100 customers. Customers with bookings cannot be removed; shared Accounts remain preserved.
- `extend_booking_session`: extend a booking by 1-480 minutes and shift later active sessions when necessary to prevent overlap.

## Project and authorization contract

- Endpoint: `https://app.taslama.agency/api/mcp`
- Transport: streamable HTTP over HTTPS
- Authentication: OAuth 2.1 authorization code flow with PKCE S256
- Project scope: selected during Taslama-hosted OAuth consent and bound to the issued token
- Locales: `tk`, `ru`, `en`
- Operational time zone: `Asia/Ashgabat`

Accounts, project memberships, and audit logs are not exposed as general MCP collections. Server-side access control remains authoritative.
