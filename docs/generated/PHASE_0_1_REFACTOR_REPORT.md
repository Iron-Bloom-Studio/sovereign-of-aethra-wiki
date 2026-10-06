# Phase 0–1 Architecture Refactor Report

## Scope

This change implements only the approved URL/content-contract foundation and data-driven navigation foundation. It does not redesign the homepage, move articles, rename assets, create Sigil child pages, change `baseurl`/permalink behavior, replace deployment, or rewrite public lore.

`WIKI_ARCHITECTURE_AUDIT.md` was used as the architectural baseline. It was already present as an uncommitted audit artifact before this implementation.

## Files Created

- `_data/entities.yml` — central public entity, classification, availability, and destination registry.
- `_data/navigation.yml` — header, sidebar, and footer navigation structure.
- `_includes/navigation-tree.html` — recursive Liquid renderer for linked, external, active, nested, and unavailable items.
- `docs/PUBLIC_METADATA_SCHEMA.md` — future-facing public metadata rules without bulk frontmatter migration.
- `docs/generated/PUBLIC_URL_CONTRACT.md` — generated inventory of the 66 current public routes and protected anchors.
- `docs/generated/PHASE_0_1_REFACTOR_REPORT.md` — this implementation report.
- `scripts/generate_url_contract.rb` — dependency-light URL contract generator.
- `scripts/validate_site.rb` — dependency-light route, anchor, asset, and navigation validator.

## Files Modified

- `404.html` — corrected the existing broken Wiki-home destination from the nonexistent `/wiki/` route to `/`.
- `_includes/nav.html` — replaced duplicated sidebar markup with the central navigation data and reusable renderer.
- `_layouts/default.html` — made header and footer navigation consume the same data-driven renderer.
- `assets/wiki/wiki.css` — added minimal structural styling for semantic navigation lists, active state, nested items, and unavailable items while retaining the existing visual language.
- `docs/WIKI_CONTENT_GUIDE.md` — documented the rule: **Existing public URLs are contracts.**

No Markdown article below `wiki/` was modified.

## Navigation Data Structure

`_data/entities.yml` owns stable labels, current approved URLs, structural classification, availability, and parent/child identifiers. `_data/navigation.yml` owns presentation order and grouping for header, sidebar, and footer. The renderer resolves navigation items through the entity registry, applies `relative_url` to internal destinations, preserves external-link safety attributes, marks the current page with `aria-current`, and renders unavailable entries without fabricating pages.

The include accepts child item arrays recursively even though the current sidebar keeps the approved top-level group presentation.

## Taxonomy Decisions Implemented

- Great Powers contains The Grand Concord, The Wardens of the Great Tree, The Dwarven Holds, The Hive, The Dragon Throne, and The Seven Sigils. No numeric label is imposed.
- The Seven Sigils is one Great Power grouping with child identifiers Alpha, Beta, Gamma, Delta, Theta, Sigma, and Omega.
- Alpha–Omega are unavailable identifiers, not generated lore pages.
- The Seven Sigils remains at `/wiki/factions/seven-sigils/` and is classified as an Authority/geopolitical framework rather than a race.
- Free City of Arklune remains under Other Factions and retains its approved city-state classification.
- Grand Adventurer Guild continues to use `/wiki/locations/arklune/#the-grand-adventurer-guild`.
- Rogue Hive / Zavor continues to use `/wiki/factions/the-hive/#the-rogue-hive`.
- Beta Remnant and Bestiary are represented as unavailable and do not receive invented public pages.
- Race, monster, domain, and Authority classifications remain separate.

## URL Validation Result

Passed with `ruby scripts/validate_site.rb`.

- Public URLs before: **66**
- Public URLs after: **66**
- Missing internal page links: **0**
- Missing validated anchors: **0**
- Missing local assets: **0**
- Duplicate navigation targets within a navigation surface: **0**
- Invalid navigation destinations: **0**

The pre-existing `/wiki/` link in `404.html` did not correspond to a public route and was corrected to the existing `/` homepage. No route itself was added, removed, or changed.

## Protected Anchor Validation

All five required contract destinations passed:

- `/wiki/locations/arklune/#the-grand-adventurer-guild`
- `/wiki/factions/the-hive/#the-rogue-hive`
- `/wiki/factions/the-hive/#zyrath-hive`
- `/wiki/characters/#founding-five`
- `/wiki/characters/#beta-war`

## Build Result

The local production build was attempted with:

```sh
bundle exec jekyll build --destination /private/tmp/soa-phase01-site
```

It could not start because the current checkout/runtime has no executable Jekyll installation (`bundler: command not found: jekyll`). No Gemfile or dependency workflow was added because dependency/deployment changes are outside this phase. Ruby syntax checks, YAML parsing, `git diff --check`, and the repository-local static validator all passed.

The changes are therefore structurally validated but still require the existing GitHub Pages workflow (or an approved local Jekyll environment) to perform the final rendered-site build before commit.

## Unresolved Items

- Beta Remnant has no approved public destination.
- Bestiary has no approved public landing page.
- Alpha–Omega have no approved standalone public pages.
- Final rendered HTML cannot be inspected locally until Jekyll is available or CI runs against the change.
- Existing article frontmatter has not been bulk-migrated to the new metadata schema; statuses remain unset unless already approved.

## Risks Before Phase 2

- Phase 2 must preserve all routes and anchors in `PUBLIC_URL_CONTRACT.md`.
- A rendered build should verify Liquid recursion and responsive layout before any visual redesign.
- Future taxonomy work must not turn unavailable identifiers into public lore automatically.
- Adding a Bestiary or Beta Remnant destination requires approved content, not a symmetry placeholder.
- Any future article move or heading rename needs an explicit redirect/compatibility plan.

## Diff Summary

- Public article prose changes: **none**.
- Article file moves: **none**.
- Asset renames: **none**.
- New public lore pages: **none**.
- URL count change: **0**.
- One broken link target corrected in `404.html`.
- Navigation markup centralized across sidebar, header, and footer.
- Validation and generated architecture documentation added.

## Validation Commands

```sh
ruby -c scripts/validate_site.rb
ruby -c scripts/generate_url_contract.rb
ruby scripts/generate_url_contract.rb
ruby scripts/validate_site.rb
ruby -e 'require "yaml"; YAML.safe_load(File.read("_data/entities.yml"), aliases: true); YAML.safe_load(File.read("_data/navigation.yml"), aliases: true)'
git diff --check
```
