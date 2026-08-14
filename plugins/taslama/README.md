# Taslama Codex plugin

This package connects Codex to the project-scoped Taslama MCP server at `https://app.taslama.agency/api/mcp`.

## Credentials

1. Sign in to Taslama Admin.
2. Open **MCP -> API Keys** and create a dedicated least-privilege key.
3. Choose a project and copy its ID.
4. Configure the environment used to launch Codex:

```sh
export TASLAMA_MCP_API_KEY='your-api-key'
export TASLAMA_PROJECT_COOKIE='payload-tenant=your-project-id'
```

The API key is sent as a Bearer token. The selected project is sent through the `Cookie` header using the `payload-tenant` cookie.

On macOS, use `launchctl setenv` for the two variables when running the Codex desktop application, then restart Codex.

Run `scripts/validate-mcp.sh` to verify the authenticated handshake and list the tools granted to the key.

## Installation

On macOS, Git marketplaces require Apple Command Line Tools. If Codex reports that no developer tools were found, run:

```sh
xcode-select --install
```

Complete the installer, restart Codex, and then add the marketplace again. The full Xcode application is not required.

Install this package from the Taslama Git marketplace:

```sh
codex plugin marketplace add https://github.com/erknvl/taslama-codex-plugin.git
codex plugin add taslama@taslama
```

Start a new task after installation so the connection and skills are reloaded.

Do not put a real API key or project cookie in this repository, the plugin manifest, screenshots, or support messages.

## Included features

- Project-scoped Taslama MCP connection
- Catalog, professional, customer, booking, landing-page, and site-settings operations
- Safe write-confirmation guidance
- Historical booking journal audit and import workflow
- Deterministic MCP connection validation

## Icon

The marketplace icon is stored at `assets/icon.png` and uses the yellow Taslama mark on a solid black background.
