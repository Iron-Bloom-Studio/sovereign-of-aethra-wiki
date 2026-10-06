# Public Wiki Artwork Correction and Asset Sync Report

## 1. Terminology corrections

- Current public lore now uses **Great Dragon Mountain** in the singular.
- **The Dragon Throne** is presented as Dragonkind's sacred high seat at the summit of Great Dragon Mountain, above the cloud layer and physically part of the mountain rather than a floating island.
- **Khazir** remains the Dwarven reference and is associated with the **Dwarven Holds**.
- Public text no longer associates Khazir or the Dwarven Holds with Great Dragon Mountain.
- The obsolete Dragonkind name `Drakara` was removed from the reader-facing Dragon Throne article. No current page, caption, front matter, search entry, or manifest entry uses it as active lore.

## 2. Artwork discovered locally

Verified local files include:

- Arklune Grand Adventurer Guild exterior.
- Arklune Grand Adventurer Guild Hall interior.
- Arklune ceremonial banner.
- Generic Goblin variants sheet with an approximately 130 cm adult reference.
- Current Ogre, Oni, Orc, Harpy, Gargoyle, and Vargan visual sheets.

The author explicitly approved the generic Goblin sheet. Source, Master, artwork archive, and Wiki copies are byte-identical (SHA-256 `bed2908296203c2058e6b1127775f71d67197ddf51bc3e12143bd86af79534f8`).

## 3. Artwork promoted to Master approved assets

The following assets had already been promoted to the private Master approved directories and were verified during this pass:

- `SOA_ARKLUNE_GRAND_ADVENTURER_GUILD_EXTERIOR_v01`
- `SOA_ARKLUNE_GRAND_ADVENTURER_GUILD_INTERIOR_v01`
- `SOA_ARKLUNE_CEREMONIAL_BANNER_v01`
- `SOA_GOBLIN_RACE_REFERENCE_v01`
- `SOA_OGRE_RACE_REFERENCE_v01`
- `SOA_ONI_EVOLUTION_REFERENCE_v01`
- `SOA_ORC_RACE_REFERENCE_v01`
- `SOA_HARPY_RACE_REFERENCE_v01`
- `SOA_GARGOYLE_RACE_REFERENCE_v01`

The Vargan visual remains preserved in the private Master and artwork archive with provisional-lore handling. It is not published in the Wiki because its evolutionary relationship is not public-safe.

## 4. Artwork copied to Wiki public assets

The verified Arklune exterior, interior, and ceremonial banner are present in the Wiki and are byte-identical to their Master copies. The current Goblin, Ogre, Oni, Orc, Harpy, and Gargoyle sheets are also present in their appropriate public asset directories.

No image was edited, re-encoded, generated, or hotlinked during this correction pass.

## 5. Wiki pages updated

- `wiki/factions/dragon-throne.md`
- `wiki/factions/dwarven-holds.md`
- `wiki/factions/index.md`
- `wiki/locations/khazir.md`
- `wiki/races/dragonkind.md`
- `wiki/races/goblin.md`
- `wiki/races/index.md`
- `wiki/realms/index.md`
- `wiki/world/terra.md`
- `wiki/artwork.md`

The Arklune article continues to show the Guild exterior, Guild Hall interior, and banner in its existing approved visual section. A dedicated Arklune cityscape was not substituted because none was found.

The provisional Vargan page and its public navigation/search/gallery references were removed to avoid exposing an unrevealed evolutionary relationship. Its private source asset was retained.

## 6. `public-manifest.yml` changes

- Removed Vargan from public evolution entities.
- Removed `SOA_VARGAN_EVOLUTION_REFERENCE_v01` from public assets.
- Added `SOA_GOBLIN_RACE_REFERENCE_v01` after explicit author approval.
- Retained the verified Arklune, Ogre, Oni, Orc, Harpy, and Gargoyle identifiers.
- No Alpha, Beta, or Gamma banner identifiers were added because no matching local files were found.

## 7. Artwork found but intentionally not published

- `SOA_VARGAN_EVOLUTION_REFERENCE_v01.png`: retained privately because publication would reveal an unreleased evolution branch.
- Founding Goblin and Founding Hiveborn sheets: character-specific references, not current generic race sheets.
- Archived superseded character sheets remain stored but are not used as current page artwork.

## 8. Artwork needing manual review

- **Vargan** — visual approval is recorded privately, but public-release permission for the identity and evolutionary relationship is absent.

## 9. Missing expected artwork

- Dedicated Arklune cityscape separate from the Guild exterior.
- Standard field banner of Alpha (black and gold).
- Standard field banner of Beta (black and red).
- Standard field banner of Gamma (black and purple).

No substitute or invented artwork was used.

## 10. Duplicate and broken asset findings

- The approved Goblin source, Master, archive, and Wiki copies have matching hashes. The former `Review-Pending` copy was promoted into `02-Races/Goblin/Approved/`.
- Arklune source, Master, and Wiki copies match by SHA-256.
- No broken local image reference was found after validation.
- No private absolute path, `file://` URL, temporary URL, or external image hotlink was introduced.

## 11. Validation results

- Public URL contract regenerated with **69 URLs**.
- Protected anchors checked: **5**, all valid.
- Internal links, anchors, local assets, entity destinations, and navigation targets: **passed**.
- YAML parsing for `public-manifest.yml` and `_data/entities.yml`: **passed**.
- JavaScript source load through macOS JavaScriptCore: **passed** (`node` is not installed in this environment).
- `git diff --check`: **passed**.
- Current public pages, front matter, search metadata, and manifest contain no active `Drakara` reference and no plural `Great Dragon Mountains` reference.
- No public Vargan page, search entry, entity entry, manifest entry, or artwork reference remains.
- Duplicate raster hashes inside the public Wiki: **0**.

## 12. Jekyll build result

The production build could not run in this checkout. `bundle exec jekyll build` reported that the Jekyll executable is missing; the instructed `bundle install` fallback could not install it because the repository has no `Gemfile`. No unsafe system installation or `sudo` action was attempted.

## 13. Commit and push

No commit or push was performed because the required Jekyll production build could not pass in the current checkout. The working tree also contains earlier unrelated and uncommitted work, which was preserved.
