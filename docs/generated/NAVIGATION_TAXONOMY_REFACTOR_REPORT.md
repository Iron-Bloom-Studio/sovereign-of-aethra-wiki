# Public Wiki Navigation & Taxonomy Refactor Report

Date: 2026-10-06

## Scope

This report covers the public-wiki navigation refactor only. Existing unrelated working-tree changes were preserved.

## Files Changed

- `_data/navigation.yml`
- `_data/entities.yml`
- `_includes/nav.html`
- `index.md`
- `wiki/realms/index.md`
- `wiki/magic/index.md` (new)
- `wiki/relics-artifacts/index.md` (new)
- `assets/wiki/search.json`
- `assets/wiki/wiki.css`
- `public-manifest.yml`
- `docs/generated/PUBLIC_URL_CONTRACT.md` (regenerated)
- `docs/generated/NAVIGATION_TAXONOMY_REFACTOR_REPORT.md` (new)

## Navigation Architecture

The wiki uses a data-driven navigation architecture:

- `_data/navigation.yml` defines the header, sidebar, and footer composition.
- `_data/entities.yml` is the central registry for public labels, destinations, availability, and content types.
- `_includes/navigation-tree.html` renders registered entries.
- `_includes/nav.html` renders the sidebar from the YAML source of truth.

### Before

The sidebar acted as a broad sitemap with multiple sections: Explore, Great Powers, Other Factions, and The Seven Sigils. It exposed individual powers, factions, organizations, and Sigil identifiers globally.

### After

The sidebar contains exactly these eight primary entries, in order:

1. World
2. Realms & Civilizations
3. Races
4. Characters
5. Bestiary — Not Yet Public
6. Relics & Artifacts
7. Magic
8. Sigils

Detailed entities remain accessible from their landing pages. No navigation logic was duplicated, and responsive behavior continues to use the existing renderer and mobile menu.

## Taxonomy Changes

- Great Powers remains a valid public taxonomy but is no longer a top-level sidebar section.
- `Realms & Civilizations` now surfaces the Great Powers index, all six current Great Powers, Human kingdoms, Arklune, the Grand Adventurer Guild, and Other Factions.
- The Seven Sigils is represented as one Great Power. Alpha, Beta, Gamma, Delta, Theta, Sigma, and Omega are not represented as separate Great Powers.
- `Sigils` links to the public Authority/lore index at `/wiki/systems/sigils/`; this remains separate from the Seven Sigils political classification.
- Races, Characters, and Bestiary remain separate taxonomies.

## New Public Pages

- `/wiki/magic/` — minimal reader-safe overview linking to already-public Aethra and Astrelia material.
- `/wiki/relics-artifacts/` — minimal archive landing page without invented entries.

Bestiary remains unavailable and has no new content page.

## Homepage

Primary archive cards now match the new information architecture: World, Realms & Civilizations, Races, Characters, Bestiary, Relics & Artifacts, Magic, and Sigils. History and Novel remain available as homepage cards. Great Powers and Evolution are no longer first-level cards; their existing pages and routes remain intact.

## Route Compatibility

- Previous public routes: 69
- Previous routes preserved: 69/69
- New routes: `/wiki/magic/`, `/wiki/relics-artifacts/`
- Current public routes: 71
- Redirects added: none; no route was renamed or removed.
- Protected anchors: 5/5 validated.

## Validation

- YAML parsing: passed (`navigation.yml`, `entities.yml`, `public-manifest.yml`)
- Sidebar exact-order assertion: passed
- Search JSON parsing and new-entry checks: passed (47 entries)
- JavaScript syntax: passed
- Public URL contract generation: passed (71 routes)
- Site validator: passed
- Internal links, anchors, assets, and navigation targets: passed; zero broken references detected
- Whitespace/error check (`git diff --check`): passed
- Spoiler-term scan of new navigation and landing pages: passed
- Jekyll production build: not available in the current environment because the `jekyll` executable is not installed in the bundle

## Author Review Required

- The public article route is titled **The Seven Demon Sigils**, while its geopolitical navigation label is **The Seven Sigils**. The distinction is retained intentionally, but the preferred public naming can be standardized later if desired.
- Relics & Artifacts is intentionally an empty public archive until approved entries exist.
- Bestiary remains explicitly unavailable until public content is approved.

No private Author Bible content or unrevealed mechanics were published.
