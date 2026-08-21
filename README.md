# Taslama Codex plugins

Taslama X is the public, OAuth-based distribution for ChatGPT/Codex-compatible
clients. It is the recommended path for new users: connect the published
Taslama app/plugin, sign in, choose a project, and start working. It does not
require Git, a terminal, Xcode Command Line Tools, environment variables, or
local secrets.

This repository is also the developer distribution for two Taslama Codex
plugins:

- `taslama-x` uses interactive OAuth with project selection and no local secrets.
- `taslama` uses an API key and explicit project ID for trusted non-interactive clients. Keep it internal/developer-only.

## Public/workspace installation (recommended)

Install **Taslama X** from the approved ChatGPT/Codex app or workspace directory,
then authorize it when prompted:

1. Search for `Taslama` / `Taslama X`.
2. Choose **Connect**, **Install**, or the equivalent workspace action.
3. Sign in on `app.taslama.agency`.
4. Select the Taslama project to use.
5. Approve the requested read/write scopes.

The OAuth connection is project-scoped and uses the account's current Taslama
roles. No API key, cookie, project ID variable, or credential file is required.
Remote OAuth is also the intended route for mobile clients; no local plugin
installation is needed on the phone. Availability depends on the host product's
published-app/workspace rollout.

See the [Taslama X documentation](plugins/taslama-x/README.md) and the
[submission package](plugins/taslama-x/docs/README.md) for review and rollout
materials.

## Developer-only Git marketplace

Use the Git marketplace only for local development, plugin validation, or a
controlled internal rollout. It is not the intended onboarding path for new
salon users.

On macOS, Git marketplace installation may require Apple Command Line Tools. If
Codex reports that no developer tools were found, install them with:

```sh
xcode-select --install
```

Then add this repository and install the OAuth plugin:

```sh
codex plugin marketplace add https://github.com/erknvl/taslama-codex-plugin.git
codex plugin add taslama-x@taslama
```

Authorize `taslama-x` when Codex prompts you. Sign in on the Taslama-hosted page, select a project, and approve access. No API key, cookie, project ID variable, or local credential file is required.

Start a new task after installation so the OAuth connection and copied Taslama skills are loaded. See the [Taslama X documentation](plugins/taslama-x/README.md) for the authorization and validation flow.

## Internal API-key variant

For trusted automation or development environments that cannot complete
interactive OAuth, install the original plugin. Do not publish or recommend it
as the consumer onboarding path:

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
