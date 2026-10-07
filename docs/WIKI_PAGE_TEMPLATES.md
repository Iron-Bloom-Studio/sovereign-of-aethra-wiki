# Wiki Page Templates

Every public page must use released lore only. Omit unknown facts instead of publishing placeholders.

## Character

```yaml
---
layout: character
title: Character Name
slug: character-name
description: Short public definition.
character_sheet: true
character_looks:
  - id: present
    label: Present
    portrait: /assets/characters/name/wiki/name-present-portrait.png
    portrait_alt: Public-safe description of the portrait
    reference_sheet: /assets/characters/name/reference/name-present-sheet.png
    reference_sheet_alt: Public-safe description of the sheet
    publish_reference_sheet: true # only with explicit public approval
infobox:
  name: Character Name
  fields:
    Race: Human
---
```

Use `infobox.fields` for confirmed facts only.

Named-character artwork uses two distinct tiers:

- **Character Sheet** — private/internal production reference and visual source of truth. Do not copy it into the public wiki automatically.
- **Wiki Portrait** — clean, spoiler-safe public artwork used by character pages and navigation cards.

Use `portrait` for new public artwork. `reference_sheet` exists as a migration fallback for sheets that were already explicitly public-safe. Set `publish_reference_sheet: true` only when the exact sheet is approved for the public Character Reference section below the article; omission is fail-closed. It must never point to private or spoiler-sensitive production material. Do not add unrevealed forms as hidden tabs, metadata, filenames, or unused frontmatter.

## Race / Evolution

Use `layout: race` for a base lineage and `layout: evolution` for a known evolution form. Keep Race, Natural Evolution, Class, and Authority distinct.

## Faction / Location / Historical Event

Use `layout: faction`, `location`, or `event`. Add an infobox only for publicly confirmed facts. Use readable URLs under `/wiki/factions/`, `/wiki/locations/`, and `/wiki/history/`.
