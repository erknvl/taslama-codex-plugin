# OAuth reviewer guide

This guide is for a host-product reviewer or workspace administrator. It does
not include credentials. The owner must provide a dedicated test account and
confirm that it contains safe, non-production data for the submitted business
archetype (for example, a salon, retail store, studio, repair shop, or other service
operation).

## Owner-provided values

Fill these in through the secure submission channel, never in this repository or
in a chat prompt:

- Reviewer login: `<REVIEWER_EMAIL_OR_PHONE>`
- Reviewer password: `<REVIEWER_PASSWORD>`
- Test project name/ID: `<REVIEWER_TEST_PROJECT>`
- Publisher/domain verification evidence: `<PUBLISHER_VERIFICATION_REFERENCE>`
- Privacy policy: `https://app.taslama.agency/privacy`
- Terms: `https://app.taslama.agency/terms`
- Support: `https://app.taslama.agency/support`
- Installation and security guide: `https://app.taslama.agency/taslama-plugin`

If the host requires a no-MFA reviewer account, create a narrowly scoped account
for review only and rotate or disable it after review. Do not weaken production
accounts or share an existing staff account.

## Review flow

1. Open the published Taslama listing in the host product.
2. Choose **Connect** / **Install**.
3. Confirm that the host follows the OAuth challenge to Taslama.
4. Sign in with the owner-provided reviewer account.
5. Select `<REVIEWER_TEST_PROJECT>` and inspect the requested scopes.
6. Approve access and return to the host product.
7. Start with a read-only prompt from [evaluation-cases.md](evaluation-cases.md).
8. For a write case, verify the proposed change and confirmation step before approving it.
9. Disconnect/reconnect and confirm that project selection is required again.

## Expected security behavior

- The selected project is carried by the OAuth grant; a prompt cannot override it.
- Account membership and role checks remain enforced by the MCP server.
- Read-only requests do not require a write confirmation.
- Supported writes require explicit confirmation unless the host's approval mode
  already provides an equivalent user confirmation.
- Invalid, expired, or revoked tokens fail without exposing credentials.
- Passwords, codes, and tokens are never requested in chat.
- A denied scope or role is not retried through a broader permission.

## Mobile/remote-client note

The integration is remote and has no local installation step. A host product may
surface the published app on mobile, web, desktop, or workspace surfaces according
to its own rollout and account policy. Reviewers should validate only the surfaces
listed in the actual submission form.

## Troubleshooting

- OAuth metadata or the MCP challenge fails: stop review and record the exact
  endpoint, status, and timestamp; do not create a client manually.
- Wrong project appears: disconnect the connection, revoke the grant if the host
  exposes that control, and repeat the selection with the test account.
- A write is unexpectedly allowed: stop the test and report the tool name and
  request; do not continue mutating data.
- A tool reports a missing collection/global: treat it as deployment/schema drift,
  not as an empty dataset.
