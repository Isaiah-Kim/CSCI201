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
				var marker = new google.maps.Marker({
					position: pos,
					map: map,
					icon: 'favicon.ico'
				});
				markers.push(marker);
				
				//Add InfoWindow
				//Will need to make some function to template the html
				
				var infowindow = new google.maps.InfoWindow({
					content: 'You are here'
				});
				
				infoWindows.push(infowindow);
				
				marker.addListener('click', function() {
					infoWindows.forEach(function(iw){
						iw.close();
					})
					infowindow.open(map, marker);
				});
			});
		};
		
		var loc = {lat: 34.02181, lng: -118.28585};
		
		var exampleMachine = {
				img: "ams39snack.jpg",
				name: "Testing Machine",
				loc: "Cromwell Field",
				average: "3.4",
				id:34
		};
		
		//var machines = <%=session.getAttribute("jsonY")%>;
		
		/*alert(machines);
		
		machines.forEach(function (item){
			var latlng = {
				lat: item.lat,
				lng: item.lng
			}
			
			addMarker(latlng, stringifyMachine(item));
		});
		*/
		addMarker(loc, stringifyMachine(exampleMachine));
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
		//alert(targetMachine);
		var stringBuild = "<div class=\"infoWindow\"><img class=\"infoImg\" src=\"";
		stringBuild += "ams40snack.jpg";
		stringBuild += "\"><div class = \"infoTexts\"><h1><a class=\"infoTitle\" href=\"Details.jsp?id=";
		stringBuild += targetMachine.id;
		stringBuild += "\">";
		stringBuild += targetMachine.name;
		stringBuild += "</a></h1><h2 class=\"infoLoc\">";
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