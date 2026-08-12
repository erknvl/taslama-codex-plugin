# Taslama MCP tool catalog

Available tools depend on the deployed backend and connection permissions, so discover them at runtime.

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

## Booking and customer operations

- `createBookings`, `updateBookings`, `deleteBookings`
- `importHistoricalBookings`: import up to 500 past terminal bookings per call
- `updateBookingStatus`
- `getMyProfessionalSchedule`, `extendBookingSession`
- `upsertCustomers`, `deleteCustomers`

Use only tools returned by runtime discovery. The server remains authoritative for account roles, project scope, and record-level access.

## Service contract

- Endpoint: `https://app.taslama.agency/api/mcp`
- Transport: streamable HTTP over HTTPS
- Locales: `tk`, `ru`, `en`
- Operational time zone: `Asia/Ashgabat`

Accounts, project memberships, and audit logs are not exposed as general MCP collections.
