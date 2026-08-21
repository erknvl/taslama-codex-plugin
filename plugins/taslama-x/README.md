# Taslama X Codex plugin

Taslama X connects Codex to the project-scoped Taslama MCP server through OAuth. It contains the same Taslama operations and historical-import skills as the API-key plugin, but does not require an API key, project ID environment variable, cookie, or custom authorization header.

## Authorization

Install the plugin, then authorize `taslama-x` when Codex asks you to connect:

1. Sign in on the Taslama-hosted page with your Taslama phone number or email and password.
2. Select a project available to your account.
3. Approve the requested MCP access.

Taslama issues short-lived, project-bound OAuth access tokens through authorization code + PKCE. Refresh tokens are rotated when used. The MCP server continues to enforce the signed-in account's current project membership, role, and OAuth scopes.

Your password is submitted only to `https://app.taslama.agency`. Do not paste a password, authorization code, access token, or refresh token into Codex or a support message.

To switch projects, log out of the `taslama-x` MCP connection and authorize it again.

## Language

MCP tool identifiers stay stable in English snake_case, while their human titles support English, Russian, and Turkmen. Taslama selects the title language from `X-Taslama-Locale`, the request language, or `Accept-Language`, with English as the fallback. Content operations continue to use their explicit `locale` and `fallbackLocale` inputs.

## Installation

On macOS, Git marketplaces require Apple Command Line Tools. If Codex reports that no developer tools were found, run `xcode-select --install`, complete the installer, and restart Codex.

Add or upgrade the Taslama marketplace, then install Taslama X:

```sh
codex plugin marketplace add https://github.com/erknvl/taslama-codex-plugin.git
codex plugin add taslama-x@taslama
```

Start a new task after installation so the OAuth connection and skills are loaded.

Run `scripts/validate-oauth.sh` to verify the public OAuth discovery and MCP authorization challenge without creating a client or token.

## Included features

- OAuth authorization with project-selection consent
- Project-scoped Taslama MCP connection
- Catalog, professional, customer, booking, landing-page, and site-settings operations
- Safe write-confirmation guidance
- Historical booking journal audit and import workflow
- Credential-free OAuth discovery validation
