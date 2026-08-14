# Taslama Codex plugin

Public Git marketplace for the Taslama Codex plugin.

## Install from Git

On macOS, installing a Git marketplace requires Apple Command Line Tools. If Codex reports that no developer tools were found, run:

```sh
xcode-select --install
```

Complete the installer, restart Codex, and then add the marketplace again. The full Xcode application is not required.

Add this repository as a plugin marketplace and install `taslama` from the **Taslama** source:

```sh
codex plugin marketplace add https://github.com/erknvl/taslama-codex-plugin.git
codex plugin add taslama@taslama
```

Configure the MCP API key and selected-project cookie in the environment used to launch Codex:

```sh
export TASLAMA_MCP_API_KEY='your-api-key'
export TASLAMA_PROJECT_COOKIE='payload-tenant=your-project-id'
```

On macOS, desktop applications normally inherit variables configured through `launchctl`:

```sh
launchctl setenv TASLAMA_MCP_API_KEY 'your-api-key'
launchctl setenv TASLAMA_PROJECT_COOKIE 'payload-tenant=your-project-id'
```

Restart Codex and start a new task after installation so the MCP tools and Taslama skills are loaded.

See the [plugin documentation](plugins/taslama/README.md) for credentials, validation, permissions, and historical booking imports.

Never commit a real API key or project cookie.
