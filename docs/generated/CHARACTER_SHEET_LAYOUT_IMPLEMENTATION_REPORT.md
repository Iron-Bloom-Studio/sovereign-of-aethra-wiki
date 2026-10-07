# Character Sheet Layout Implementation Report

## Scope

This pass introduces an opt-in, reusable two-column character sheet for the public wiki. The supplied Fandom screenshot was used only as a structural reference: article content remains on the left, while a visual profile panel appears on the right. The implementation retains the existing SOVETHA parchment, navy, gold, and Aethra-blue visual language.

## Files Changed for This Pass

- `_layouts/default.html`
- `_layouts/character.html`
- `_includes/character-profile-panel.html` (new)
- `assets/wiki/character-gallery.css`
- `wiki/characters/luca.md`
- `wiki/characters/rolan.md`
- `wiki/characters/garling.md`
- `docs/generated/CHARACTER_SHEET_LAYOUT_IMPLEMENTATION_REPORT.md` (this report)

The working tree also contains changes from earlier approved wiki passes. They are not part of this layout report.

## Reusable Layout and Component

Character pages opt into the new presentation with:

```yaml
layout: character
character_sheet: true
```

`_layouts/character.html` provides the shared header and article/profile structure. `_includes/character-profile-panel.html` owns the artwork selector, artwork or missing-image fallback, captions, and public-safe metadata. The default layout suppresses the legacy third-column infobox only for opted-in character sheets, so non-migrated character routes keep their prior rendering.

## Frontmatter Schema

Base reader-safe facts continue to use the existing `infobox.fields` mapping. Public visual states use the following small extension:

```yaml
character_looks:
  - id: present
    label: Present
    image: /assets/characters/luca/SOA_LUCA_SIMPLE_MASTER_v02.png # optional
    alt: Meaningful public-safe alt text  # required when image is present
    caption: Public-safe caption          # optional
    fields:                               # optional state-specific overrides/details
      Role: Example role
```

Blank fields are not rendered. A look without an approved image receives a neutral “Artwork Not Yet Publicly Available” fallback. State-specific `fields` are optional and do not duplicate the whole character profile.

## Desktop, Tablet, and Mobile Behavior

- Desktop: the article and profile use an approximately 69/31 split. The profile panel is sticky with a restrained offset.
- Tablet: the navigation and character columns narrow, and the gap decreases.
- Narrow tablet/mobile: the inner character layout becomes one column in the requested order—title and summary, visual profile, then article. Sticky positioning is disabled.
- Full-body artwork uses `object-fit: contain`, a responsive width, and a bounded viewport height.

## Visual-State Selector

The selector uses semantic `button`, `tablist`, `tab`, and `tabpanel` roles and the wiki's existing lightweight vanilla-JavaScript tab controller. It changes the selected artwork, caption, and optional look-specific fields without a page reload. Arrow Left/Right, Home, and End keyboard navigation are supported. If JavaScript is unavailable, the first public-safe state remains visible.

No multi-look character was published in this pass because no second approved, reader-safe state was available for the three target pages. The reusable component supports multiple looks without exposing dormant or private states in HTML or frontmatter.

## Characters Migrated

### Luca

- Configured state: `Present`
- Artwork: `SOA_LUCA_SIMPLE_MASTER_v02.png`
- Public race remains exactly `Human`.
- No hidden biology, future form, Sovereign material, or other unrevealed classification is present.

### Rolan

- Configured state: `Guildmaster`
- Artwork: none; the missing-image fallback is shown.
- Public role: `Guildmaster of the Arklune Adventurers' Guild`.
- The existing Young artwork is deliberately not configured. Layout capability alone is not treated as publication approval.

### Garling

- Configured state: `Young`
- Artwork: `GARLING_YOUNG_PROLOGUE_MASTER_v1.0.png`
- No Present state was added because no approved Present artwork/state was confirmed for this pass.

## Accessibility

- Keyboard-operable tabs with roving `tabindex`
- `aria-selected`, `aria-controls`, and labelled tab panels
- Visible focus outlines using the existing Aethra accent
- Semantic headings and definition lists
- Meaningful image alternative text
- Missing-image fallback carries an accessible label
- Important state is not communicated by color alone

## Spoiler Safety

Only explicitly configured public looks are emitted into HTML. There are no hidden tabs, future-form data attributes, private JSON entries, or spoiler-bearing filenames for additional states. The implementation does not connect Rae to Rhaen, does not add Asteron-era details, and does not expose Luca's hidden identity or future mechanics.

## Route and Search Compatibility

The existing Luca, Rolan, and Garling routes were preserved. The character name remains each page's canonical title; visual states do not create routes or search entries. The generated public URL contract still contains 71 routes and five protected anchors.

## Validation Results

- Character frontmatter/schema assertions: passed
- Configured image existence and alt-text checks: passed
- Missing-image fallback case (Rolan): passed by source/schema validation
- Single-look cases: passed by source/schema validation
- Multi-look behavior: component and keyboard controller validated; no unapproved public example was added
- CSS brace validation: passed
- JavaScript syntax validation with JavaScriptCore: passed
- Keyboard-tab source checks: passed
- Search JSON parsing: passed
- Internal route, link, anchor, asset, and navigation validator: passed
- Scoped private-lore/spoiler scan: passed
- `git diff --check`: passed
- Jekyll production build: not available in this environment because the Jekyll executable is not installed (`bundler: command not found: jekyll`)

## Rendered-Page Notes

A local Jekyll render and browser screenshot could not be produced because Jekyll/Liquid is unavailable in the current environment. Responsive behavior was verified from the shared layout/CSS breakpoints and repository validators, not claimed as a completed browser visual regression test.

## Author Approval Required

- Approve and supply a Guildmaster-era Rolan image before replacing his placeholder.
- Explicitly approve Young Rolan as a public selector state before adding it, even though an asset exists in the repository.
- Approve Garling's Present state and artwork before adding a second selector tab.
- Approve every future Luca form individually before it enters public frontmatter, HTML, assets, or search-visible text.
- Any additional look label, image, caption, or state-specific metadata requires the same public-lore review.
