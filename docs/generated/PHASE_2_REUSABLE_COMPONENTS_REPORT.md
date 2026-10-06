# Phase 2 Reusable Layouts and Components Report

## Scope

This implementation adds reusable article presentation infrastructure around the existing public Wiki. It does not redesign the homepage, move or rename articles, rename approved assets, create Bestiary entries, create Alpha–Omega pages, alter permalink/baseurl behavior, replace deployment, or rewrite canon prose.

The supplied task text ends in the middle of the example gallery schema after `label: ...`. The implemented gallery follows the complete portion of that schema. Tabs and category/status chips were implemented because they are explicitly included in the stated Phase 2 goal; no additional lore or publication behavior was inferred.

## Components Added

- `_includes/article-header.html` — opt-in title, subtitle, summary, public classification chips, optional artwork, and optional generated breadcrumb placement.
- `_includes/article-chips.html` — public type/category chips with explicit flags required for canon-status and spoiler-level display.
- `_includes/breadcrumbs.html` — opt-in generated or overridden breadcrumbs using entity data and `relative_url`.
- `_includes/table-of-contents.html` and `_includes/toc-tree.html` — explicit, recursive, anchor-preserving TOC.
- `_includes/related-articles.html` — entity-resolved related cards that skip missing or unavailable destinations.
- `_includes/image-gallery.html` — front-matter-driven approved-image gallery using the existing lightbox behavior.
- `_includes/article-tabs.html` — optional accessible tabs with keyboard navigation and no third-party dependency.
- `_includes/typed-infobox.html` — schema dispatcher retaining the generic infobox base.
- Typed infobox wrappers for character, race, faction/nation, location, event, realm, evolution, creature, and Sigil domain.

## Layout Foundation

- `_layouts/article.html` is the shared opt-in component orchestrator.
- Existing semantic layouts now inherit from `article` while preserving their authored content.
- `_layouts/creature.html` provides future Bestiary presentation architecture without publishing a Bestiary page.
- `_layouts/sigil.html` provides future Sigil-domain presentation architecture without publishing Alpha–Omega pages.
- Character pages retain the current single-sheet gallery unless a future approved `gallery` array is explicitly supplied.

## Data Added

- `_data/article_types.yml` maps semantic content types to labels, parent navigation entities, and infobox schemas.
- `_data/infobox_schemas.yml` defines stable typed field order and labels.
- `_data/entities.yml` now includes existing public Raizen, Beta War, Ogre, and Oni destinations already referenced by current `related` metadata.

The creature and race schemas both support `sapient`. This allows Goblin to be represented as `content_type: race`, `sapient: Yes`, and not as a monster. Seven Sigils and Sigil-domain schemas remain Authority/geopolitical presentation, not biological classification.

## Transition Strategy

Generated article headers, breadcrumbs, TOCs, related cards, galleries, and tabs are opt-in. Existing manually authored presentation remains in place, preventing duplicate breadcrumbs, headings, related lists, or galleries during Phase 2.

The generic infobox is backward compatible with the existing `infobox.fields` mapping. New pages may use typed keys, but no existing article was bulk-migrated.

Detailed authoring examples are documented in `docs/REUSABLE_ARTICLE_COMPONENTS.md`.

## Public Metadata Safety

- `canon_status` is hidden unless `show_canon_status: true` is explicitly approved.
- `spoiler_level` is hidden unless `show_spoiler_level: true` is explicitly approved.
- Missing entity destinations are not linked.
- Unavailable entity identifiers do not generate pages.
- No metadata status was inferred or bulk-assigned.

## Validation

Passed:

- Ruby syntax for the validator.
- YAML parsing for all `_data` files.
- JavaScript syntax parsing through the system JavaScriptCore runtime.
- Static route, internal-link, anchor, asset, entity-destination, and navigation validation.
- TOC target and tab-ID validation support.
- `git diff --check`.
- Public URL count remains **66**.
- All **5** protected anchors remain present.
- No file below `wiki/` was modified.
- No article file moved.
- No Alpha–Omega or Bestiary article was created.

Unavailable locally:

- Jekyll/Liquid production rendering because the repository/runtime has no executable Jekyll installation or Liquid gem.

The JavaScript addition is dependency-free browser JavaScript and is isolated from the existing search, lightbox, and mobile-menu closure. Final rendered Liquid verification must occur in the existing GitHub Pages workflow or an approved Jekyll environment.

## URL and Content Integrity

- Public routes before Phase 2: **66**.
- Public routes after Phase 2: **66**.
- Protected anchor changes: **none**.
- Article prose changes: **none**.
- Approved asset renames: **none**.
- Permalink/baseurl changes: **none**.

## Risks Before Enabling Components on Existing Pages

- Check for existing manual breadcrumbs, H1 headings, related lists, and galleries before enabling their generated equivalents.
- Explicit TOC IDs must match existing Kramdown or HTML anchors exactly.
- Only approved public artwork may be supplied to header, gallery, or tab metadata.
- A rendered build must confirm Liquid compatibility and responsive behavior before commit.
- The incomplete tail of the supplied task should be reviewed in case it contained additional gallery or final-report requirements.

## Commit Status

No commit was created. Phase 0–1 changes are also still present in the working tree, and the required rendered Jekyll verification is not available locally.
