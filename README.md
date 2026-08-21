# Taslama Codex plugins

Public Git marketplace for two Taslama Codex plugins:

- `taslama-x` uses interactive OAuth with project selection and no local secrets.
- `taslama` uses an API key and explicit project ID for trusted non-interactive clients.

## Install from Git

On macOS, installing a Git marketplace requires Apple Command Line Tools. If Codex reports that no developer tools were found, run:

```sh
xcode-select --install
```

Complete the installer, restart Codex, and then add the marketplace again. The full Xcode application is not required.

Add this repository as a plugin marketplace, then install the OAuth-based Taslama X plugin:

```sh
codex plugin marketplace add https://github.com/erknvl/taslama-codex-plugin.git
codex plugin add taslama-x@taslama
```

Authorize `taslama-x` when Codex prompts you. Sign in on the Taslama-hosted page, select a project, and approve access. No API key, cookie, project ID variable, or local credential file is required.

Start a new task after installation so the OAuth connection and copied Taslama skills are loaded. See the [Taslama X documentation](plugins/taslama-x/README.md) for the authorization and validation flow.

## API-key variant

For trusted automation that cannot complete interactive OAuth, install the original plugin:

```sh
codex plugin add taslama@taslama
```

Configure the MCP API key and selected project in the environment used to launch Codex:

```sh
export TASLAMA_MCP_API_KEY='your-api-key'
export TASLAMA_PROJECT_ID='your-project-id'
```

On macOS, desktop applications normally inherit variables configured through `launchctl`:

```sh
launchctl setenv TASLAMA_MCP_API_KEY 'your-api-key'
launchctl setenv TASLAMA_PROJECT_ID 'your-project-id'
```

Restart Codex and start a new task after installation so the MCP tools and Taslama skills are loaded.

See the [API-key plugin documentation](plugins/taslama/README.md) for credentials, validation, permissions, and historical booking imports.

Never commit a real API key, password, authorization code, access token, or refresh token.
