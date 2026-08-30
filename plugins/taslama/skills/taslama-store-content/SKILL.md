---
name: taslama-store-content
description: Manage selected-project catalogs, media, site settings, and landing blocks through Taslama admin WebMCP or remote MCP without changing platform configuration.
---

# Taslama Store Content

Work only in the project selected by the authenticated session. Read `taslama_admin_context` first when browser WebMCP is available. Use the current tool list as authority; never switch projects, alter memberships, enable features, or bypass missing tools.

## Catalog and relationships

- Resolve categories, brands, services, professionals, products, and media to IDs from the selected project before relationship writes.
- Preserve unrelated localized fields, publication state, and relationships.
- Public prices use non-negative integer TMT minor units. Never expose or substitute supplier/USD fields.

## Media is supported

- Do not tell the user to upload an image manually before inspecting the available media tool schema. Remote MCP media updates may accept an existing upload reference, external URL, or small base64/file payload; admin `taslama_upload_media` and remote `upload_media` accept a public HTTPS source.
- Use the narrowest accepted representation. For a public HTTPS JPEG, PNG, WebP, or AVIF, upload it with useful alt text and use the returned Media ID. For an attached/local file, use upload reference or file/base64 input when the discovered schema exposes it.
- Entity galleries use `images: [{ image: mediaId, caption?: string }]`; the first item is the listing image. Never store a remote URL directly in a media relationship.
- To replace an image, upload or update Media through the available tool, update the relationship when a new Media ID is returned, and re-read the entity. Ask for manual help only when no media write accepts any available URL, upload reference, file, or base64 representation.

## Site settings and landing page

- Read the current singleton in the active locale before updating it. Preserve other locales and unrelated fields.
- Landing layout is an ordered block array. Preserve existing row IDs, `blockType`, order, publication state, and untouched blocks.
- Commerce blocks include `featuredProducts`, `productCategories`, `storeBenefits`, and `fulfillmentInfo`. Resolve manual product/category relationships to selected-project IDs.
- Site settings include contact address plus store General, Fulfillment, Payments, and Public copy sections.
- Do not promise instant purchase or online card payment; orders are confirmation-based and paid offline.
- Commerce content is valid only when project commerce mode is `order-request` and store settings enable it.

After every write, re-read the changed singleton or entity and verify locale, relationships, Media IDs, block order, and publication state.
