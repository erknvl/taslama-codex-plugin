# Taslama X Codex plugin

Taslama X connects Codex to the project-scoped Taslama MCP server through OAuth. It contains the same Taslama operations and historical-import skills as the API-key plugin, but does not require an API key, project ID environment variable, cookie, or custom authorization header.

## Recommended installation

For new users, install Taslama from the approved ChatGPT/Codex app or workspace
directory. Search for **Taslama** or **Taslama X**, choose **Connect** / **Install**,
then complete the Taslama sign-in and project-selection consent screen. This is
the plug-and-play distribution path and does not require Git, a terminal, Xcode
Command Line Tools, environment variables, or local credential files.

The same remote OAuth connection is intended for clients that support remote MCP
connections, including mobile clients where the host product exposes published
apps or workspace apps. There is nothing to install on the phone. Confirm the
host product's availability and account policy before promising a particular
mobile surface.

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

## Developer-only Git installation

Use this route only for local development, validation, or an approved internal
rollout. On macOS, Git marketplaces require Apple Command Line Tools. If Codex
reports that no developer tools were found, run `xcode-select --install`,
complete the installer, and restart Codex.

Add or upgrade the Taslama marketplace, then install Taslama X:

```sh
codex plugin marketplace add https://github.com/erknvl/taslama-codex-plugin.git
codex plugin add taslama-x@taslama
```

Start a new task after installation so the OAuth connection and skills are loaded.

Run `scripts/validate-oauth.sh` to verify the public OAuth discovery and MCP authorization challenge without creating a client or token.

## Submission and review materials

The public listing copy, OAuth reviewer runbook, evaluation prompts, and owner
checklist live in [`docs/`](docs/README.md). They deliberately use placeholders
for reviewer credentials, legal URLs, publisher verification, and other owner-
provided values; this repository does not contain or invent those values.

## Included features

- OAuth authorization with project-selection consent
- Project-scoped Taslama MCP connection
- Catalog, professional, customer, booking, landing-page, and site-settings operations
- Safe write-confirmation guidance
- Historical booking journal audit and import workflow
- Credential-free OAuth discovery validation
