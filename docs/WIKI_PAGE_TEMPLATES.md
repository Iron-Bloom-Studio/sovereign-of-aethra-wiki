# Wiki Page Templates

Every public page must use released lore only. Omit unknown facts instead of publishing placeholders.

## Character

```yaml
---
layout: character
title: Character Name
slug: character-name
description: Short public definition.
image: /assets/characters/name/APPROVED_FILE.png # optional
image_alt: Approved character reference
race: Human # optional
era: Beta War # optional
categories: [Characters]
related: [beta-war]
public: true
spoiler_level: 0
---
```

Use `infobox.fields` for confirmed facts only.

## Race / Evolution

Use `layout: race` for a base lineage and `layout: evolution` for a known evolution form. Keep Race, Natural Evolution, Class, and Authority distinct.

## Faction / Location / Historical Event

Use `layout: faction`, `location`, or `event`. Add an infobox only for publicly confirmed facts. Use readable URLs under `/wiki/factions/`, `/wiki/locations/`, and `/wiki/history/`.
