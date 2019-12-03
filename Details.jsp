<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail </title>
<link rel="stylesheet" href="DetailsStyleSheet.css">
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
	  <form name="filterform" method = GET action = "SearchResults.jsp" onsubmit="return search();" class = "FORM"> <br>
	<p id= "item">Items</p> <br>
	  <input type="radio" name="item" value="1">Food
	  <input type="radio" name="item" value="2">Drink<br> 
	
	<p id= "payment">Payment</p>
	  <input type="radio" name="payment" value="1"> Cash
	  <input type="radio" name="payment" value="2"> Card<br>  
	  
	  
	<div class="rangeslider"> 
	  <p>Rating: <span id="demo"></span></p> 
	  <input type="range" min="1" max="5" value="1" step="1"
	                  class="myslider" id="sliderRange"> 
	  
	</div> 
	 <input type="submit" class="submit" value="Search">
	</form>


</div>
<form name="myformSearchPage" method=GET action="SearchResults.jsp" onsubmit="return search();"
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
		
<%

		//get vending machine item here at index i
			//VendingMachine vm = hist.get(i);
			//String name = vm.getName();
			//String loc = vm.getLocation();
			//String itemValue =vm.getItemValue();
			//double rating = vm.getRating();
			//String payment=vm.getPaymentValue();
								
%>		
	<div class="vm-wrapper">
		<div class="vm-image">
		<img src="IMG_8333.JPG" class="img" width="500%" height="50%" >
		</div>
	<div class="reviewbutton">
		<button type="button" class="loginRegister" onclick="reviewShow()">Write a review</button>
	</div>
	<div id="myDIV">
<form>
  <fieldset>
    <span >
      <input type="radio" id="rating-5" name="rating" value="5" /><label for="rating-5">5</label>
      <input type="radio" id="rating-4" name="rating" value="4" checked="checked" /><label for="rating-4">4</label>
      <input type="radio" id="rating-3" name="rating" value="3" /><label for="rating-3">3</label>
      <input type="radio" id="rating-2" name="rating" value="2" /><label for="rating-2">2</label>
      <input type="radio" id="rating-1" name="rating" value="1" /><label for="rating-1">1</label>
      <input type="radio" id="rating-0" name="rating" value="0" /><label for="rating-0">0</label>
    </span>
  </fieldset>

	<input type="text" style="width: 50%; height: 100%;" name=review>
	
	</form>
	</div>
	</div>
	<div class = "right">
			<h2 id="title">Vending Machine 7</h2>
			<h2 id="rating"> Rating: "</h2>
			<h2 id="location"> Location: </h2>
			<h2 id="type"> Type: </h2>
			<h2 id="payment"> Payment: </h2>
			<%
			// List<Review> reviews = new ArrayList<Review>();
			//for(int i = 0; i < reviews.size(); i++) { 
			//	Review r = reviews.get(i);
			//	String username = r.getUser();
			//	String rating = r.getRevInt();
			//	String rev = r.g//etReview(); */
			%>
		<strong>Username </strong><br/>
		Rating: rate<br/>
		Review <br/> <br/>
		<%	//} %>
	
	</div>
			
<script>
function reviewShow() {
	String user= "hvhvj"//(String)session.getAttribute("user");
	if(user==null)
		{
			//Not logged in: Unable to add review
			return;
		}
  var x = document.getElementById("myDIV");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
</script>


</body>
</html>