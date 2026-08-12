# Taslama Codex plugin

Public Git marketplace for the Taslama Codex plugin.

## Install from Git

Add this repository as a plugin marketplace, then install `taslama` from the **Taslama** source:

```sh
codex plugin marketplace add https://github.com/erknvl/taslama-codex-plugin.git
codex plugin add taslama@taslama
```

Restart Codex and start a new task after installation so the MCP tools and operations skill are loaded.

No API key or cookie setup is needed. On the first connection, authorize with your Taslama phone number or email and password, then select a project.

See [plugin documentation](plugins/taslama/README.md) for authorization, permissions, and historical booking imports.
