# Public Wiki Content Review — Pass 2 Report

Date: 2026-10-07

## Scope

Focused public-content review of Races, Magic, Characters, and their directly related public pages. The approved taxonomy, global sidebar, and existing public routes were preserved.

## Files Changed

- `wiki/races/index.md`
- `wiki/races/ogre.md`
- `wiki/races/oni.md`
- `wiki/systems/natural-evolution.md`
- `wiki/evolution/index.md`
- `wiki/magic/index.md`
- `wiki/characters/index.md`
- `wiki/characters/luca.md`
- `assets/wiki/search.json`
- `scripts/generate_url_contract.rb`
- `docs/generated/PUBLIC_URL_CONTRACT.md` (regenerated)
- `docs/generated/PUBLIC_WIKI_CONTENT_REVIEW_PASS_2_REPORT.md` (new)

`_data/entities.yml`, `public-manifest.yml`, and `_data/navigation.yml` were audited and did not require changes in this pass.

## Races Review

- Preserved the current public set: Human, Elf, Dwarf, Goblin, Hiveborn, Dragonkind, Ogre, Orc, Harpy, and Gargoyle.
- Kept Race separate from Class, Authority, Sigils, political affiliation, nationality, and Great Power membership.
- Clarified that Bestiary creatures and biological races belong to separate archives.
- Removed the `Demonkind` category from Ogre; its historical/political use remains explained in prose rather than functioning as a biological parent category.
- Did not add Giant, Fishman, Merfolk, Wyvern, or other unlisted private/provisional entries.

## Natural Evolution Review

- Defined Natural Evolution as lasting biological lineage development rather than Class advancement, training, politics, or Authority recognition.
- Retained only the public paths Elf → High Elf / Dark Elf and Ogre → Oni.
- Recorded that Human and Dwarf have no known Natural Evolution.
- Removed the mechanics-facing terms `Aethra Pattern` and `Stage 1` from the reviewed public pages.
- Reduced the legacy `/wiki/evolution/` page to a concise contextual link to the canonical systems overview while preserving its route.

## Magic Review

- Added the seven approved major affinities: Fire, Ice, Earth, Wind, Lightning, Light, and Dark.
- Documented only Fire ↔ Ice and Light ↔ Dark as established opposed relationships.
- Explicitly avoided a complete symmetrical wheel; Earth ↔ Wind is not locked and Lightning has no public opposite.
- Clarified that magic is not universal and depends on aptitude, Aethra sensitivity, training, and available traditions.
- Kept magic distinct from Race, Natural Evolution, Sigils, and Authority.
- Recorded that affinity does not determine morality and that Dark is not inherently evil.
- Added reader-safe Light applications and Lesser Heal as the known basic example.
- Added one concise civilian example: practical Ice magic supporting refrigeration, storage, fishing logistics, medicine, and trade.
- Added contextual links to Aethra, Astrelia, Solmaria, and Sigils.

## Characters Review

- Preserved the public `Founding Five` heading and its `#founding-five` anchor, with a spoiler-safe early-story description.
- Renamed the Beta War group to `Historical Figures` while preserving the protected `#beta-war` anchor.
- Kept the directory limited to the nine characters already present in the public manifest with existing pages.
- Added missing search entries for Eldren and Rolan, plus the Characters portal itself.
- Did not add Rae or any private/future character.
- Recorded Rolan's Chapter 2 role as Guildmaster of the Arklune Adventurers' Guild.

## Luca Spoiler-Safety Review

- Luca remains unqualifiedly `Race: Human`.
- Removed the special Races-page wording `At the current public narrative state`, which could imply a hidden classification.
- Added only safe contextual links from Luca to Human, Aven, and Arklune.
- No Firstborn, Unbound, Sovereign, Bestowal, hidden evolution, or Light/Dark future material appears.

## Character Publication Audit

Public manifest and page audit confirmed these approved profiles:

- Luca
- Serena
- Lysara
- Zerak
- Pip
- Garling
- Rolan
- Eldren
- Raizen

Rae has no public character page and is not linked to Rhaen. Rhaen remains independently documented only in already-public Dragon Throne material.

## Cross-Taxonomy Corrections

- Race ≠ Class, Authority, Sigil, or political faction.
- Natural Evolution ≠ Class advancement, magical training, or Authority recognition.
- Monster/Bestiary ≠ Race.
- Magic affinity ≠ Sigil/Authority.
- Demonkind remains historical, cultural, political, or social terminology rather than a biological superclass.

## Links Added or Removed

Added:

- Races → Natural Evolution, Class, Sigils, Luca
- Magic → Aethra, Sigils, Astrelia, Solmaria
- Luca → Human, Aven, Arklune

Simplified:

- Legacy Evolution portal now links to the canonical Natural Evolution systems page instead of duplicating the full tree.

No broken or circular link pattern was introduced.

## Private and Spoiler Issues Found

- `At the current public narrative state` beside Luca's Human classification risked implying hidden biology; removed.
- `Aethra Pattern` and `Stage 1` introduced unnecessary mechanics/game-stat framing; removed from the reviewed Natural Evolution pages.
- No Rae/Rhaen identity connection, private Asteron detail, or hidden Sovereign mechanic was found in the final scoped content.

## Routes

- Public routes before Pass 2: 71
- Public routes after Pass 2: 71
- Routes removed or renamed: none
- Redirects required: none
- Protected anchors: 5/5 preserved

## Validation

- Sidebar exact eight-entry order: passed
- Public race/entity boundary assertions: passed
- Natural Evolution/Class/Authority separation checks: passed
- Seven-affinity and opposed-pair assertions: passed
- Luca Human-only and spoiler scans: passed
- Rae/Rhaen separation scan: passed
- Visible Founding Five label scan: passed
- Character manifest/page/search audit: passed
- YAML parsing: passed
- Search JSON parsing: passed (50 entries)
- JavaScript syntax: passed
- Public URL contract generation: passed (71 routes)
- Internal links, anchors, assets, and navigation targets: passed
- Duplicate navigation target check: passed
- `git diff --check`: passed
- Jekyll build: unavailable because the `jekyll` executable is not installed in the current bundle

## Author Approval Required

- The public repository currently uses `Dragonkind` and contains no standalone public Wyvern race article. No Dragon/Wyvern biological relationship was added.
- Giant, Fishman, and Merfolk are not in the current public manifest and were not published.
- Dark absorption, drain, siphoning, and transfer behavior was not added because that detail is not established in the current public repository content.
