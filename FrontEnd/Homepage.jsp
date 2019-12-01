<!DOCTYPE html> 

<html> 
<head>
<meta charset="UTF-8">
<title>Homepage</title>
<link rel="stylesheet" href="Homepage.css">
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
  <div class = "centerFilter"> <p id="filter">Filters</p> </div> <br>
  <form name="filterform" method = GET action = "SearchResults.jsp" class = "FORM"> <br>
<p id= "item">Items</p> <br>
  <input type="radio" name="item" value="food">Food
  <input type="radio" name="item" value="drink">Drink<br> 

<p id= "payment">Payment</p>
  <input type="radio" name="payment" value="Cash"> Cash
  <input type="radio" name="payment" value="Card"> Card<br>  
  
  
<div class="rangeslider"> 
  <p>Rating: <span id="demo"></span></p> 
  <input type="range" min="1" max="5" value="1" step="1"
                  class="myslider" id="sliderRange"> 
  
</div> 
 <input type="submit" class="submit" value="Search">
</form>


</div>
<form name="myformSearchPage" method=GET action="SearchResults.jsp"
class="containerSearchPage">


<input type="text" name="item"
placeholder="What would you like to find?" class = "searchInput"> 

<button class = "inputSearch" type="submit">
<img class="inputImage" src="magGlass.png"/>
 </button>
</form>

<div class="headerHome">
<div class="loginRegister" id="authenticated">
<a class="link" href="Login.jsp">Login</a>
<a class="link" href="Register.jsp">Register</a>
</div>
</div>
 
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