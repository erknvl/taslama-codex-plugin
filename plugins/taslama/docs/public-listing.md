# Public listing copy: Taslama

Use this copy as the starting point for a published ChatGPT, Codex, or workspace listing. Adjust destination character limits without weakening the boundaries below.

## Name

Taslama

## Short description

Manage one selected Taslama business project through secure OAuth and contextual admin WebMCP.

## Long description

Taslama connects ChatGPT and other supported clients to one Taslama business project. Use it for a salon, retail store, studio, repair shop, or another configured service business.

Sign in, authorize one project, and review localized products, services, media, team members, customers, bookings, orders, landing content, and site settings. When an authenticated Taslama admin tab is open in a supporting client, contextual WebMCP tools can also operate guarded order, offline payment, refund, inventory, media, and website workflows.

Reads and writes remain subject to project membership, role, feature mode, OAuth scopes, and server validation. Taslama does not require users to copy API keys, cookies, project IDs, or local credential files. The remote connection uses OAuth authorization code with PKCE and project-bound tokens.

## Suggested capabilities

- Review appointments and operational schedules.
- Review orders and apply guarded status, offline payment, refund, discount, and inventory operations in the authenticated admin app.
- Audit localized product, service, media, landing, and site content.
- Upload supported images from public HTTPS sources into selected-project Media instead of requiring manual CMS upload.
- Preview and apply confirmed localized content changes.
- Review historical appointment workbooks before importing confirmed records.

## Setup copy

Choose **Connect** or **Install**, sign in to Taslama, select a project, and approve access. To change projects, disconnect Taslama and authorize again. Admin WebMCP additionally requires the authenticated Taslama admin app to be open in a supporting client.

## Data privacy copy

Taslama receives only requests and records needed by the tools invoked, subject to selected-project permissions. Do not submit passwords, OAuth codes, access tokens, refresh tokens, or unrelated personal data in chat.

- Documentation: `https://app.taslama.agency/taslama-plugin`
- Privacy policy: `https://app.taslama.agency/privacy`
- Terms: `https://app.taslama.agency/terms`
- Support: `https://app.taslama.agency/support`

## Reviewer-facing endpoints

- MCP: `https://app.taslama.agency/api/mcp`
- Protected resource: `https://app.taslama.agency/.well-known/oauth-protected-resource/api/mcp`
- Authorization server: `https://app.taslama.agency/.well-known/oauth-authorization-server`
- OAuth: authorization code with PKCE S256; no client secret

Recheck these values against production immediately before submission.
