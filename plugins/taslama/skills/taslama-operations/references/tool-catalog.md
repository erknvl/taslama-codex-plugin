# Taslama MCP tool catalog

The production server exposed 27 tools during validation on 2026-08-11. API-key permissions and deployment versions can expose a smaller or newer set, so discover tools at runtime.

## Read tools

- `findBookings`, `findCustomers`
- `findMedia`
- `findServiceCategories`, `findServices`
- `findProfessionals`
- `findProductCategories`, `findProducts`
- `findSiteSettings`, `findLandingPage`

Collection reads support bounded pagination, sorting, a JSON `where` string, a JSON `select` string, locale/fallback locale, and relationship depth. Prefer `depth: 0` and explicit selection.

## Catalog and content writes

- `createMedia`, `updateMedia`
- `createServiceCategories`, `updateServiceCategories`
- `createServices`, `updateServices`
- `createProfessionals`, `updateProfessionals`
- `createProductCategories`, `updateProductCategories`
- `createProducts`, `updateProducts`
- `updateSiteSettings`, `updateLandingPage`

The current server permits professional deletion in its collection configuration, but a particular key may omit that tool. Treat any deletion as high impact.

## Operational writes

- `updateBookingStatus`: set up to 100 bookings to `pending`, `confirmed`, `cancelled`, `completed`, or `no-show` when the account can manage bookings.
- `upsertCustomers`: create or update up to 100 customers while enforcing the global Account hierarchy.
- `deleteCustomers`: unlink or remove up to 100 customers. Customers with bookings cannot be removed; shared Accounts remain preserved.

Newer deployments may expose `getMyProfessionalSchedule` and `extendBookingSession`. Use them only when discovered. Schedule reads are limited to 92 days; extensions accept 1-480 minutes and can shift later active sessions.

## Project and authorization contract

- Endpoint: `https://app.taslama.agency/api/mcp`
- Transport: streamable HTTP over HTTPS
- Authentication: `Authorization: Bearer <API key>`
- Project scope: `Cookie: payload-tenant=<project ID>`
- Locales: `tk`, `ru`, `en`
- Operational time zone: `Asia/Ashgabat`

Accounts, project memberships, and audit logs are not exposed as general MCP collections. Server-side access control remains authoritative.
