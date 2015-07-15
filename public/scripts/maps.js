function getMapsLatLongFromReports() {
	var rawLocations = [];
	$.ajax({
		dataType: "json",
		url: "/reports",
		async: false,
		success: function(reports) {
			reports.forEach(function(report){
				rawLocations.push(new google.maps.LatLng(report.lat,report.long));
			})
		}
	});
	return rawLocations;
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

    var reportLocations = getMapsLatLongFromReports();

    reportLocations.forEach(function(latlong){
    	new google.maps.Marker({
    		position: latlong,
    		map: map
    	})
    })
}