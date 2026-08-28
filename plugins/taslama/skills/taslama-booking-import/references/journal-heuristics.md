# Taslama journal recovery heuristics

## Evidence ladder

Accept links in this order:

1. Same cell contains customer name, service text, and phone.
2. Same professional column contains a descriptive booking cell followed by a phone-only cell before the next descriptive cell.
3. Exact normalized name appears elsewhere in a same-column block with one unique phone across the workbook.
4. A documented alias maps a spelling variant to evidence from step 1-3.
5. The user confirms an otherwise ambiguous relationship or phone meaning.

Do not promote fuzzy string similarity alone to confirmed evidence.

## Visual structure

- Columns represent professionals. Rows represent time slots, commonly 30 minutes.
- White or specially colored cells often form active booking blocks; pink cells often mark unavailable space. Colors are hints, not authoritative ownership.
- A booking can span several rows: description, phone, price, and continuation notes may occupy separate cells.
- Only walk vertically inside one professional column. Adjacent columns are different professionals even when a value looks closer geometrically.
- Stop a phone-to-booking upward scan at the next descriptive cell, administrative block, or professional header.

## Phone normalization

| Raw | Normalized |
|---|---|
| `63926303` | `+99363926303` |
| `863926303` | `+99363926303` |
| `99363926303` | `+99363926303` |
| `+993 63 926 303` | `+99363926303` |

Reject phone-like values outside these forms unless the user supplies another country rule.

## Price parsing

- Values shorter than eight digits are not Turkmenistan phones.
- `100`, `150`, `300`, `150+250`, and comma-separated service totals normally represent prices.
- Preserve price in minor units: `100 TMT` becomes `10000`.
- If multiple phone-sized values and a short value occur together, keep the short value as price.

## Names and relationships

- Normalize case, whitespace, punctuation, and `ё`/`е` before comparison.
- The first meaningful word before a recognized service usually represents the customer.
- Keep an explicit alias ledger. Do not silently expand aliases globally.
- Similar names such as Арина, Карина, Марина, and Ирина are distinct without exact evidence.
- `мама`, `папа`, `сын`, `дочка`, and similar words indicate a potentially separate person. Reuse a phone only with direct evidence or explicit user confirmation.
- If the user confirms `мяхри мама` should use Mяхри's phone, apply that rule to the specified row; do not infer that all relatives share phones.

## Review report

For every unresolved row show the sheet/date, time, professional, raw text, parsed name, phone candidates with cell coordinates and evidence, and rejection reason.

Useful rejection reasons include `no-phone-evidence`, `multiple-exact-name-phones`, `cross-column-only`, `relationship-ambiguous`, and `service-only-no-name`.

## Import verification

- Imported count equals confirmed payload count minus exact duplicates.
- No imported booking uses a placeholder phone.
- Every referenced phone resolves to a customer in the selected project.
- Existing correct bookings remain present.
- Source notes trace each record to its workbook cell.
