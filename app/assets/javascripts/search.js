
var centerPoint = { lat: 39.50, lng: -98.35 };
var zoom = 4;
var lat;
var long;
var score = 0


function initAutocomplete() {
  var map = new google.maps.Map(document.getElementById('map'), {
        center: centerPoint,
        zoom: zoom
    });

  var marker = new google.maps.Marker({
      map: map,
      position: centerPoint,
      draggable: true
  });

  var input = (document.getElementById('pac-input'));
  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  autocomplete.addListener('place_changed', function () {
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
        window.alert("Autocomplete's returned place contains no geometry");
        return;
    }

      // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
    } else {
        map.setCenter(place.geometry.location);
        map.setZoom(10);
    }

    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
          (place.address_components[0] && place.address_components[0].short_name || ''),
          (place.address_components[1] && place.address_components[1].short_name || ''),
          (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    lat = place.geometry.location.lat();
    long = place.geometry.location.lng();

    $('#latitude').val(lat);
    $('#longitude').val(long);

    if($("#yourCharacters").length) {
      $("#yourCharacters").children(".listing").remove();
      score = 0;
    }

    function sendCoordinates(lat, long) {
      $.ajax({
        method: "POST",
        url: "/api/v1/characters",
        dataType: "JSON",
        data: {
          location: {
            lat: lat,
            long: long
          }
        },
        success: function(response){
          renderCharacters(response);
        }
      });
    }

    function renderCharacters(response) {
      var distances = response[1]
      response[0].forEach(function(character) {
        $('#yourCharacters').append(renderCharacter(character, distances));
      });
    }

    function renderCharacter(character, distances) {
      score = score + 1;
      var name = character["name"];
      var location = character["location"];
      var distance = distances[score - 1];

      return '<div class="listing"><br><li class="list-group-item">' +
            '<h4 class="list-group-item-heading">' +
            '<small class="text-muted">Number ' + score +
            ':</small>' + '<strong>  ' + name + '</strong></h4>' +
            '<h5 class="list-group-item-text"><small>  resides in      ' +
            '</small>' + location + '</h5>' +
            '<h5 class="list-group-item-text">' + distance +
            '<small>   Miles away</small></h5></li></div>'
    };

    sendCoordinates(lat, long);
    $('#pac-input').val('');
  });
}
