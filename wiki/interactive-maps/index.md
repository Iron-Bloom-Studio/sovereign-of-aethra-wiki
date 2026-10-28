---
layout: interactive-map
title: Interactive Maps
description: Explore the approved public map of Terra through searchable, filterable, spoiler-safe location markers.
permalink: /interactive-maps/
category: World
public: true
spoiler_level: 0
---
<p class="breadcrumb">Home › Interactive Maps</p>
# Interactive Maps

<p class="interactive-map-intro">Explore the approved public map of Terra. Search for a location, filter markers by classification, or select a marker to open its public wiki record.</p>

<section class="interactive-map-shell" data-interactive-map data-base-url="{{ site.baseurl }}" data-data-url="{{ '/assets/interactive-maps/terra-locations.json' | relative_url }}" aria-label="Interactive map of Terra">
  <form class="interactive-map-toolbar" data-map-search-form>
    <label class="interactive-map-field">
      <span>Find a location</span>
      <input type="search" data-map-search list="terra-map-options" placeholder="Aven, Arklune, Zyrath Hive…" autocomplete="off">
      <datalist id="terra-map-options" data-map-search-options></datalist>
    </label>
    <label class="interactive-map-field">
      <span>Marker category</span>
      <select data-map-category>
        <option value="all">All public locations</option>
        <option value="capital">Capital cities</option>
        <option value="city">Major cities</option>
        <option value="settlement">Settlements</option>
        <option value="realm">Realm seats</option>
        <option value="region">Regions</option>
        <option value="landmark">Landmarks</option>
        <option value="domain">Domains</option>
      </select>
    </label>
    <button class="interactive-map-button" type="button" data-map-reset>Reset Map</button>
    <button class="interactive-map-button" type="button" data-map-fullscreen>Fullscreen</button>
  </form>
  <div class="interactive-map-workspace">
    <div id="terra-interactive-map" class="interactive-map-canvas" data-map-canvas tabindex="0" aria-label="Terra map canvas. Use arrow keys to pan and plus or minus to zoom."></div>
    <aside class="interactive-map-panel" data-map-panel aria-live="polite">
      <p class="interactive-map-panel__eyebrow" data-map-panel-eyebrow>Interactive Gazetteer</p>
      <h2 data-map-panel-title>Select a location</h2>
      <p class="interactive-map-panel__region" data-map-panel-region>Choose a marker or search the map.</p>
      <p class="interactive-map-panel__description" data-map-panel-description>Only public, spoiler-safe locations are included in this map.</p>
      <a class="interactive-map-panel__link" data-map-panel-link hidden>Open Wiki Article</a>
      <div class="interactive-map-legend" aria-label="Map marker legend">
        <span><i class="interactive-map-swatch interactive-map-swatch--capital"></i>Capital City</span>
        <span><i class="interactive-map-swatch interactive-map-swatch--city"></i>Major City</span>
        <span><i class="interactive-map-swatch interactive-map-swatch--settlement"></i>Settlement</span>
        <span><i class="interactive-map-swatch interactive-map-swatch--realm"></i>Realm Seat</span>
        <span><i class="interactive-map-swatch interactive-map-swatch--region"></i>Region</span>
        <span><i class="interactive-map-swatch interactive-map-swatch--landmark"></i>Landmark</span>
        <span><i class="interactive-map-swatch interactive-map-swatch--domain"></i>Domain</span>
      </div>
    </aside>
  </div>
  <p class="interactive-map-status" data-map-status aria-live="polite">Loading public map locations…</p>
</section>

<p class="interactive-map-note"><strong>Public map notice:</strong> this map follows the wiki's current spoiler level. Unrevealed locations, identities, and internal production notes are intentionally excluded.</p>

## Related Articles

- [Terra]({{ '/wiki/world/terra/' | relative_url }})
- [Realms & Civilizations]({{ '/wiki/realms/' | relative_url }})
- [Locations]({{ '/wiki/locations/' | relative_url }})
