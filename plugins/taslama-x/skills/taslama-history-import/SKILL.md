---
name: taslama-history-import
description: Recover, audit, and import historical Taslama salon bookings from messy Excel schedules or journals. Use for .xlsx history imports, Turkmenistan phone normalization, customer reconstruction, ambiguous booking review, vertical schedule blocks, duplicated or misspelled names, prices embedded with phones, and safe Taslama MCP customer or historical-booking writes.
---

# Taslama History Import

Recover historical bookings conservatively from visually structured salon journals. Treat the workbook as a schedule grid, not a flat table.

## Required companion skills

- Use the spreadsheet skill to inspect and render the workbook. Render representative sheets before deciding ownership rules.
- Use `taslama-operations` for MCP discovery, authorization scope, write limits, and post-write verification.

## Workflow

1. Preserve the original workbook. Store generated reports and payloads separately.
2. Inventory sheets, date titles, professional headers, time rows, merged cells, styles, and phone-bearing cells.
3. Render representative dense and sparse sheets. Infer the actual layout before parsing.
4. Parse bookings by sheet date, time row, and professional column. Never assign a phone from an adjacent professional column.
5. Normalize phones with `scripts/audit_history.py`; review its direct block links and unresolved report.
6. Build customer evidence from, strongest first:
   - phone embedded in the booking cell;
   - phone in the same vertical booking block and professional column;
   - exact repeated name with a single phone elsewhere in the workbook;
   - user-confirmed alias or relationship rule;
   - unique existing Taslama customer name only when it maps to one phone.
7. Classify every row as `confirmed`, `needs-review`, or `unresolved`. Do not invent a placeholder phone.
8. Preview exact counts, new customers, aliases, and ambiguous rows before a write unless the user already approved the precise operation.
9. Upsert confirmed new customers in batches of at most 100.
10. Import confirmed historical bookings in batches of at most 500. Preserve past time, duration, price, currency, status, and source note.
11. Read back imported records. Verify total created/skipped, real customer phones, duplicate handling, and zero technical placeholder bookings.

## Journal rules

- The first meaningful word is usually the customer name, but exclude administrative text and service-only phrases.
- A standalone phone below a booking belongs upward within the same professional column until the next descriptive booking cell.
- Do not use symmetric nearest-cell or nearest-phone matching. It leaks numbers between clients and professionals.
- A phone may be `63926303`, `863926303`, or `+99363926303`; normalize all three to `+99363926303`.
- Treat eight digits as a local phone. Treat nine digits beginning with `8` as a local phone with a trunk prefix. Treat eleven digits beginning `993` as international.
- Short numbers such as `50`, `100`, `300`, and arithmetic such as `150+250` are prices, not phone numbers.
- Text such as `второй номер` may explicitly select one of multiple phones. Require the wording or user confirmation before choosing.
- Name aliases may join spelling variants such as `Айлар` and `Айлара`; document every applied alias.
- Do not merge people only because names are similar. Repeated common names can have several valid phone numbers.
- Do not merge relatives by default. Phrases containing `мама`, `папа`, `сын`, `дочка`, or another relationship remain separate unless workbook evidence or the user explicitly says to reuse the named customer's phone.
- When the user confirms a relationship rule for one row, scope it to that row unless they explicitly make it global.

## Safety invariants

- Never use `+99300000000`, `Без Имени`, or another technical customer.
- Never delete or replace previously correct bookings when repairing a subset.
- Keep unresolved rows outside the import payload.
- Save the source row, sheet, time, professional, raw text, method, evidence, and normalized phone for each confirmed link.
- If two phones remain equally plausible, leave the row unresolved.
- MCP tool availability does not itself authorize a write; follow selected-project permissions.

## Resources

- Read [references/journal-heuristics.md](references/journal-heuristics.md) before a complex recovery or manual ambiguity pass.
- Run `scripts/audit_history.py WORKBOOK.xlsx --output-dir DIR` for a deterministic phone and visual-block inventory. Its output is evidence, not permission to import.
