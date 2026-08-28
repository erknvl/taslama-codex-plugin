---
name: taslama-booking-import
description: Inspect arbitrary Excel or CSV booking files, reconcile customers and professionals with one Taslama project, preview ambiguities and duplicates, and import confirmed bookings safely.
---

# Taslama Booking Import

Preserve the source file. Store generated reports and payloads separately. Work only in the project selected during Taslama OAuth authorization.

## Inspect and map

1. Inventory sheets, headers, merged cells, date and time patterns, styles, and populated regions. Render representative spreadsheet regions when visual structure matters.
2. Infer candidate columns for date, time, customer, phone, email, professional, service, duration, price, currency, status, and notes. Ask the user to confirm the detected mapping before any write when the layout is not explicit.
3. Parse rows into a normalized staging report that retains source sheet, row or cell, and original values.

For legacy calendar-style journals, read [references/journal-heuristics.md](references/journal-heuristics.md) and run `scripts/audit_spreadsheet.py WORKBOOK.xlsx --output-dir DIR` when its vertical-block model fits the workbook.

## Reconcile records

- Customers: match normalized phone first, email second. Names are supporting evidence only. Never merge customers from fuzzy names alone or invent placeholder contact data.
- Professionals: load the selected project's full professional list and apply the `$taslama-professionals` rules. Normalize case, spacing, punctuation, and Turkmen, Latin, or Cyrillic transliterations. Reuse one confident match rather than creating a spelling duplicate.
- If several professionals are plausible, collect them into one review table and ask the user to choose.
- If no professional matches, propose creation with the imported name and resolved service IDs. Do not create until the preview is approved.
- Services: resolve names to existing tenant services. Keep unknown or ambiguous services unresolved rather than creating them implicitly.

## Mandatory dry-run

Always show a dry-run before writes. Include:

- total parsed rows and rows ready to import;
- existing professional and customer mappings;
- proposed new professionals with names and services;
- proposed new customers;
- exact duplicates that will be skipped;
- approximate duplicate candidates requiring a decision;
- unresolved or rejected rows with reasons;
- planned write counts and batch sizes.

Group questions by repeated name or issue so the user can resolve many rows with one answer. A confirmation applies only to the displayed mapping and payload unless the user explicitly establishes a broader alias rule.

## Duplicate and import behavior

- Skip exact existing bookings with the same customer, professional, service, and start time.
- Treat nearby bookings for the same customer and professional as approximate duplicates; ask whether to skip, update, or create.
- Create approved professionals before bookings, then read them back and use returned IDs.
- Upsert confirmed customers in batches of at most 100.
- Import historical bookings in batches of at most 500; use ordinary booking creation for current or future bookings when appropriate.
- Preserve date, time, duration, price, currency, status, and traceable source notes.
- Keep unresolved rows outside write payloads.

After import, read back affected records and report created, updated, exact-duplicate skipped, approximate-duplicate decision, and unresolved counts. Confirm that no placeholder customer or unintended professional was created.
