# Wiki Content Guide

This is a public, spoiler-safe encyclopedia. The private Master Canon remains authoritative.

## URL Contract

**Existing public URLs are contracts.** Do not move or rename an existing public article, change a protected heading anchor, or rename an approved asset without an explicit migration and compatibility plan.

The generated contract is maintained in `docs/generated/PUBLIC_URL_CONTRACT.md`. Run `ruby scripts/validate_site.rb` before committing navigation or content-structure changes.

- Publish only entries explicitly allowed by `public-manifest.yml` and the private publication manifest.
- Never publish private editorial material, future plots, prompts, paths, or unreleased artwork.
- Use approved canonical artwork only. If none is suitable, use the built-in neutral placeholder.
- Link only to public pages that exist. Add related articles deliberately through front matter.
- Use title-case names, lowercase hyphenated slugs, and approved asset filenames.
- Add a static category page when a new category is introduced; do not imply that an unpublished subject exists.
