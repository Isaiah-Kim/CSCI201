<!DOCTYPE html> 

<html> 
<head>
<meta charset="UTF-8">
<title>Homepage</title>
<link rel="stylesheet" href="Homepage.css">
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
/*
var arr = window.location.href;
var autharr = arr.split("auth=");
var auth = autharr[1];
  $(document).ready(function() {
    
    
    console.log("Auth is "+ auth);
    
    var sect = document.getElementById("authenticated");
    var prof = document.getElementById("profile");
    
    if(auth==null || auth.length!=64)
    {
        prof.style="display: none";
    }else{
      sect.style="display: none";
      document.getElementById("hiddenAuth").value=auth;
    }
  });
  
function toProfile(){
    
    location.href='Profile.jsp?auth='+auth;
  }
  
  */
  function getRadioVal(form, name) {
      var val;
      var radios = form.elements[name];
      
      for (var i=0, len=radios.length; i<len; i++) {
          if ( radios[i].checked ) {
            val = radios[i].value;
              break;
          }
          if( i == len-1){
            val = "-1";
          }
      }
      return val;
  }
  
  function search(){
    var itemValue = getRadioVal(document.getElementById('filterform'), 'item');
    var paymentValue = getRadioVal(document.getElementById('filterform'), 'item');
    var rangeValue = document.getElementById("sliderRange");
    var xhttp = new XMLHttpRequest();
    xhttp.open("GET", "SearchDatabase?product=" + document.myformSearchPage.item.value +"&itemValue=" + itemValue + "&paymentValue=" + paymentValue + "&rangeValue=" + rangeValue, false);
    xhttp.send();
    return true;
  }
  function history(){
    var xhttp = new XMLHttpRequest();
    xhttp.open("GET", "HistoryDatabase?", false);
    xhttp.send();
    return true;
  }
  
  $(document).ready(function(){
	  var res = <%= session.getAttribute( "resultMachines" ) %>;
	  console.log(res);
	  var machines = <%= session.getAttribute("jsonY") %>;
	  console.log(machines);
	  if(res == null){
		  $.getJSON("AllMachinesDatabase", function(result){
			  console.log(result);
			result.forEach(function(item){
				var latlng={
						lat: item.lat,
						lng: item.lng
				}
				
				addMarker(latlng, stringifyMachine(item));
			})
		  });
	  } else {  machines.forEach(function (item){
			var latlng = {
					lat: item.lat,
					lng: item.lng
				}
				
				addMarker(latlng, stringifyMachine(item));
			});}
	
  });
</script>



 <script async defer 
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB0hzC85PcofCh0luuo5By7JgublOMvWds&callback=initMap">
    </script>
    <script type="text/javascript" src="mapping.js"></script>
    
</head>
<style> 
  
.rangeslider{ 
    width: 50%; 
    font-family:roboto;
   font-size:25px;
color: #696969;
margin-left: 20px;
margin-top: 25px;
} 
  
.myslider { 
    -webkit-appearance: none; 
    background: white; 
    width: 50%; 
    height: 20px; 
    opacity: 2; 
    border-radius: 25px;
    border:0px white;
box-shadow: 0px 1px 4px 0.5px #696969;
width: 260px;
height: 25px;
   } 
  
  
.myslider::-webkit-slider-thumb { 
    -webkit-appearance: none; 
    cursor: pointer; 
    border-radius:25px;
    background: white; 
    box-shadow: 0px 1px 4px 0.5px #696969;
    border: 0px;
    width: 23px; 
    height: 23px; 
} 
  
  
.myslider:hover { 
    opacity: 1; 
}
  
</style> 
<body> 
<div class="tab">
  <div class = "centerFilter"> <p id= "filter"> Filters </p> </div> <br>
  <form name="filterform" method = GET action = "Homepage.jsp" class = "FORM" onsubmit = "return search();"> <br>
<p id = "item">Items</p> <br>
  <input type="radio" name="item" value="1"> food
  <input type="radio" name="item" value="2"> drink<br> 
<p id = "payment">Payment</p>
  <input type="radio" name="payment" value="1"> Cash
  <input type="radio" name="payment" value="2"> Card<br>  
  
  
<div class="rangeslider"> 
  <p>Rating: <span id="demo"></span></p> 
  <input type="range" min="0" max="5" value="1" step="1" class="myslider" id="sliderRange"> 
  
</div> 
 <input type="submit" value="Submit">
</form>
</div>
<form name="myformSearchPage" method=GET action="Homepage.jsp" onsubmit = "return search();"
      class="containerSearchPage"> 
      
      <input type="text" name="item"
        placeholder="What would you like to find?" class = "searchInput"> 
      
      <button class = "inputSearch"    type="submit">
        <img class="inputImage" src="magGlass.png"/>
       </button>
</form>
<div class="headerHome">
    <div class="loginRegister" id="authenticated">
      <a class="link" href="Login.jsp">Login   |   </a>
      <a class="link" href="Register.jsp">Register</a>
    </div>
</div>
<br>
<div id = "map" class = "mapp"></div>
    
  
<script> 
var rangeslider = document.getElementById("sliderRange"); 
var output = document.getElementById("demo"); 
output.innerHTML = rangeslider.value; 
  
rangeslider.oninput = function() { 
  output.innerHTML = this.value; 
} 
</script> 
  
</body> 
</html>