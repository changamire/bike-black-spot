var LAT = 0, LONG = 1;
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
				markerData.push([report.lat, report.long, report.description]);
			})
		}
	});

	return markerData;
}

function generateInfoWindowsForReports(map, markerData) {
	markerData.forEach(function(marker) {
		var infoContent = '<p>' + marker[1] + '</p>' + 
		'<img src="http://i.dailymail.co.uk/i/pix/2013/02/21/article-2281982-18258EA7000005DC-231_964x649.jpg" style="max-width:200px;"></img>';
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
				position: new google.maps.LatLng(data[LAT], data[LONG]),
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