# Reusable Article Components

Phase 2 provides opt-in article presentation components without moving content or changing public URLs. Existing manually authored headings, breadcrumbs, related lists, and galleries remain valid during the transition.

## Semantic Layouts

Existing `character`, `race`, `faction`, `location`, `event`, `realm`, and `evolution` layouts now inherit from the shared `article` layout. Future approved content may also use:

- `layout: creature` for Bestiary presentation architecture. This does not publish a Bestiary page by itself.
- `layout: sigil` for a future approved Sigil-domain presentation. This does not create Alpha–Omega pages.

The article layout renders only components explicitly enabled by front matter. It does not automatically replace the article's authored heading or breadcrumb.

## Article Header

Enable the generated header only after removing or intentionally retaining any authored duplicate heading:

```yaml
article_header: true
title: Example
subtitle: Optional subtitle
description: Public short summary.
content_type: location
header_image: /assets/approved/example.png
header_image_alt: Approved view of Example
header_image_caption: Optional public caption
```

`canon_status` and `spoiler_level` remain hidden unless their respective `show_canon_status` or `show_spoiler_level` flags are explicitly enabled. Internal editorial metadata is therefore not exposed by default.

## Generated Breadcrumbs

Default type-driven breadcrumbs are opt-in:

```yaml
generated_breadcrumbs: true
```

Override the parent entity when needed:

```yaml
generated_breadcrumbs: true
breadcrumb_parent: seven-sigils
```

Or provide an explicit trail:

```yaml
breadcrumbs:
  - entity: world
  - entity: locations
  - label: Custom Parent
    url: /wiki/existing-approved-parent/
```

The current page title is appended automatically. Do not enable generated breadcrumbs on a page that retains a manual breadcrumb unless the duplication is intentional.

## Table of Contents

TOCs are explicit and opt-in so Kramdown heading IDs remain untouched:

```yaml
toc:
  - id: overview
    title: Overview
  - id: society
    title: Society
    children:
      - id: traditions
        title: Traditions
```

Every `id` must already exist as a heading or explicit HTML ID on the same page. `scripts/validate_site.rb` verifies these references.

## Typed Infoboxes

The generic `infobox.html` renderer remains the base. Layout-driven wrappers use schemas in `_data/infobox_schemas.yml` for character, race, faction/nation, location, event, realm, evolution, creature, and Sigil-domain entries.

Existing `infobox.fields` mappings remain fully supported and retain their authored order. New pages may use typed keys directly:

```yaml
layout: race
content_type: race
infobox:
  name: Goblin
  classification: Race
  sapient: Yes
```

This represents Goblin as a sapient race, not a monster. Creature entries also support `sapient`, keeping biological identity separate from social or Bestiary classification.

## Related Articles

Related cards read `page.related`, resolve identifiers through `_data/entities.yml`, and skip unavailable or unresolved destinations instead of producing broken links.

```yaml
show_related: true
related:
  - seven-sigils
  - entity: history
  - title: Approved custom destination
    url: /wiki/existing-approved-page/
    description: Optional public summary.
```

Do not enable generated related cards where the article already contains a manual related list unless duplication has been reviewed.

## Image Gallery

The gallery uses the existing lightbox behavior:

```yaml
gallery:
  - image: /assets/approved/example.png
    alt: Accessible description of the approved artwork
    caption: Public caption
    label: Present era
```

Only approved local assets may be referenced. A character page with `gallery` uses this gallery instead of the legacy single-sheet gallery.

## Character Visual Assets

Named-character pages distinguish public portraits from internal production sheets:

```yaml
character_looks:
  - id: present
    label: Present
    portrait: /assets/characters/name/wiki/name-present-portrait.png
    portrait_alt: Public-safe portrait description
```

The profile panel prefers `portrait`, retains legacy `image` compatibility, and may use `reference_sheet` only as a temporary fallback when that exact sheet was already approved for public display. Internal Character Sheets are visual source material and must not be copied into the wiki merely because they exist in the private repository. An explicitly public-safe sheet may appear below the article only with `publish_reference_sheet: true`; this flag is opt-in and fail-closed. A Wiki Portrait must preserve the approved sheet's face, hairstyle, proportions, race traits, costume, palette, and signature equipment while revealing only the character's current public identity.

## Tabs

Tabs are front-matter-driven, keyboard accessible, and require no third-party dependency:

```yaml
tabs:
  - id: present
    label: Present
    image: /assets/approved/present.png
    alt: Present appearance
  - id: past
    label: Past
    content: Publicly approved past-era summary.
```

Tab IDs must be unique per page. Disabled tabs may be represented with `disabled: true`, but they must not expose unreleased content.

## Category and Status Chips

The article header can render public type/category chips. Canon and spoiler metadata are hidden by default:

```yaml
show_canon_status: true
show_spoiler_level: true
```

Use these flags only when the labels are intentionally reader-facing.

## Transition Rules

1. Preserve all URLs and protected heading IDs in `docs/generated/PUBLIC_URL_CONTRACT.md`.
2. Enable components page by page after checking for duplicate manual presentation.
3. Do not infer or bulk-assign canon status, taxonomy, relationships, or spoiler values.
4. Do not create a public destination merely because a component or schema supports it.
5. Run `ruby scripts/validate_site.rb` before committing.
