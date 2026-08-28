---
name: taslama-bookings
description: Create, update, review, or safely deduplicate bookings in one selected Taslama project. Use for individual bookings and structured booking batches that do not require spreadsheet parsing.
---

# Taslama Bookings

Work only in the project selected during Taslama OAuth authorization. Discover the available Taslama MCP booking tools and current permissions before acting.

## Prepare a booking

1. Resolve the customer by normalized phone first and email second. A similar name is supporting evidence only and must never merge two customers by itself.
2. Resolve the professional with the `$taslama-professionals` matching rules. Reuse an existing tenant professional when there is one confident normalized or transliterated match. Ask when multiple candidates are plausible.
3. Resolve service names to existing service IDs. Confirm duration, price, currency, status, local date and time, and timezone when they are not unambiguous.
4. Check the relevant professional schedule and nearby bookings when those reads are available. Report conflicts rather than creating around them silently.
5. Search for duplicates before creation:
   - skip an exact existing booking with the same customer, professional, service, and start time;
   - show approximate candidates with the same customer and professional near the requested time, then ask whether to create, update, or skip.

## Confirmation and writes

Show a concise preview before every create, update, delete, or status change unless the user's current instruction already confirms those exact records and values. Group batch decisions instead of interrupting once per booking.

Use the narrowest write tool. Preserve original timing and unrelated fields on updates. Read changed bookings back and report created, updated, skipped, conflicted, and unresolved counts. Never retry a permission failure through a broader tool or scope.
