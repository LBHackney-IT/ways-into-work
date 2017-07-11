$.fn.handleMaps = function() {

  if (this.length === 0) { return false; }


  $.ajax({
    url: '/hubs',
    type: "get",
    dataType: 'json',
    success: function(response) {
      renderMaps(response.token, response.maps)
    }
  });

  function renderMaps(accessToken, maps_array) {
    L.mapbox.accessToken = accessToken;
    maps_array.forEach(function(map) {
      hub_map = L.mapbox.map('hub_map_' + map.hub_id, 'mapbox.streets').setView([map.lat, map.lon], 15);
      hub_map.featureLayer.setGeoJSON(
        [{
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [map.lon, map.lat]
          },
          properties: {
            name: map.name,
            address: map.street,
            'marker-color': '#00607d',
            'marker-symbol': 'circle',
            'marker-size': 'medium'
          }
        }])
      })
    };


};
