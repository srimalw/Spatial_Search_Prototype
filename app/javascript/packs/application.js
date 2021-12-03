// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import Leaflet from "leaflet"
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


document.addEventListener("DOMContentLoaded", function(event) { 

    // var map = L.map('map', {});
    // map.setView([51.52238797921441, -0.08366235665359283], 18);
    buildMap(51.52238797921441, -0.08366235665359283);
});

function buildMap(lat,lon)  {
    document.getElementById('weathermap').innerHTML = "<div id='map' style='width: 100%; height: 100%;'></div>";
    var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    osmLayer = new L.TileLayer(osmUrl, {maxZoom: 18});
    var map = new L.Map('map');
    map.setView(new L.LatLng(lat,lon), 9 );
    map.addLayer(osmLayer);

    var popup = L.popup();
    var popup2 = L.popup();

    function onMapClick(e) {
        var uri = "/api/v1/geoJson/lat_lng_details?lat=" + e.latlng.lat + "&lng=" + e.latlng.lng
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            popup.closePopup();
            popup2
            .setLatLng(e.latlng)
            .setContent("Retuned Json" + this.responseText)
            .openOn(map);
          }
        };
        xhttp.open("GET", uri, true);
        xhttp.send();

        popup
        .setLatLng(e.latlng)
        .setContent("Clicked" + e.latlng.toString())
        .openOn(map);

    }

    map.on('click', onMapClick);
}