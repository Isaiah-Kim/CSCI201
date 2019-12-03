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
		
		var exampleMachine = {
				img: "ams39snack.jpg",
				name: "Jugemu",
				loc: "CarGar",
				average: "6.9"
		};
		
		var machines = <%=session.getAttribute("jsonY")%>;
		
		alert(machines);
		
		machines.forEach(function (item){
			var latlng = {
				lat: item.lat,
				lng: item.lng
			}
			
			addMarker(latlng, stringifyMachine(item));
		});
		
		//addMarker(loc, stringifyMachine(exampleMachine));
		//addMarker(loc, "<body><div class=\"infoWindow\"><img class=\"infoImg\" src=\"ams39snack.jpg\"><div class=\"infoTexts\"><h1 class=\"infoTitle\">First</h1><br><h2 class=\"infoRating\">7/10</h2></div></div></body>");
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
	
	function stringifyMachine(targetMachine){
		var stringBuild = "<div class=\"infoWindow\"><img class=\"infoImg\" src=\"";
		stringBuild += "ams39snack.jpg";
		stringBuild += "\"><div class = \"infoTexts\"><h1 class=\"infoTitle\">";
		stringBuild += targetMachine.name;
		stringBuild += "</h1><h2 class=\"infoLoc\">";
		stringBuild += targetMachine.loc;
		stringBuild += "</h2><h2 class=\"infoRating\">";
		stringBuild += targetMachine.average;
		stringBuild += "</h2></div></div>"
		//alert(stringBuild);
		return stringBuild;
	}
	
	function clearMap(){
		markers.forEach(function(item){
			item.setMap(null);
		});
		markers.length = 0;
	}