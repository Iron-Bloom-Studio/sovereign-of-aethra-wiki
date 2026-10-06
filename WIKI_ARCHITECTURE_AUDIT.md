# Sovereign of Aethra Wiki Architecture Audit

## Executive Summary

The public *Sovereign of Aethra* Wiki is a small, custom Jekyll site deployed through GitHub Pages. Its content foundation is healthy: article URLs are readable, the repository is compact, Markdown content is separate from shared layouts, the site already has reusable infobox and lightbox primitives, and the current deployment is passing.

The desired fandom-style direction does **not** require replacing Jekyll or moving existing articles. The safest recommendation is:

> **B. MODERATE REFACTOR** — preserve the existing Markdown content and URL paths, but rebuild navigation, taxonomy data, type-specific layouts, reusable article components, and the visual component layer.

The strongest reason not to choose a major rebuild is URL and content safety. The current Jekyll/Liquid architecture can support data-driven navigation, typed infoboxes, category portals, related cards, galleries, and article tabs without relocating articles. A framework migration would add routing and deployment risk without solving a content limitation.

The highest-risk areas are:

1. **Taxonomy drift:** Great Powers, Realms, Authority, and Factions overlap in hardcoded navigation and portal pages.
2. **Seven Sigils modeling:** the aggregate page exists, but the seven domains do not have individual public pages, and current metadata classifies the article as Authority/World Lore rather than as the single Great Power container requested for the future structure.
3. **Manual duplication:** navigation, category pages, search records, related links, breadcrumbs, and portal cards are maintained independently.
4. **Metadata enforcement:** public/spoiler defaults are permissive, fields are inconsistent, and the public manifest is not validated during build.
5. **Component thinness:** most named layouts are pass-through wrappers, while TOC, generic tabs, typed infoboxes, reusable galleries, and generated related cards do not yet exist.

Existing article URLs can very likely be preserved. Refactoring should treat every current public URL as a contract and change presentation around the existing files.

## Current Tech Stack

| Layer | Current implementation | Notes |
|---|---|---|
| Static site generator | Jekyll via GitHub Pages | Configured in `_config.yml`; Markdown engine is Kramdown. |
| Content format | Markdown with YAML front matter, Liquid, and inline HTML | Many portal/card sections are authored as inline HTML inside Markdown. |
| Theme | Custom | No packaged or remote Jekyll theme is declared. |
| CSS | Custom CSS | One global stylesheet plus character, realm, and faction supplements. No CSS framework. |
| JavaScript | Vanilla JavaScript | Search, mobile navigation toggle, and image lightbox live in one small script. |
| JavaScript framework | None | No React, Vue, Astro, Next.js, or client-side routing. |
| Build system | GitHub Pages Jekyll build action | No local bundler configuration is committed. |
| Package manager | None committed | No `Gemfile`, `Gemfile.lock`, `package.json`, or JS lockfile exists. |
| Search | Client-side custom JSON index | `assets/wiki/search.json` is manually maintained and fetched by `wiki.js`. |
| Deployment | GitHub Actions → GitHub Pages | Pushes to `main` trigger build and deployment. |
| Security scanning | GitHub CodeQL default setup | Recent CodeQL runs succeed, although no CodeQL workflow file is stored in this repository. |

Important configuration files:

- `_config.yml` — Jekyll title, production URL/base path, Kramdown, pretty permalinks, and global front-matter defaults.
- `.github/workflows/pages.yml` — GitHub Pages build and deployment.
- `public-manifest.yml` — public story phase, allowlisted entity groups, and asset identifiers.
- `_layouts/default.html` — global document shell.
- `_includes/nav.html` — sidebar navigation.
- `_includes/infobox.html` — generic infobox renderer.
- `assets/wiki/wiki.css` — global theme and responsive layout.
- `assets/wiki/wiki.js` — search, mobile menu, and lightbox behavior.

The README recommends `bundle install` and `bundle exec jekyll serve`, but there is no committed `Gemfile`. Local builds are therefore not reproducible from repository files alone; GitHub Actions currently supplies the working Jekyll environment.

## Repository Structure

Relevant structure, omitting Git internals and binary-file detail:

```text
.
├── .github/
│   └── workflows/
│       └── pages.yml
├── _config.yml
├── _includes/
│   ├── infobox.html
│   └── nav.html
├── _layouts/
│   ├── default.html
│   ├── character.html
│   ├── event.html
│   ├── evolution.html
│   ├── faction.html
│   ├── location.html
│   ├── race.html
│   └── realm.html
├── assets/
│   ├── characters/
│   ├── factions/
│   ├── locations/
│   ├── maps/
│   ├── world/
│   └── wiki/
│       ├── wiki.css
│       ├── character-gallery.css
│       ├── factions.css
│       ├── realm.css
│       ├── wiki.js
│       ├── search.json
│       └── favicon.svg
├── docs/
│   ├── editorial/
│   ├── PUBLICATION_TARGET.md
│   ├── WIKI_CONTENT_GUIDE.md
│   ├── WIKI_PAGE_TEMPLATES.md
│   └── WIKI_STYLE_GUIDE.md
├── search/
│   └── index.md
├── wiki/
│   ├── categories/
│   ├── characters/
│   ├── evolution/
│   ├── factions/
│   │   └── other/
│   ├── history/
│   ├── index/
│   ├── locations/
│   ├── novel/
│   ├── races/
│   ├── realms/
│   ├── systems/
│   └── world/
├── 404.html
├── index.md
└── public-manifest.yml
```

Current scale:

- 126 tracked files.
- 63 Markdown pages under `wiki/`.
- 39 asset files using approximately 59 MB.
- 8 layout files and 2 includes.
- 332 detected internal `relative_url` link references.
- No missing internal page target was found during the audit.
- No referenced production asset was missing. The only apparent missing asset reference is the deliberate example path in `docs/WIKI_PAGE_TEMPLATES.md`.

## Homepage

The homepage is generated by `index.md` using `_layouts/default.html`.

Current sections:

1. Wiki title and “The Encyclopedia of Terra” lede.
2. Public-lore introduction panel.
3. “Explore the Archive” portal grid.
4. Featured character, lore, location, and faction cards.
5. “Great Powers of Terra” compact link grid.
6. Links to Great Powers and Other Factions.
7. Approved Terra world map with lightbox support.

Implementation details:

- All homepage cards are hardcoded inline HTML in `index.md`.
- Styling uses global classes such as `.portal-grid`, `.portal-card`, `.feature-grid`, and `.text-card-grid` from `assets/wiki/wiki.css`.
- The page has no dedicated homepage layout, hero component, or data source.
- Featured content is manually selected and must be edited in the Markdown file.

The homepage can be redesigned without breaking article URLs. A future `home` layout or homepage includes could replace its presentation while leaving every linked article in place. The only URL at risk would be `/` itself, which need not change.

## Navigation

### Current implementation

- Header navigation is hardcoded in `_layouts/default.html`.
- Sidebar navigation is hardcoded in `_includes/nav.html`.
- Footer navigation is hardcoded separately in `_layouts/default.html`.
- Mobile behavior is handled by a single `Browse` button in `assets/wiki/wiki.js`, which opens or closes the entire sidebar.
- Subheadings such as “Human Kingdoms” are presentational `<span>` elements, not nested menu data.
- No `_data/navigation.yml`, recursive navigation include, active-state resolver, or dropdown component exists.

### Nested navigation capability

The current site does not support true nested dropdown menus. It can visually list grouped links, but hierarchy is encoded manually in HTML.

Implementing the requested hierarchy is technically straightforward in Jekyll:

```text
World
└── Great Powers
    ├── The Grand Concord
    ├── The Wardens of the Great Tree
    ├── The Dwarven Holds
    ├── The Hive
    ├── The Dragon Throne
    └── The Seven Sigils
```

The recommended approach is a data file such as `_data/navigation.yml` rendered by one recursive include. Header, sidebar, footer, and mobile navigation can then share the same source.

Difficulty: **moderate**, not because Liquid cannot render the hierarchy, but because the taxonomy must first be reconciled across the header, sidebar, homepage, Great Powers portal, Realms portal, category pages, search index, and public manifest.

Important current state:

- Free City of Arklune is already correctly placed in `wiki/factions/other/index.md`, not in the Great Powers list.
- The Seven Sigils appears as one card on the Great Powers portal, which matches the desired “one Great Power category” direction.
- Its article metadata currently says `category: Authority` and `categories: [Authority, World Lore]`, while `public-manifest.yml` lists `seven-sigils` under systems rather than factions. This is a future taxonomy decision, not a reason to split the seven Sigils into seven Great Powers.

## Article System

### Authoring model

Articles are Markdown files with YAML front matter. Authors also use inline HTML for cards, galleries, breadcrumbs, trees, and compact lists, plus Liquid `relative_url` filters for deployment-safe links.

### Layouts

- `default.html` is the real site shell and renders the header, sidebar, article body, optional infobox, footer, CSS, and JavaScript.
- `character.html` adds a single-artwork gallery and visual era controls after the article content.
- `event.html`, `evolution.html`, `faction.html`, `location.html`, `race.html`, and `realm.html` currently do little more than inherit `default` and output `content`.

This is a useful starting point, but most semantic layout names do not yet provide type-specific behavior.

### Front matter

Observed fields include:

- `layout`
- `title`
- `slug`
- `description`
- `public`
- `spoiler_level`
- `status`
- `category`
- `categories`
- `related`
- `infobox`
- `artwork`
- `artwork_era`
- `show_artwork_placeholder`
- a small number of character-specific fields such as `race` and `era`

Usage is inconsistent. For example, only 16 pages explicitly set `public`, 18 explicitly set `spoiler_level`, 12 use `status`, 18 use singular `category`, 28 use plural `categories`, and only 2 use `related` front matter.

### Table of contents

No automatic or reusable table of contents exists. Long pages depend entirely on browser scrolling and headings.

### Infoboxes

The generic `_includes/infobox.html` supports:

- title/name
- optional image and lightbox link
- neutral artwork placeholder
- arbitrary key/value fields rendered from `infobox.fields`

It does not currently provide typed schemas, sections, badges, automatic links, status chips, tabbed images, or field validation.

### Tabs

There is no generic tab system. Character pages display one active era button plus one disabled “Other eras” button. Those controls are presentational; no JavaScript switches tab panels.

### Images and galleries

- Generic lightbox support exists through `data-lightbox`.
- Character layout shows one approved sheet.
- Realm and faction pages manually embed establishing art and banners.
- `wiki/artwork.md` is a manually authored gallery.
- No reusable multi-image gallery include or front-matter-driven gallery renderer exists.

### Categories and tags

- Category front matter exists but is not consumed automatically by layouts.
- Category landing pages are static files in `wiki/categories/`.
- Only some articles manually render category links.
- There is no generated category index or tag archive.

### Related articles

- Only Garling and Raizen currently use `related` front matter.
- No layout reads `page.related`.
- Related lists are generally authored manually in article bodies.

## Existing Content Inventory

| Requested subject | Current state | Existing public path or location |
|---|---|---|
| Terra | Dedicated article exists | `/wiki/world/terra/` |
| Aethra | Dedicated article exists | `/wiki/world/aethra/` |
| Great Powers | Portal exists | `/wiki/factions/` |
| The Grand Concord | Dedicated article exists | `/wiki/factions/grand-concord/` |
| Wardens of the Great Tree | No separate article; represented by the Sylvaris article and Great Powers card | `/wiki/locations/sylvaris/` |
| Elves / Sylvaris | Elf race and Sylvaris realm articles exist | `/wiki/races/elf/`, `/wiki/locations/sylvaris/` |
| Dwarves | Dwarf race, Dwarven Holds, and Khazir pages exist | `/wiki/races/dwarf/`, `/wiki/factions/dwarven-holds/`, `/wiki/locations/khazir/` |
| The Hive | Civilization and Hiveborn race articles exist | `/wiki/factions/the-hive/`, `/wiki/races/hiveborn/` |
| The Dragon Throne | Dedicated Great Power and Dragonkind pages exist | `/wiki/factions/dragon-throne/`, `/wiki/races/dragonkind/` |
| The Seven Sigils | One aggregate article exists | `/wiki/factions/seven-sigils/` |
| Alpha | Mention/list entry only; no dedicated page | Seven Sigils aggregate article |
| Beta | Mention/list entry; Raizen and Beta War provide related public material, but no Beta domain article | Seven Sigils, Raizen, and Beta War articles |
| Gamma | Mention/list entry only; no dedicated page | Seven Sigils aggregate article |
| Delta | Mention/list entry only; no dedicated page | Seven Sigils aggregate article |
| Theta | Mention/list entry only; no dedicated page | Seven Sigils aggregate article |
| Sigma | Mention/list entry only; no dedicated page | Seven Sigils aggregate article |
| Omega | Mention/list entry only; no dedicated page | Seven Sigils aggregate article |
| Free City of Arklune | Canonical realm article, faction reference stub, and Other Factions card exist | `/wiki/locations/arklune/`, `/wiki/factions/arklune/`, `/wiki/factions/other/` |
| Grand Adventurer Guild | Section/anchor exists inside Arklune; no standalone article | `/wiki/locations/arklune/#the-grand-adventurer-guild` |
| Beta Remnant | No public page or indexed section found | Missing |
| Rogue Hive / Zavor | Section/anchor exists inside The Hive; no standalone article | `/wiki/factions/the-hive/#the-rogue-hive` |
| Monster Forest | Mentioned in content, but no dedicated location or bestiary article | Missing |
| Races | Landing page plus race/evolution articles exist | `/wiki/races/` |
| Characters | Landing page plus nine character articles exist | `/wiki/characters/` |
| Locations | Landing page plus nine dedicated location/realm entries exist | `/wiki/locations/` |
| History | Landing page and Beta War article exist | `/wiki/history/` |
| Lore | Lore Index and systems/world articles exist; no single `/wiki/lore/` portal | `/wiki/index/`, `/wiki/systems/`, `/wiki/world/` |
| Bestiary | No bestiary directory, landing page, creature layout, or creature article exists | Missing |

The desired Seven Sigils structure should therefore be treated as a future parent/child information architecture. The repository currently has only the parent aggregate article. Creating domain pages would require separately approved public content; architecture should not fabricate those pages.

## URL and Link Risks

### Current URL behavior

Jekyll uses `permalink: pretty`, so physical paths determine URLs unless an explicit `permalink` is added. For example:

- `wiki/factions/seven-sigils.md` → `/wiki/factions/seven-sigils/`
- `wiki/factions/other/index.md` → `/wiki/factions/other/`

Moving or renaming article files would therefore break URLs unless each moved page receives an explicit preserved permalink or a redirect strategy.

### Audit result

- 332 internal `relative_url` references were detected.
- No missing internal page target was found.
- Production asset references resolve successfully.
- Several important search/navigation destinations use heading anchors rather than standalone pages.

### Sensitive links and anchors

- `/wiki/locations/arklune/#the-grand-adventurer-guild`
- `/wiki/factions/the-hive/#the-rogue-hive`
- `/wiki/factions/the-hive/#zyrath-hive`
- `/wiki/characters/#founding-five`
- `/wiki/characters/#beta-war`

Changing those headings or generated IDs can break navigation and search even if the article file remains in place.

### Hardcoded references

Links are duplicated across:

- `_layouts/default.html`
- `_includes/nav.html`
- `index.md`
- portal/index pages
- category pages
- individual articles
- `assets/wiki/search.json`
- `public-manifest.yml`

### Asset path risk

Asset paths appear in both front matter and inline Liquid links. Moving an approved artwork file or changing its filename requires coordinated updates across articles, galleries, manifests, and possibly search metadata.

### Safe restructuring rule

Do not move current article files during the first refactor. Introduce data-driven presentation around the existing paths. If a later move is unavoidable, add explicit permalinks and validate every old URL before deployment.

## Visual System

### Color system

The global theme uses CSS custom properties:

- parchment `--paper: #f7f0df`
- deeper parchment `--paper-deep: #eadcc0`
- dark ink `--ink: #24211f`
- deep navy `--navy: #213650`
- antique gold `--gold: #9b742f`
- restrained Aethra blue `--aethra: #387c97`
- ivory `--white: #fffaf0`

This palette is coherent and appropriate for the SOA identity.

### Typography

- Georgia serif for body and article content.
- Arial sans-serif for navigation, breadcrumbs, small interface labels, and captions.
- No webfont dependency.

### Background and panels

- Parchment radial-gradient page background.
- Ivory cards and infoboxes.
- Thin antique-gold borders and restrained shadows.
- Navy infobox headers and gold section accents.

### Layout

Desktop uses a maximum-width three-column grid:

```text
192px navigation | article up to 780px | 270px infobox
```

The article width is readable but visually conservative. A cinematic homepage or portal can be added safely through a dedicated layout or full-width component while retaining a narrower reading measure for long articles.

### Responsive behavior

- At 1024px or below, the page becomes a two-column layout; the infobox moves below the article in the article column.
- At 700px or below, the page becomes single-column, the sidebar is hidden behind the Browse button, header search becomes full width, and major card grids collapse.
- At 400px or below, compact link grids and title sizes reduce further.

### Suitability for fandom-style presentation

The existing CSS can support the desired direction, but extending the current minified, mostly global stylesheet indefinitely would become difficult to maintain. A safer approach is:

1. preserve the existing tokens and visual identity;
2. split the theme into structured component files;
3. add dedicated styles for homepage hero, portal navigation, article header, TOC, typed infoboxes, tabs, galleries, and related cards;
4. load page-type styles deliberately rather than expanding one global rule line.

A completely new frontend framework is not necessary.

## Reusable Components

| Desired component | Current capability | Refactor potential |
|---|---|---|
| Character Infobox | Generic infobox plus character layout exists | High; add a character schema/include without moving pages. |
| Race Infobox | Generic infobox used by race pages | High; race layout is currently empty and can render standardized fields. |
| Creature / Bestiary Infobox | No creature layout or bestiary content | High architecturally, but content must wait for public approval. |
| Nation / Faction Infobox | Generic infobox is already used by major factions and realms | High; split identity, territory, government, ruler, affiliation, and status into a consistent schema. |
| Location Infobox | Generic infobox exists | High; location layout is currently available but nearly empty. |
| Seven Sigils Infobox | No specialized component | Moderate; generic fields work now, but a future component should distinguish Great Power container, domain, bearer, Authority, and public status. |
| Article tab navigation | Only a nonfunctional character-era visual control exists | Moderate; requires accessible tab markup and JavaScript. |
| Image gallery | Lightbox exists; galleries are manual | High; a front-matter-driven include can reuse the current lightbox. |
| Related article cards | Manual lists only; `related` metadata is not rendered | High; add a reusable include and stable entity lookup data. |
| Table of contents | None | High; generate from headings or an explicit front-matter list. |
| Breadcrumbs | Manually written in every article | High; derive from page type/taxonomy data while allowing overrides. |

Jekyll includes and data files are sufficient for all of these components.

## Canon Metadata

The repository partially supports canon/publication metadata:

- `public` exists.
- `spoiler_level` exists.
- `status` exists on some realm/world pages.
- `category` and `categories` both exist.
- `public-manifest.yml` provides a separate public allowlist and story phase.

`canon_status` does not currently exist as a standardized field. Adding it would be easy and need not alter visible content: layouts can ignore it initially while validation and editorial tooling use it.

Important weaknesses:

1. `_config.yml` defaults every page to `public: true` and `spoiler_level: 0` unless overridden.
2. The build does not enforce the public manifest.
3. `status`, `category`, and `categories` are inconsistently populated.
4. Metadata is not used to generate navigation, search, category membership, breadcrumbs, or related articles.
5. Editorial Markdown under `docs/` lives in the public repository and may be copied as a static build artifact even when it is not rendered as a normal article.

Recommended future metadata model:

```yaml
public: true
spoiler_level: 0
canon_status: LOCKED | PROVISIONAL
content_type: character | race | creature | faction | realm | location | event | lore
category: Great Powers
categories: [Great Powers, Authority]
related: [entity-slug, another-slug]
```

Introduce the fields gradually, keep them nonvisual at first, and add a build validator before allowing them to drive publication.

## Deployment

### Workflow

`.github/workflows/pages.yml` runs on:

- pushes to `main`
- manual `workflow_dispatch`

Build job:

1. checkout repository;
2. configure GitHub Pages;
3. run `actions/jekyll-build-pages@v1` with source `.` and destination `./_site`;
4. upload `_site` as the Pages artifact.

Deploy job:

- waits for build;
- deploys through `actions/deploy-pages@v4` to the `github-pages` environment.

### Current status

The latest audited commit (`58b5f5c`) has:

- GitHub Pages build/deploy: **success**
- CodeQL: **success**

Multiple preceding Pages and CodeQL runs also succeeded.

### Fragile assumptions

- Jekyll and dependency versions are not pinned by a `Gemfile`/lockfile.
- Local preview instructions assume Bundler inputs that are absent.
- No link checker, front-matter validator, manifest validator, search-index validator, or accessibility test runs in CI.
- `search.json` is manually maintained rather than generated from public pages.
- Production depends on the `/sovereign-of-aethra-wiki` base path; raw absolute links that bypass `relative_url` would be fragile.
- Root-source builds may copy non-page repository material unless explicitly excluded.

Navigation/layout refactoring will not inherently affect deployment. A framework migration, plugin-heavy solution, or moving the Jekyll source into a subdirectory would increase workflow risk and is not recommended for the first stages.

## Recommended Refactor Level

## B. MODERATE REFACTOR

Preserve:

- Jekyll and GitHub Pages.
- Existing article Markdown.
- Existing article and asset URLs.
- Canon-safe public text.
- Parchment, navy, gold, and Aethra-blue visual identity.
- Generic lightbox and infobox concepts.

Rebuild or extend:

- shared navigation data and nested rendering;
- taxonomy model for Explore, Great Powers, Other Factions, and Seven Sigils;
- semantic article layouts;
- typed infobox includes;
- TOC, tabs, galleries, related cards, and generated breadcrumbs;
- homepage presentation;
- structured CSS component layer;
- generated search/category indexes and validation.

Why not a light refactor: too many key systems are hardcoded or manual for a maintainable fandom-scale knowledge base.

Why not a major rebuild: the content model, readable routes, Jekyll hosting, and basic component boundaries are already usable. Replacing the frontend would add migration cost and URL risk without a clear functional necessity.

## Change Impact Map

| Area | Current File(s) | Change Needed | Risk | Preserve Existing Content? |
|---|---|---|---|---|
| Homepage | `index.md`, `_layouts/default.html`, `assets/wiki/wiki.css` | Introduce a homepage-specific layout/components and data-driven featured cards. | Medium | Yes; preserve all destination URLs and approved map. |
| Navigation | `_includes/nav.html`, `_layouts/default.html`, `assets/wiki/wiki.js` | Move menu structure to `_data`, add recursive hierarchy, active states, and accessible nested mobile behavior. | Medium–High | Yes. |
| Great Powers | `wiki/factions/index.md`, `index.md`, `wiki/realms/index.md`, nav, manifest, search index | Establish one authoritative list of six Great Power groups and generate cards/menus from it. | High | Yes; keep existing Great Power article URLs. |
| Seven Sigils | `wiki/factions/seven-sigils.md`, `wiki/systems/sigils.md`, Great Powers portal, manifest, search index | Model one Great Power container with seven domain children while preserving the distinction among Sigil, bearer, and political domain. Do not invent child content. | High | Yes; preserve `/wiki/factions/seven-sigils/`. |
| Other Factions | `wiki/factions/other/index.md`, `wiki/factions/arklune.md`, Arklune and Hive anchors | Centralize Arklune, Guild, Rogue Hive, and future approved entries. Preserve section-anchor URLs until standalone pages exist. | Medium | Yes. |
| Races | `wiki/races/`, `_layouts/race.html`, category pages | Standardize race metadata, infobox, evolution links, categories, and related cards. | Medium | Yes. |
| Bestiary | No current directory/layout | Add a future landing page, creature layout, metadata schema, and infobox only when approved creature content exists. | Medium | Not applicable; no existing bestiary content to migrate. |
| Article layout | `_layouts/default.html` and pass-through type layouts | Add article header, generated breadcrumb, optional TOC, categories, and related content. | High | Yes; render existing Markdown unchanged first. |
| Infoboxes | `_includes/infobox.html`, article front matter | Keep generic base but add typed includes/schemas and field validation. | Medium | Yes. |
| CSS/theme | `assets/wiki/wiki.css` and supplemental CSS files | Split into tokens/layout/components/page types; add cinematic portal styles while preserving reading layout. | Medium | Yes. |
| Search | `assets/wiki/search.json`, `assets/wiki/wiki.js` | Generate index from public metadata and validate URLs; keep client-side search behavior. | Medium | Yes. |
| Categories/related | `wiki/categories/`, front matter, manual article lists | Generate landing membership and related cards from standardized metadata. | Medium | Yes. |
| Canon metadata | `_config.yml`, `public-manifest.yml`, article front matter | Normalize fields and add validation; reconsider permissive global public defaults. | High | Yes; visible text can remain unchanged. |
| Deployment | `.github/workflows/pages.yml`, `_config.yml`, README | Pin build dependencies and add audit checks before deploy. | Low–Medium | Yes. |

## Proposed Migration Order

### Phase 0 — Establish URL and content contracts

- Export the current public URL list.
- Record anchor URLs used by search/navigation.
- Add automated internal-link and asset checks.
- Freeze article moves and approved asset renames.

### Phase 1 — Navigation and data model

- Define `_data/navigation.yml` and a single Great Powers taxonomy.
- Define one Seven Sigils parent with seven domain identifiers, without creating unapproved lore pages.
- Normalize Other Factions membership.
- Standardize nonvisual metadata fields.
- Render the existing visible menus from data without redesigning them yet.

### Phase 2 — Reusable layouts and components

- Expand semantic layouts while keeping existing body content untouched.
- Add generated breadcrumbs, optional TOC, category chips, related cards, and typed infobox wrappers.
- Add reusable gallery and accessible tab components.

### Phase 3 — Homepage

- Create a dedicated homepage layout.
- Rebuild Explore, featured content, Great Powers, and map presentation using shared data/components.
- Keep current article destinations unchanged.

### Phase 4 — Category landing pages

- Refactor Great Powers, Other Factions, Characters, Locations, History, Lore, and category portals.
- Align Seven Sigils placement across portal, navigation, manifest, metadata, and search.
- Preserve the aggregate Seven Sigils URL.

### Phase 5 — Bestiary and race templates

- Standardize Race pages first.
- Introduce Bestiary architecture only when public-approved creature entries exist.
- Keep “monster” terminology distinct from race taxonomy.

### Phase 6 — Visual polish

- Split and document CSS tokens/components.
- Add cinematic homepage and portal treatments.
- Refine responsive infobox, TOC, navigation, gallery, and tab behavior.
- Optimize large images without renaming or replacing approved originals prematurely.

### Phase 7 — Validation and deployment hardening

- Pin Jekyll dependencies.
- Generate and validate search data.
- Validate front matter against the public manifest.
- Test old URLs, anchors, mobile layout, keyboard navigation, accessibility, and GitHub Pages build.
- Deploy in small reversible batches.

## Risks

1. **Taxonomy/canon collision:** a UI refactor must not turn Ancient Authorities into biological classes or turn seven domains into seven separate Great Powers.
2. **Premature child pages:** Alpha–Omega pages must not be generated merely to fill the hierarchy when public lore is absent.
3. **URL breakage:** moving Markdown files changes pretty URLs unless explicit permalinks or redirects are introduced.
4. **Anchor breakage:** Guild and Rogue Hive destinations currently depend on headings inside larger articles.
5. **Metadata leakage:** permissive defaults and unenforced manifests can publish a new page at spoiler level 0 unintentionally.
6. **Search drift:** manual JSON can become inconsistent with article titles, descriptions, categories, or paths.
7. **Duplicate navigation drift:** header, sidebar, footer, homepage, portal pages, categories, and search currently encode overlapping lists.
8. **CSS regression:** the global stylesheet affects every page, so broad changes can damage mobile layout or infobox placement.
9. **Unpinned build:** GitHub's Jekyll action currently works, but local and future builds are not fully reproducible.
10. **Public docs exposure:** editorial files are stored in the public repository and may be available as raw/static artifacts even when not linked as reader pages.
11. **Large media cost:** the asset directory is approximately 59 MB and contains several 2–3.5 MB images; a more image-heavy homepage could worsen initial load time.

## Files That Should NOT Be Touched Yet

Until navigation data, URL contracts, and validation are established, avoid changing:

- Existing article paths under `wiki/`.
- Approved novel files under `wiki/novel/`.
- Approved artwork binaries and filenames under `assets/`.
- Canon prose inside Terra, Aethra, realm, race, character, and Seven Sigils articles.
- Headings used as public anchors, especially Grand Adventurer Guild and Rogue Hive.
- `wiki/factions/seven-sigils.md` content merely to create seven visually symmetrical entries.
- Individual Alpha–Omega lore or pages without separate public approval.
- `_config.yml` permalink/base URL behavior.
- `.github/workflows/pages.yml` until a replacement build is proven in parallel.
- `public-manifest.yml` allowlist semantics until a validator and migration map are agreed.

The first refactor should add shared data and rendering infrastructure around the existing content, not rewrite or relocate the content itself.
