# Public Wiki Metadata Schema

This schema is the foundation for future public Wiki tooling. It does not by itself change visible article content or publication status.

## Core Fields

| Field | Meaning | Rule |
|---|---|---|
| `public` | Whether an article is approved for the public Wiki | Must reflect an explicit publication decision. Do not infer approval from another field. |
| `spoiler_level` | Reader-facing disclosure level | Use only a project-approved numeric level. |
| `canon_status` | Editorial canon maturity | Leave unset when no approved status exists. |
| `content_type` | Structural article type | Examples: `character`, `race`, `creature`, `faction`, `realm`, `location`, `event`, `lore`, `portal`. |
| `category` | Primary public category | Use one approved taxonomy label. |
| `categories` | Additional public categories | Use a YAML list. Do not use categories to imply unrevealed lore. |
| `related` | Approved related-entity identifiers | Use a YAML list of stable identifiers. A layout must not fabricate missing pages from these values. |

## Allowed `canon_status` Values

- `LOCKED`
- `PROVISIONAL`
- `CONCEPT`
- `TBD`
- `DEPRECATED`

Do not automatically assign a status based on completeness, age, wording, or repository location. Missing status remains unset until author review.

## Publication Separation

- `canon_status` and `public` answer different questions.
- `LOCKED` does not automatically mean public.
- `PROVISIONAL` does not automatically mean hidden.
- Public navigation must not create a page or reveal content merely because an entity identifier exists in `_data/entities.yml`.
- Items marked `available: false` are taxonomy reservations, not public lore pages.

## Compatibility

Existing articles may continue using `status` during the transition. Future migrations should map fields only after an explicit review; this phase does not bulk-rewrite article front matter.
