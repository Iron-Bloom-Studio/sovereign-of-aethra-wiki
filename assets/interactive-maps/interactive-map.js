(() => {
  const root = document.querySelector('[data-interactive-map]');
  if (!root) return;

  const canvas = root.querySelector('[data-map-canvas]');
  const form = root.querySelector('[data-map-search-form]');
  const searchInput = root.querySelector('[data-map-search]');
  const searchOptions = root.querySelector('[data-map-search-options]');
  const categorySelect = root.querySelector('[data-map-category]');
  const resetButton = root.querySelector('[data-map-reset]');
  const fullscreenButton = root.querySelector('[data-map-fullscreen]');
  const panel = root.querySelector('[data-map-panel]');
  const panelEyebrow = panel.querySelector('[data-map-panel-eyebrow]');
  const panelTitle = panel.querySelector('[data-map-panel-title]');
  const panelRegion = panel.querySelector('[data-map-panel-region]');
  const panelDescription = panel.querySelector('[data-map-panel-description]');
  const panelLink = panel.querySelector('[data-map-panel-link]');
  const status = root.querySelector('[data-map-status]');
  const dataUrl = root.dataset.dataUrl;
  const baseUrl = root.dataset.baseUrl || '';

  const categoryLabels = {
    capital: 'Capital City',
    city: 'Major City',
    settlement: 'Settlement',
    realm: 'Realm Seat',
    region: 'Region',
    landmark: 'Landmark',
    domain: 'Domain'
  };

  const setStatus = message => {
    status.textContent = message;
  };

  const setPanelEmpty = () => {
    panelEyebrow.textContent = 'Interactive Gazetteer';
    panelTitle.textContent = 'Select a location';
    panelRegion.textContent = 'Choose a marker or search the map.';
    panelDescription.textContent = 'Only public, spoiler-safe locations are included in this map.';
    panelLink.hidden = true;
    panelLink.removeAttribute('href');
  };

  if (typeof window.L === 'undefined') {
    canvas.innerHTML = '<p class="interactive-map-note">The interactive map library could not be loaded. The standard Terra map remains available on the Terra article.</p>';
    setStatus('Interactive map unavailable.');
    return;
  }

  setPanelEmpty();

  fetch(dataUrl, { cache: 'no-store' })
    .then(response => {
      if (!response.ok) throw new Error('Map data unavailable');
      return response.json();
    })
    .then(data => {
      const width = data.map.width;
      const height = data.map.height;
      const bounds = window.L.latLngBounds([0, 0], [height, width]);
      const map = window.L.map(canvas, {
        crs: window.L.CRS.Simple,
        minZoom: -1.5,
        maxZoom: 2.5,
        zoomSnap: 0.25,
        zoomDelta: 0.5,
        wheelPxPerZoomLevel: 90,
        maxBounds: bounds.pad(0.22),
        maxBoundsViscosity: 0.82,
        attributionControl: false
      });

      window.L.imageOverlay(baseUrl + data.map.image, bounds, {
        alt: 'Approved public map of Terra and the Great Continent',
        interactive: false
      }).addTo(map);

      const markerLayer = window.L.layerGroup().addTo(map);
      const records = [];
      let selectedRecord = null;

      const mapPoint = location => window.L.latLng(height - location.y, location.x);

      const clearActiveMarker = () => {
        if (!selectedRecord) return;
        const element = selectedRecord.marker.getElement();
        if (element) {
          const dot = element.querySelector('.interactive-map-marker');
          if (dot) dot.classList.remove('is-active');
        }
        selectedRecord = null;
      };

      const selectRecord = (record, shouldMove = false) => {
        clearActiveMarker();
        selectedRecord = record;

        if (!markerLayer.hasLayer(record.marker)) {
          categorySelect.value = 'all';
          applyFilter();
        }

        if (shouldMove) map.flyTo(record.point, Math.max(map.getZoom(), 0.35), { duration: 0.75 });

        window.requestAnimationFrame(() => {
          const element = record.marker.getElement();
          if (element) {
            const dot = element.querySelector('.interactive-map-marker');
            if (dot) dot.classList.add('is-active');
          }
        });

        panelEyebrow.textContent = categoryLabels[record.location.category] || 'Location';
        panelTitle.textContent = record.location.name;
        panelRegion.textContent = record.location.region;
        panelDescription.textContent = record.location.description;
        panelLink.href = baseUrl + record.location.href;
        panelLink.hidden = false;
        setStatus(`${record.location.name} selected. ${records.length} public locations are available.`);
      };

      const popupFor = location => {
        const wrapper = document.createElement('div');
        const title = document.createElement('strong');
        const region = document.createElement('span');
        title.textContent = location.name;
        region.textContent = location.region;
        region.style.display = 'block';
        region.style.color = '#6a6259';
        region.style.marginTop = '.2rem';
        wrapper.append(title, region);
        return wrapper;
      };

      data.locations.forEach(location => {
        const point = mapPoint(location);
        const icon = window.L.divIcon({
          className: 'interactive-map-marker-wrap',
          html: `<span class="interactive-map-marker interactive-map-marker--${location.category}"></span>`,
          iconSize: [15, 15],
          iconAnchor: [7.5, 7.5]
        });
        const marker = window.L.marker(point, {
          icon,
          title: location.name,
          keyboard: true,
          riseOnHover: true
        });
        const record = { location, point, marker };
        marker.bindTooltip(location.name, { direction: 'top', offset: [0, -8] });
        marker.bindPopup(popupFor(location), { closeButton: false, offset: [0, -4] });
        marker.on('click', () => selectRecord(record));
        marker.addTo(markerLayer);
        records.push(record);

        const option = document.createElement('option');
        option.value = location.name;
        option.label = location.region;
        searchOptions.append(option);
      });

      const applyFilter = () => {
        const category = categorySelect.value;
        let visible = 0;
        records.forEach(record => {
          const shouldShow = category === 'all' || record.location.category === category;
          const isVisible = markerLayer.hasLayer(record.marker);
          if (shouldShow && !isVisible) markerLayer.addLayer(record.marker);
          if (!shouldShow && isVisible) markerLayer.removeLayer(record.marker);
          if (shouldShow) visible += 1;
        });
        if (selectedRecord && !markerLayer.hasLayer(selectedRecord.marker)) {
          clearActiveMarker();
          map.closePopup();
          setPanelEmpty();
        }
        const label = category === 'all' ? 'all categories' : categoryLabels[category].toLowerCase();
        setStatus(`Showing ${visible} of ${records.length} public locations — ${label}.`);
      };

      const resetMap = () => {
        categorySelect.value = 'all';
        searchInput.value = '';
        applyFilter();
        clearActiveMarker();
        map.closePopup();
        setPanelEmpty();
        map.fitBounds(bounds, { padding: [18, 18] });
        setStatus(`Map reset. Showing all ${records.length} public locations.`);
      };

      form.addEventListener('submit', event => {
        event.preventDefault();
        const query = searchInput.value.trim().toLowerCase();
        if (!query) return;
        const exact = records.find(record => record.location.name.toLowerCase() === query);
        const partial = records.find(record => `${record.location.name} ${record.location.region}`.toLowerCase().includes(query));
        const match = exact || partial;
        if (!match) {
          setStatus(`No public map location matched “${searchInput.value.trim()}”.`);
          return;
        }
        categorySelect.value = 'all';
        applyFilter();
        selectRecord(match, true);
        match.marker.openPopup();
      });

      categorySelect.addEventListener('change', applyFilter);
      resetButton.addEventListener('click', resetMap);
      fullscreenButton.addEventListener('click', () => {
        if (!document.fullscreenElement && root.requestFullscreen) {
          root.requestFullscreen().then(() => map.invalidateSize()).catch(() => setStatus('Fullscreen mode is not available in this browser.'));
        } else if (document.exitFullscreen) {
          document.exitFullscreen();
        }
      });
      document.addEventListener('fullscreenchange', () => {
        fullscreenButton.textContent = document.fullscreenElement ? 'Exit Fullscreen' : 'Fullscreen';
        window.setTimeout(() => map.invalidateSize(), 80);
      });
      window.addEventListener('resize', () => map.invalidateSize());

      map.fitBounds(bounds, { padding: [18, 18] });
      setStatus(`Showing all ${records.length} public locations. Drag to pan, scroll or use the controls to zoom.`);
    })
    .catch(() => {
      canvas.innerHTML = '<p class="interactive-map-note">The map data could not be loaded. The standard Terra map remains available on the Terra article.</p>';
      setStatus('Interactive map data unavailable.');
    });
})();
