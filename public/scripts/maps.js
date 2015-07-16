function getMapsDataFromReports() {
	var rawLocations = [];
	var markerData = [];

	$.ajax({
		dataType: "json",
		url: "/reports",
		async: false,
		success: function(reports) {
			reports.forEach(function(report){
				//rawLocations.push(new google.maps.LatLng(report.lat,report.long));
				markerData.push([report.lat, report.long, report.description]);
			})
		}
	});

	return markerData;
}

function generateInfoWindowsForReports(map, markers) {
	var infoContent = '<h1>Hello World</h1>';
	markers.forEach(function(marker) {
		var infoWindow = new google.maps.InfoWindow({
			content: infoContent
		})
		google.maps.event.addListener(marker, 'click', function() {
    		infoWindow.open(map,marker);
  		});
	})

	
}

function placeReportLocationMarkersOnMap(map, reportLocations) {
	var markers = [];

	reportLocations.forEach(function(latlong) {
		markers.push( new google.maps.Marker({
	    		position: new google.maps.LatLng(latlong[0], latlong[1]),
	    		map: map
    		})
    	)
    })

    generateInfoWindowsForReports(map, markers);
}

function initialiseMaps() {
	var mapCanvas = document.getElementById('map-canvas');
    var mapOptions = {
		scrollwheel: false,
		center: new google.maps.LatLng(-27.4667, 153.0333),
		zoom: 12,
		mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(mapCanvas, mapOptions);

    placeReportLocationMarkersOnMap(map,getMapsDataFromReports());

}