# Taslama X submission checklist

Use this as an owner checklist before submitting the public OAuth distribution.
Unchecked items are intentionally not represented as completed.

## Product and package

- [ ] Confirm the public listing name is **Taslama** and the API-key plugin is
      excluded from public onboarding.
- [ ] Confirm the production MCP URL and OAuth metadata URLs.
- [ ] Run the plugin validator against `plugins/taslama-x`.
- [ ] Run `plugins/taslama-x/scripts/validate-oauth.sh` from a network-enabled
      environment.
- [ ] Verify icon/logo assets, repository URL, homepage, category, scopes, and
      user-facing descriptions.
- [ ] Re-run the positive and negative cases in [evaluation-cases.md](evaluation-cases.md)
      on disposable data and attach evidence.

## Publisher and legal

- [ ] Complete host-product publisher identity verification:
      `<PUBLISHER_VERIFICATION_REFERENCE>`.
- [ ] Verify ownership of the Taslama/app domain if required:
      `<DOMAIN_VERIFICATION_REFERENCE>`.
- [ ] Owner-review, deploy, and test the privacy policy at
      `https://app.taslama.agency/privacy`.
- [ ] Owner-review, deploy, and test the terms at
      `https://app.taslama.agency/terms`.
- [ ] Confirm `support@taslama.agency` is monitored and test the support page at
      `https://app.taslama.agency/support`.
- [ ] Document data retention, deletion/revocation, and subprocessors for the
      final privacy review.

## Reviewer access

- [ ] Create a dedicated reviewer account with safe test data:
      `<REVIEWER_EMAIL_OR_PHONE>`.
- [ ] Supply credentials only through the host's secure reviewer channel; never
      commit them or paste them into prompts.
- [ ] Confirm the reviewer account has the minimum project role and test scope.
- [ ] Confirm MFA/recovery requirements with the host instead of weakening a
      production account.
- [ ] Record the disposable test project and reset/cleanup procedure:
      `<REVIEWER_TEST_PROJECT>` / `<CLEANUP_PROCEDURE>`.

## Submission form

- [ ] Add the listing copy from [public-listing.md](public-listing.md).
- [ ] Add the reviewer steps from [oauth-reviewer-guide.md](oauth-reviewer-guide.md).
- [ ] Submit at least five positive and three negative test cases with expected
      behavior and evidence.
- [ ] Declare OAuth scopes, write confirmation behavior, and project isolation.
- [ ] Attach screenshots/video only after redacting customer data and tokens.
- [ ] Review host-specific app-directory/workspace requirements and complete any
      fields not represented here: `<HOST_PORTAL_REQUIREMENTS>`.
- [ ] Submit for review; record submission ID and status:
      `<SUBMISSION_ID>` / `<SUBMISSION_STATUS>`.

## After submission

- [ ] Do not announce public availability until the host marks the listing
      approved/published and the production smoke test passes.
- [ ] Rotate or disable reviewer credentials after review.
- [ ] Keep the Git marketplace documentation as developer-only fallback.
- [ ] If plugin manifest or MCP configuration changes, update the version and
      cachebuster through the official plugin-creator helper before distributing
      a new local package; documentation-only edits do not require that step.
