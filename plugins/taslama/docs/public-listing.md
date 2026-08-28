# Public listing copy: Taslama

Use this copy as a starting point for the published ChatGPT/Codex app or
workspace listing. Adjust character limits to the destination form without
changing the security boundaries below.

## Name

Taslama

## Short description

Manage a selected Taslama business project through secure project-scoped OAuth.

## Long description

Taslama connects ChatGPT and other supported remote MCP clients to a Taslama
business project. Use it for a salon, retail store, studio, repair shop, or another
service-industry operation configured in Taslama. Sign in with your Taslama
account, choose the project you are authorized to use, and review localized
products and services, team members, customers, bookings, landing content, and
site settings. Read and write actions remain subject to your Taslama membership,
role, and approved OAuth scopes.

Taslama does not require an API key, cookie, project ID environment variable, or
local credential file. The connection uses OAuth authorization code + PKCE and
project-bound tokens. The app asks for confirmation before supported writes and
does not bypass Taslama permissions.

## Suggested capabilities

- Review appointments/bookings and operational data for your business.
- Audit localized product, service, and site content.
- Propose and, after confirmation, apply supported content changes.
- Review salon-specific historical appointment workbooks before importing confirmed records.

Salons are one example of the workflow; the same project-scoped connection can
support retail stores and other service businesses when those catalogs and
operations are enabled for the project.

## Setup copy

Choose **Connect** or **Install**, sign in at Taslama, select a project, and
approve access. To change projects, disconnect Taslama and authorize again.

## Data and privacy copy

Taslama receives only the requests and records needed for the tools you invoke,
subject to the selected project's permissions. Do not submit passwords, OAuth
codes, access tokens, refresh tokens, or unrelated personal data in chat. Review
the privacy policy at `https://app.taslama.agency/privacy` and contact Taslama
Support at `https://app.taslama.agency/support` before publishing.

## Reviewer-facing endpoint details

- MCP resource: `https://app.taslama.agency/api/mcp`
- Protected-resource metadata: `https://app.taslama.agency/.well-known/oauth-protected-resource/api/mcp`
- Authorization-server metadata: `https://app.taslama.agency/.well-known/oauth-authorization-server`
- OAuth scopes: `mcp:read`, `mcp:write`
- Flow: authorization code with PKCE S256; public clients do not use a client secret
- Documentation: `https://app.taslama.agency/taslama-plugin`
- Privacy policy: `https://app.taslama.agency/privacy`
- Terms: `https://app.taslama.agency/terms`
- Support: `https://app.taslama.agency/support`

These values should be rechecked against the production deployment immediately
before submission.
