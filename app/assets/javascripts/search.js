
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
      $("#yourCharacters").children(".table-child").remove();
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
      response.forEach(function(character) {
        $('#yourCharacters').append(renderCharacter(character));
      });
    }

    function renderCharacter(character, index) {
      score = score + 1;
      var name = character["name"];
      var comics = character["comics"]["available"];
      var location = character["location"];

      return '<tr class="table-child row-style">' +
            '<td class="text-center cell1-style">' + score +
            '<td class="cell2-style"><strong>' + name + '</strong></td>' +
            '<td class="text-center cell3-style">' + comics + '</td>' +
            '<td class="cell4-style">' + location + '</td></tr>'
    };

    sendCoordinates(lat, long);
    $('#pac-input').val('');
  });
}
