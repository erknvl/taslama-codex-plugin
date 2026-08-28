---
name: taslama-professionals
description: Find, reconcile, create, or update professionals in one selected Taslama project. Use when managing team profiles or matching imported staff names to existing tenant professionals.
---

# Taslama Professionals

Work only in the project selected during Taslama OAuth authorization. Discover the currently available Taslama MCP tools before acting.

## Resolve before creating

1. Read all relevant professionals in the selected project with pagination and `depth: 0`. Select IDs, localized names, phone or email when exposed, services, position, and publication state.
2. Normalize the requested name for comparison: Unicode form, case, surrounding whitespace, repeated spaces, punctuation, and common title prefixes. Compare both the original script and reasonable Turkmen, Latin, and Cyrillic transliterations.
3. Rank evidence:
   - exact normalized name plus matching phone or email;
   - exact normalized name;
   - equivalent transliteration plus matching service or other profile evidence;
   - similar spelling plus matching service or other profile evidence.
4. Reuse a single confident existing professional. Never create a duplicate merely because spelling, script, or casing differs.
5. If multiple records remain plausible, show a compact candidate table and ask the user to choose. Do not silently pick one.
6. If no record is credible, propose a new professional with at least a name and one or more services. Resolve service names to existing service IDs before creation.

Fuzzy name similarity alone can identify candidates but is not sufficient to merge, update, or delete records. Keep matching tenant-scoped; never reuse a professional from another project.

## Preview and writes

Before creating or updating, show the resolved existing record or proposed profile and the fields that will change. A grouped preview is preferred when several professionals need decisions.

After explicit approval, use the narrowest create or update tool and read the affected record back. Preserve unrelated localized fields, services, media, schedules, and publication settings. Never delete a professional as part of reconciliation unless the user separately requests deletion and confirms the exact record and consequences.
