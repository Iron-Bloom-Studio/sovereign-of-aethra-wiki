# Public Wiki Taxonomy Correction Report

Date: 2026-10-06

## Scope

Focused correction of the existing public navigation taxonomy. No routes were renamed, no visual redesign was performed, and no private Author Bible material was introduced.

## Files Changed

- `_data/entities.yml`
- `public-manifest.yml`
- `wiki/realms/index.md`
- `wiki/factions/other/index.md`
- `wiki/factions/seven-sigils.md`
- `wiki/factions/index.md`
- `wiki/systems/sigils.md`
- `wiki/systems/index.md`
- `wiki/categories/authority.md`
- `wiki/races/demonkind.md`
- `assets/wiki/search.json`
- `docs/generated/PUBLIC_URL_CONTRACT.md` (regenerated)
- `docs/generated/TAXONOMY_CORRECTION_REPORT.md` (new)

`_data/navigation.yml` was audited but did not require modification.

## Seven Sigils Naming

- Preferred public display name: **The Seven Sigils**.
- Article title, heading, breadcrumb, public index labels, related links, and search title were standardized.
- Existing route preserved: `/wiki/factions/seven-sigils/`.
- The Seven Sigils remains exactly one Great Power.
- Alpha, Beta, Gamma, Delta, Theta, Sigma, and Omega remain child Sigil identifiers, not separate Great Powers.
- The lore/Authority `Sigils` index remains separate at `/wiki/systems/sigils/`.

## Realms & Civilizations Grouping

### Before

- Great Powers
- Human Kingdoms
- Independent Polities and Organizations

### After

- Great Powers
- Kingdoms & States
- Independent Realms & Cities
- Organizations
- Other Factions

The Great Powers section contains the six currently public members. The Human kingdoms appear under Kingdoms & States. Arklune appears under Independent Realms & Cities. The Grand Adventurer Guild appears under Organizations. Rogue Hive / Zavor and the unavailable Beta Remnant entry appear under Other Factions.

## Central Entity Classification

- `seven-sigils`: `great_power`, classified as an Authority-based geopolitical Great Power.
- `arklune`: `independent_city_state`.
- `grand-adventurer-guild`: `organization`, while retaining its existing section-anchor destination.
- `rogue-hive` and `beta-remnant`: remain `other_faction`; Beta Remnant remains unavailable.

The public manifest now records The Seven Sigils under factions, the Grand Adventurer Guild under organizations, and Rogue Hive under other factions. The general Sigils Authority index remains under systems.

## Route Compatibility

- Current public routes: 71
- Existing routes removed or renamed: none
- Redirects added: none required
- Grand Adventurer Guild destination preserved: `/wiki/locations/arklune/#the-grand-adventurer-guild`
- Rogue Hive destination preserved: `/wiki/factions/the-hive/#the-rogue-hive`
- Protected anchors validated: 5/5

## Validation

- Sidebar exact eight-item order: passed
- Six Great Powers and one Seven Sigils membership assertion: passed
- Five required Realms & Civilizations headings: passed
- Entity classification assertions: passed
- YAML parsing: passed
- Search JSON parsing and title/type assertions: passed
- Public URL contract generation: passed (71 routes)
- Internal links, anchors, assets, and navigation targets: passed
- Duplicate navigation target check: passed
- JavaScript syntax: passed
- `git diff --check`: passed
- Private/spoiler-term scan of changed public content: passed
- Jekyll build: unavailable because the `jekyll` executable is not installed in the current bundle

## Unresolved Taxonomy Ambiguity

- Beta Remnant is publicly named but has no approved standalone destination or descriptive public article. It remains an unavailable entry under Other Factions rather than receiving invented content.

No further taxonomy conflict was found in the scoped public pages.
