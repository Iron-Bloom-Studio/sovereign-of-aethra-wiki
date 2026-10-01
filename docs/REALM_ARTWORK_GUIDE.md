# Realm Artwork Integration

Realm pages use the existing public asset conventions rather than binary placeholders.

- Human kingdoms, free cities, and territorial realms: `assets/locations/<slug>/`
- Political civilizations and Great Powers: `assets/factions/<slug>/`
- Establishing artwork: add its public path to `artwork.establishing` and `infobox.image`.
- Seat-of-power artwork: add its public path to `artwork.seat_of_power` when approved.

Expected future slots are one realm/capital establishing image and one seat-of-power image. Cultural, military, and notable-location artwork can be added later after explicit public approval. Pages with no approved artwork set `show_artwork_placeholder: false`, so the public article remains clean and no fake image is rendered.
