function getMapsDataFromReports() {
	var rawLocations = [];
	var markerData = [];

	$.ajax({
		dataType: "json",
		url: "/reports",
		async: false,
		success: function(reports) {
			reports.forEach(function(report){
				markerData.push([report.lat, report.long, report.description]);
			})
		}
	});

	return markerData;
}

function generateInfoWindowsForReports(map, markerData) {
	markerData.forEach(function(marker) {
		var infoContent = '<p>' + marker[1] + '</p>';
		var infoWindow = new google.maps.InfoWindow({
			content: infoContent
		})
		
		google.maps.event.addListener(marker[0], 'click', function() {
    		infoWindow.open(map,marker[0]);
  		});
	})
}

function placeReportLocationMarkersOnMap(map, reportData) {
	var mapData = [];

	reportData.forEach(function(data) {
		mapData.push( 
			[new google.maps.Marker({
				position: new google.maps.LatLng(data[0], data[1]),
    			map: map
			}), 
			data[2]]
    	)
    })

    generateInfoWindowsForReports(map, mapData);
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