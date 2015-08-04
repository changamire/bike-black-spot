var LATITUDE = 0, LONGITUDE = 1;
var MAP_MARKER = 0;

var ActiveInfoWindow = null;
var Melbourne = [-37.817443, 144.960140];

function getMapsDataFromReports(map) {
	var rawLocations = [];
	var markerData = [];

	$.ajax({
		dataType: "json",
		url: "/reports",
		success: function(reports) {
			reports.forEach(function(report){
				markerData.push([report.latitude, report.longitude, report.category, report.description, report.address, report.image]);
			})
			placeReportLocationMarkersOnMap(map,markerData);
		}
	});
	
}

function generateInfoWindowHtml(markerData) {
	description = '';
	if (markerData[2] != null) {
		description = '<h4>' + 'Description' + '</h4>'
		+ '<p>' + markerData[2] + '</p>'
	}

	var textDiv = '<div class="info-window-text">'
	+ '<h4>' + 'Issue' + '</h4>' 
	+ '<p>' + markerData[1] + '</p>' 
	+ description
	+ '<h4>' + 'Address' + '</h4>'
	+ '<p>' + markerData[3] + '</p>'
	+ '</div>';

	var imageDiv = '';
	if (markerData[4] != null) {
		imageDiv = '<div class="info-window-image">'
		+ '<img src="' + markerData[4] + '"></img>'
		+ '</div>';
	}

	return '<div class="info-window">' + textDiv + imageDiv + '</div>';
}

function generateInfoWindowsForReports(map, markerData) {
	markerData.forEach(function(marker) {
		var infoContent = generateInfoWindowHtml(marker)
		var infoWindow = new google.maps.InfoWindow({
			content: infoContent
		})

		google.maps.event.addListener(marker[MAP_MARKER], 'click', function() {
			if(ActiveInfoWindow != null) ActiveInfoWindow.close(); 
    		infoWindow.open(map,marker[MAP_MARKER]);
    		ActiveInfoWindow = infoWindow;
  		});
	})
}

function placeReportLocationMarkersOnMap(map, reportData) {
	var mapData = [];

	reportData.forEach(function(data) {
		mapData.push( 
			[new google.maps.Marker({
				position: new google.maps.LatLng(data[LATITUDE], data[LONGITUDE]),
    			map: map,
    			icon: '/images/blackspot.png'
			}), 
			data[2], data[3], data[4], data[5]]
    	)
    })

    generateInfoWindowsForReports(map, mapData);
}

function setMapToUserLocation(map) {
    if (navigator.geolocation) {
      	navigator.geolocation.getCurrentPosition(function(position) {
      		map.panTo(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
      	});
    }
}

function initialiseMaps() {
	var mapCanvas = document.getElementById('map-canvas');
    var mapOptions = {
		scrollwheel: false,
		center: new google.maps.LatLng(Melbourne[LATITUDE], Melbourne[LONGITUDE]),
		zoom: 14,
		mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(mapCanvas, mapOptions);

    getMapsDataFromReports(map);

    google.maps.event.addListener(map, 'click', function() {
		if(ActiveInfoWindow != null) ActiveInfoWindow.close(); 
		ActiveInfoWindow = null;
	});

	setMapToUserLocation(map);

}