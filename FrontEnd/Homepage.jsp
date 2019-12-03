/**
 * 
 */
/*
console.log("here");
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
    addMarker(loc, "<div class=\"infoWindow\"><h1 class=\"infoTitle\">First</h1><br><img class=\"infoImg\" ><h2 class=\"infoRating\">7/10</h2></div>");
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
*/

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

    var loc = {lat: 34.018852, lng: -118.28740};
    var loc2 = {lat: 34.018867, lng: -118.287441};
    var loc3 = {lat: 34.018774, lng: -118.287539};
    
    var loc4 = {lat: 34.022613, lng: -118.290796};
    var loc5 = {lat: 34.021465, lng: -118.283847};
    var loc6 = {lat: 34.021785, lng: -118.28454};
    var loc7 = {lat: 34.021816, lng: -118.284652};
    
    var loc8 = {lat: 34.021165, lng: -118.284216};
    var loc9 = {lat: 34.021039, lng: -118.28400};
    var loc10 = {lat: 34.021319, lng: -118.283994};
    

    var exampleMachine = {
        img: "ams39snack.jpg",
        name: "VM 1",
        loc: "HAR",
        average: "4.5",
        id:10
    };
    addMarker(loc, stringifyMachine(exampleMachine));
    
    var exampleMachine2 = {
        img: "ams39snack.jpg",
        name: "VM 2",
        loc: "HAR",
        average: "4.5",
        id:1
    };
    addMarker(loc2, stringifyMachine(exampleMachine2));

    var exampleMachine3 = {
        img: "ams39snack.jpg",
        name: "VM 3",
        loc: "KAP",
        average: "4.5",
        id:2
    };
    addMarker(loc3, stringifyMachine(exampleMachine3));
  
    var exampleMachine4 = {
        img: "ams39snack.jpg",
        name: "VM 4",
        loc: "KAP",
        average: "4.5",
        id:3
    };
    addMarker(loc4, stringifyMachine(exampleMachine4));

    var exampleMachine5 = {
        img: "ams39snack.jpg",
        name: "VM 5",
        loc: "SOS",
        average: "4.5",
        id:4
    };
    addMarker(loc5, stringifyMachine(exampleMachine5));


    var exampleMachine6 = {
        img: "ams39snack.jpg",
        name: "VM 6",
        loc: "THH",
        average: "4.5",
        id:5
    };
    addMarker(loc6, stringifyMachine(exampleMachine6));
    
    var exampleMachine7 = {
        img: "ams39snack.jpg",
        name: "VM 7",
        loc: "THH",
        average: "4.5",
        id:6
    };
    addMarker(loc7, stringifyMachine(exampleMachine7));

    var exampleMachine8 = {
        img: "ams39snack.jpg",
        name: "VM 8",
        loc: "VKC",
        average: "4.5",
        id:7
    };
    addMarker(loc8, stringifyMachine(exampleMachine8));


    var exampleMachine9 = {
        img: "ams39snack.jpg",
        name: "VM 9",
        loc: "VKC",
        average: "4.5",
        id:8
    };
    addMarker(loc9, stringifyMachine(exampleMachine9));
    
    var exampleMachine10 = {
        img: "ams39snack.jpg",
        name: "VM 9",
        loc: "VKC",
        average: "4.5",
        id:9
    };
    addMarker(loc10, stringifyMachine(exampleMachine10));
    

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
    stringBuild += "ams39snack.jpg";
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