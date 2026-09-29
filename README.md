# Sovereign of Aethra Wiki

Official public encyclopedia for the *Sovereign of Aethra* universe.

Website: <https://iron-bloom-studio.github.io/sovereign-of-aethra-wiki/>

This is the public presentation repository. Canon is maintained separately in the private Master Canon repository; only explicitly approved, spoiler-safe lore and artwork are published here.

## Local preview

GitHub Pages builds this site with Jekyll. To preview locally:

```sh
bundle install
bundle exec jekyll serve --baseurl ""
```

Open <http://localhost:4000/>. The production site runs under `/sovereign-of-aethra-wiki/`; test that base path before publishing changes.

## Publishing workflow

Private Master Canon → approve public lore → update this repository → preview → commit → GitHub Pages deploy → live SOA Wiki.

The public Wiki never becomes the canonical source of truth.
