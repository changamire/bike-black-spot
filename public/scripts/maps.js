var LATITUDE = 0, LONGITUDE = 1;
var MAP_MARKER = 0;

var ActiveInfoWindow = null;

function getMapsDataFromReports() {
	var rawLocations = [];
	var markerData = [];

	$.ajax({
		dataType: "json",
		url: "/reports",
		async: false,
		success: function(reports) {
			reports.forEach(function(report){
				markerData.push([report.latitude, report.longitude, report.category, report.description, report.image]);
			})
		}
	});
	return markerData;
}

function generateInfoWindowHtml(markerData) {
	var textDiv = '<div class="info-window-text">'
	+ '<h4>' + 'Issue' + '</h4>' 
	+ '<p>' + markerData[1] + '</p>' 
	+ '<h4>' + 'Description' + '</h4>'
	+ '<p>' + markerData[2] + '</p>'
	+ '<h4>' + 'Address' + '</h4>'
	+ '<p>' + 'Test street' + '</p>'
	+ '</div>';
	var imageDiv = '<div class="info-window-image">'
	+ '<img src="' + markerData[3] + '"></img>'
	+ '</div>';

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
    			map: map
			}), 
			data[2], data[3], data[4]]
    	)
    })

    generateInfoWindowsForReports(map, mapData);
}

function initialiseMaps() {
	var mapCanvas = document.getElementById('map-canvas');
    var mapOptions = {
		scrollwheel: false,
		center: new google.maps.LatLng(-27.4667, 153.0333),
		zoom: 14,
		mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(mapCanvas, mapOptions);

    placeReportLocationMarkersOnMap(map,getMapsDataFromReports());

    google.maps.event.addListener(map, 'click', function() {
		if(ActiveInfoWindow != null) ActiveInfoWindow.close(); 
		ActiveInfoWindow = null;
	});

}