# Character Visual Panel Refinement Report

## Files Changed

- `_includes/character-profile-panel.html`
- `_includes/character-reference-gallery.html`
- `_layouts/character.html`
- `assets/wiki/character-gallery.css`
- `wiki/characters/luca.md`
- `wiki/characters/rolan.md`
- `wiki/characters/garling.md`
- `wiki/characters/serena.md`
- `docs/generated/CHARACTER_VISUAL_PANEL_REFINEMENT_REPORT.md` (this report)

## Schema Changes

Each `character_looks` entry may now define:

- `portrait`: primary profile-panel artwork.
- `portrait_alt` and `portrait_caption`: optional portrait-specific accessibility text and caption.
- `reference_sheet`: migration-only fallback for a sheet that was already explicitly public-safe.
- `reference_sheet_alt` and `reference_sheet_caption`: reference-specific accessibility text and caption.
- `publish_reference_sheet`: explicit public opt-in for the below-article Character Reference section.
- `image`: preserved as a legacy profile-image fallback.

The panel resolves artwork in this order: `portrait`, legacy `image`, then `reference_sheet`. This preserves existing compatibility while allowing a dedicated portrait to replace a dense production sheet without duplicating character metadata. Character Sheets appear below an article only through the explicit `publish_reference_sheet: true` flag.

## Luca

`SOA_LUCA_WIKI_PORTRAIT_v01.png` is now the dedicated primary portrait. `SOA_LUCA_SIMPLE_MASTER_v02.png` remains an explicitly public-safe Character Sheet and is displayed below the article under Character Reference through the opt-in `publish_reference_sheet: true` flag.

## Rolan

The Guildmaster state has no approved portrait. Its former tall empty artwork area is replaced by a compact “Portrait not yet published.” notice, immediately followed by reader-safe metadata. The existing Young production sheet remains unreferenced and is not published on Rolan's current page.

## Garling

`GARLING_YOUNG_PROLOGUE_MASTER_v1.0.png` is now explicitly classified as a previously public-safe Young reference sheet. No separate approved Young portrait was found, so it remains the temporary profile fallback. It is not automatically added as separate gallery content.

## Serena

`SOA_SERENA_WIKI_PORTRAIT_v01.png` is the dedicated primary portrait. `SOA_SERENA_SIMPLE_MASTER_v02.png` remains an explicitly public-safe Character Sheet and is displayed below the article under Character Reference through the opt-in publication flag.

## Portrait and Reference Assets Found

- Luca: one dedicated Wiki Portrait and one approved public-safe Character Sheet.
- Serena: one dedicated Wiki Portrait and one approved public-safe Character Sheet.
- Garling: one approved Young reference sheet; no dedicated portrait.
- Rolan: one Young reference sheet exists in the repository, but it is not used because the current public-safe panel state is Guildmaster; no approved Guildmaster portrait exists.

No source artwork was destructively cropped or altered.

## Assets Still Needed

- Garling Young portrait or clean full-body/three-quarter artwork.
- Rolan Guildmaster portrait.

Each asset requires explicit public approval before being added to character frontmatter.

## Layout Behavior

The approved 69/31 desktop split, sticky profile panel, accessible look selector, and mobile single-column order are unchanged. Reference fallback imagery has a restrained maximum height so metadata appears earlier, while `object-fit: contain` preserves the entire artwork.

## Validation Results

- Existing character routes: unchanged.
- Public-safe asset references: validated.
- Missing portrait compact state: validated for Rolan.
- Portrait/reference fallback order: validated by source assertions.
- Alt text: present for every configured reference sheet.
- Character tabs and keyboard behavior: unchanged.
- Mobile breakpoint and non-sticky behavior: unchanged.
- Search behavior: unchanged.
- Internal links, anchors, assets, and navigation: validated with repository tooling.
- Private/future art and forms: not added.
- `git diff --check`: passed.
- Jekyll production build: to be validated by GitHub Pages after push; local Jekyll is unavailable in this environment.
