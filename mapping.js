var map;
	var pos;
	
	var markers = [];
	var infoWindows = [];
	function initMap(){
		map = new google.maps.Map(document.getElementById('map'), { //Map accepts an object, pass it target.
			//Initialization values
			center: {lat: 34.02181, lng: -118.28585},
			zoom: 17
		});
		
		if(navigator.geolocation){
			navigator.geolocation.getCurrentPosition(function(position) {
				pos = {
					lat: position.coords.latitude,
					lng: position.coords.longitude
				};
				addMarker(pos, "Here I am");
			});
		};
		
		var loc = {lat: 34.02181, lng: -118.28585};
		addMarker(loc, "<div class=\"infoWindow\"><h1 class=\"infoTitle\">First</h1><br><img class=\"infoImg\" src=\"ams39snack.jpg\"><h2 class=\"infoRating\">7/10</h2></div>");
	}
	
	function addMarker(myLatLng, contentString){ //Pass just the html
		var marker = new google.maps.Marker({
			position: myLatLng,
			map: map
		});
		markers.push(marker);
		
		//Add InfoWindow
		//Will need to make some function to template the html
		
		var infowindow = new google.maps.InfoWindow({
			content: contentString
		});
		
		infoWindows.push(infowindow);
		
		marker.addListener('click', function() {
			infoWindows.forEach(function(iw){
				iw.close();
			})
			infowindow.open(map, marker);
		});
	}
	
	function clearMap(){
		markers.forEach(function(item){
			item.setMap(null);
		});
		markers.length = 0;
	}
