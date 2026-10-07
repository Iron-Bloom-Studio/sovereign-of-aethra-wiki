# Character Art Asset Structure Report

## Model Introduced

Named-character art now follows a documented two-tier model:

1. **Character Sheet** — private/internal production reference and visual source of truth.
2. **Wiki Portrait** — clean, spoiler-safe public artwork for character panels, cards, and public presentation.

The public character panel prefers `portrait`, retains legacy `image` compatibility, and uses `reference_sheet` only as a temporary fallback when that exact sheet was already publicly approved. Private sheets are not automatically rendered as gallery content or copied into the wiki.

## Files Changed

### Private master

- `author-bible/production/CHARACTER_ART_ASSET_POLICY.md`
- `assets/races/README.md`
- `assets/ASSET_MANIFEST.md`
- `docs/PUBLIC_WIKI_PUBLICATION_MANIFEST.yml`
- Added approved Human and Elf generic race reference assets.

### Public wiki

- `_includes/character-profile-panel.html`
- `assets/wiki/character-gallery.css`
- `docs/WIKI_PAGE_TEMPLATES.md`
- `docs/REUSABLE_ARTICLE_COMPONENTS.md`
- `wiki/characters/luca.md`
- `wiki/characters/garling.md`
- `wiki/characters/rolan.md`
- `wiki/characters/rae.md`
- `wiki/characters/bram.md`
- `wiki/characters/deren.md`
- `wiki/races/human.md`
- `wiki/races/elf.md`
- `wiki/races/dwarf.md`
- `wiki/races/hiveborn.md`
- `wiki/races/dragonkind.md`
- Added Rae's first dedicated Wiki Portrait.
- Added Luca's dedicated Wiki Portrait while retaining his explicitly approved Character Sheet below the article.
- Added Serena's dedicated Wiki Portrait while retaining her explicitly approved Character Sheet below the article.
- Added Lysara's dedicated Wiki Portrait and updated Mage Character Sheet below the article.
- Added Pip's dedicated Wiki Portrait while retaining his explicitly approved Character Sheet below the article.
- Added Zerak's dedicated Wiki Portrait while retaining his explicitly approved Character Sheet below the article.
- Added Raizen's dedicated Wiki Portrait while retaining his explicitly approved Beta War Character Sheet below the article.
- Added Reika's approved Character Sheet and public character route under Seven Sigils Characters.
- Added Bram's dedicated Wiki Portrait with a name-only public entry.
- Added public Human, Elf, Dwarf, Hiveborn, and Dragonkind generic race reference assets.

### Local artwork archive

- `README.md`
- Added Human, Elf, Dwarf, Hiveborn, and Dragonkind sheets under `02-Races/<Race>/Approved/`.
- Added Rae's portrait under `01-Characters/Rae/Wiki/`.
- Added Lysara's portrait and current Mage sheet under `01-Characters/Lysara/Wiki/`.
- Added Pip's portrait under `01-Characters/Pip/Wiki/`.
- Added Zerak's portrait under `01-Characters/Zerak/Wiki/`.
- Added Raizen's portrait under `01-Characters/Raizen/Wiki/`.
- Added Reika's sheet under `01-Characters/Reika/Approved/`.

## Migration and Fallback

- Luca now uses a dedicated Wiki Portrait. His exact approved public-safe sheet is opt-in below the article as Character Reference.
- Serena, Lysara, Pip, and Zerak now follow the same portrait-first pattern, with their approved public-safe sheets shown below the article.
- Garling still lacks a dedicated Wiki Portrait; his previously public-safe sheet remains a temporary panel fallback and is not automatically duplicated into a gallery.
- Rolan Guildmaster has no approved portrait and uses the compact missing-portrait state.
- Other legacy character pages remain compatible while they are migrated gradually.
- No existing binary artwork was altered or destructively cropped.

## Rae

Rae is the first complete Wiki Portrait example. `SOA_RAE_WIKI_PORTRAIT_v01.png` is stored under the dedicated `wiki/` tier and used by `/wiki/characters/rae/`. The current page intentionally contains only Rae's name and portrait, with no lore or profile fields.

## Deren

`SOA_DEREN_WIKI_PORTRAIT_v01.png` is stored in the private export source, public wiki, and local artwork archive. `/wiki/characters/deren/` intentionally contains only Deren's name and portrait, with no inferred race, age, origin, occupation, or relationships.

## Bram

`SOA_BRAM_WIKI_PORTRAIT_v01.png` is stored in the private export source, public wiki, and local artwork archive. The current page intentionally contains only Bram's name and portrait.

## New Generic Race References

- Human: `SOA_HUMAN_RACE_REFERENCE_v01.png`
- Elf: `SOA_ELF_RACE_REFERENCE_v01.png`
- Dwarf: `SOA_DWARF_RACE_REFERENCE_v01.png`
- Hiveborn: `SOA_HIVEBORN_RACE_REFERENCE_v01.jpg`
- Dragonkind: `SOA_DRAGONKIND_RACE_REFERENCE_v01.jpg`

These are generic race references, not named-character sheets and not Wiki Portraits.

The supplied Vargan file is byte-for-byte identical to the existing private approved `SOA_VARGAN_EVOLUTION_REFERENCE_v01.png`. No duplicate was created and it remains private because its lore/publication status is provisional.

## Validation

- Public URL contract: 75 routes; no existing route removed.
- Protected anchors: five; all valid.
- Internal links, assets, navigation targets, and character image paths: valid.
- Search JSON: valid with 54 unique entries.
- Public and private YAML manifests: valid.
- Rae spoiler scan: passed; no Rhaen, Dragonkind, alias, or hidden-identity disclosure.
- Rae, Bram, and Deren name-only audit: passed; no lore/profile fields are rendered.
- Vargan public-export scan: passed; no Vargan file or route exists in the public repository.
- Cross-repository checksums for exported portraits and race references: matched.
- JavaScript syntax, CSS braces, and `git diff --check`: passed.
- Local Jekyll build: unavailable because the Jekyll executable is not installed.
