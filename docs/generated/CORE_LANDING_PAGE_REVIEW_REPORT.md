# Core Landing Page Public-Content Review

Date: 2026-10-06

## Scope

Focused reader-facing cleanup of World, Realms & Civilizations, Sigils, and the related Great Power article The Seven Sigils. The stable navigation taxonomy and global sidebar were not changed.

## Files Changed

- `wiki/world/index.md`
- `wiki/realms/index.md`
- `wiki/systems/sigils.md`
- `wiki/factions/seven-sigils.md`
- `wiki/categories/authority.md`
- `wiki/systems/index.md`
- `assets/wiki/search.json`
- `docs/generated/PUBLIC_URL_CONTRACT.md` (regenerated)
- `docs/generated/CORE_LANDING_PAGE_REVIEW_REPORT.md` (new)

## World

- Added a concise reader-facing introduction to Terra.
- Organized the landing page around Terra, Geography, Regions & Continents, Aethra, and History.
- Added contextual links to the existing Terra headings and History portal.
- Kept Realms & Civilizations as a contextual political-geography link rather than merging political taxonomy into World.
- Did not add Races, Characters, Great Powers, Sigils, Relics, or Bestiary as World categories.

## Realms & Civilizations

- Preserved the locked five-section hierarchy: Great Powers; Kingdoms & States; Independent Realms & Cities; Organizations; Other Factions.
- Preserved exactly six Great Powers, with The Seven Sigils represented once.
- Added concise present-era context: post-Beta War relations include trade and diplomacy alongside distrust and rivalry.
- Clarified that Arklune is comparatively open without presenting it as representative of all Terra.
- Preserved Grand Adventurer Guild under Organizations and Beta Remnant as unavailable.

## Sigils

- Renamed the landing-page display from “Sigils and Authority” to the cleaner public label “Sigils”; the route remains `/wiki/systems/sigils/`.
- Added a concise Authority overview and clear separation from Race, Natural Evolution, Class, and political affiliation.
- Added a Known Sigils section listing Alpha, Beta, Gamma, Delta, Theta, Sigma, and Omega without inventing individual mechanics or pages.
- Added a Bearers and Domains section distinguishing Authority, bearer/status, and political domain.
- Added a short link to The Seven Sigils as a geopolitical Great Power without duplicating the political article.

## The Seven Sigils

- Title remains exactly **The Seven Sigils**.
- Frontmatter classification is now explicitly `Great Powers` while retaining Authority and World Lore categories.
- Reframed the article around the Great Power, its associated political domains, and the distinction between Sigils, bearers, and domains.
- Retained Alpha through Omega as identifiers inside one Great Power, not separate Great Powers.
- Replaced detailed Authority discussion with a contextual link back to the Sigils lore index.
- Preserved `/wiki/factions/seven-sigils/`.

## Cross-Link Changes

Added or clarified:

- World → Terra, Geography, Great Continent, Aethra, History, Realms & Civilizations
- Sigils → The Seven Sigils, Garling, Raizen, Beta War, Races, Natural Evolution, Class
- The Seven Sigils → Sigils, Realms & Civilizations, Great Powers, Beta War, Raizen

Removed redundant links from The Seven Sigils article where they did not directly support its geopolitical purpose. Individual Alpha–Omega links were not created because no approved standalone public routes exist.

## Lore and Spoiler Review

- No private Author Bible material was added.
- No Loom, Sovereign Core, Bestowal, Firstborn, hidden Luca classification, hidden World Heart, future transcendence, or unpublished Asteron mechanics were exposed.
- The Sigils page does not claim biological ownership, hereditary recognition, universal race eligibility, or unrevealed selection rules.
- The Seven Sigils article no longer functions as a mechanics dump; detailed unrevealed origins and selection rules remain absent.

## Taxonomy Review

No new taxonomy inconsistency was found. The locked baseline remains intact:

- Sidebar: eight primary entries in the approved order.
- The Seven Sigils: one Great Power.
- Sigils: separate Authority/lore taxonomy.
- Arklune: `independent_city_state`.
- Grand Adventurer Guild: `organization`.
- Beta Remnant: unavailable.
- Bestiary remains separate from Races.

## Route Preservation

- Public routes before review: 71
- Public routes after review: 71
- Routes removed or renamed: none
- Redirects required: none
- Protected anchors: 5/5 preserved

## Validation

- YAML parsing: passed
- Search JSON parsing: passed
- JavaScript syntax: passed
- Exact sidebar assertion: passed
- Taxonomy/entity assertions: passed
- Public URL contract generation: passed (71 routes)
- Internal links, anchors, assets, and navigation targets: passed
- Duplicate navigation target check: passed
- Public naming scan: passed
- Private/spoiler-term scan of changed public pages: passed
- `git diff --check`: passed
- Jekyll build: unavailable because the `jekyll` executable is not installed in the current bundle

## Author Approval Required

- No individual public pages currently exist for Alpha, Beta, Gamma, Delta, Theta, Sigma, or Omega. They remain a reader-safe list rather than links; adding individual destinations requires approved public content.
- Beta Remnant remains named but unavailable because no approved standalone article exists.
