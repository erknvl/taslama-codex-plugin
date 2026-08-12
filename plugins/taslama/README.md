# Taslama Codex plugin

Connect Codex to the project-scoped Taslama MCP server at `https://app.taslama.agency/api/mcp`.

## Authorization

No API key, cookie, environment variable, or local credentials file is required.

When Codex first connects to Taslama, choose **Authorize** and sign in on the Taslama page with either:

- your unique phone number and password; or
- your email and password.

Choose the project you want Codex to use and approve access. Codex stores the resulting OAuth token; your password is submitted only to your self-hosted Taslama server and is never placed in this repository or pasted into chat.

The authorization follows your existing Taslama account role and project membership. Reauthorize the connection when you need to switch projects or if access is revoked.

## Historical bookings

`importHistoricalBookings` accepts up to 500 past bookings in one request. For more than 500, split the data into batches of 500 or fewer and make another call for each batch. Every row must be in the past and use a terminal status supported by the server.
