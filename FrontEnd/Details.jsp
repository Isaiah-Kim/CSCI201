<%@ page language="java" contentType="text/html; charset=UTF-8" import="Project.VendingMachine, Project.Review"
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
<div id="ind" value=<%=request.getParameter("id") %>></div>
<script>
function setDetail(){
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET","SetDetails?id=" + document.getElementById("ind").value);
	xhttp.send();
}
setDetail();
</script>
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
		<%
			String actionCommand = "Details.jsp?id=" + request.getParameter("id");
		%>
		<button type="button" class="writeReview">Write a review</button>
		<form name="formReview" class="formReview" method=GET action=<%=actionCommand %> onsubmit="return true;">
  	<fieldset class="rater">
    <span >
      <input type="radio" id="rating-5" name="rating" value="5" /><label for="rating-5">5</label>
      <input type="radio" id="rating-4" name="rating" value="4" checked="checked" /><label for="rating-4">4</label>
      <input type="radio" id="rating-3" name="rating" value="3" /><label for="rating-3">3</label>
      <input type="radio" id="rating-2" name="rating" value="2" /><label for="rating-2">2</label>
      <input type="radio" id="rating-1" name="rating" value="1" /><label for="rating-1">1</label>
      <input type="radio" id="rating-0" name="rating" value="0" /><label for="rating-0">0</label>
    </span>
  </fieldset>

	<input class="reviewWriter" type="text" style="width: 50%; height: 100%;" name=review required placeholder="Review the vending machine!">
	<button class = "yes" type="submit">Submit</button>
	</form>
	</div>
	<div class="myDiv">
	
	</div>
	</div>
	<div class = "right">
	<%
			VendingMachine vm = (VendingMachine)session.getAttribute("detailMach");
			String title = vm.getName();
			String rating = Double.toString(vm.getRating());
			String loc = vm.getLocation();
			String type = vm.getItemValue();
			String pay = vm.getPaymentValue();
			List<Review> rev = vm.getReviews();
	%>
			
			<h2 id="title"><%= title %></h2>
			<h2 id="nontitle"> Rating: <%= rating %></h2>
			<h2 id="nontitle"> Location: <%= loc %></h2>
			<h2 id="nontitle"> Type: <%= type %></h2>
			<h2 id="nontitle"> Payment: <%= pay %></h2>
			<h2 id="nontitle"> Reviews: </h2>
			<%
			for(int i =0; i < rev.size(); i++){
				String user = rev.get(i).getUser();
				String review = rev.get(i).getReview();
				int revInt = rev.get(i).getRevInt();
				String rat = Integer.toString(revInt);
%>
				<h3 id="reviewUser"><strong>Username: <%= user %></strong></h3>
		
				<h3 id="reviewText">Rating: <%= rat %></h3>
				<h3 id="reviewText">Review <%= review %></h3> 

<%
			}
%>
			
<%
			// List<Review> reviews = new ArrayList<Review>();
			//for(int i = 0; i < reviews.size(); i++) { 
			//	Review r = reviews.get(i);
			//	String username = r.getUser();
			//	String rating = r.getRevInt();
			//	String rev = r.g//etReview(); */
			%>
			
			
		
		<%	//} %>
	
	</div>
			
<script>
/* function reviewShow() {
	String user= "hvhvj"//(String)session.getAttribute("user");
	if(user==null)
		{
			//Not logged in: Unable to add review
			return;
		}
  document.getElementById("myDiv").style.display="block";
} */


</script>
<script type="text/javascript"> 
/* $(document).ready(function() { 
    $('input[type="radio"]').click(function() { 
        var inputValue = $(this).attr("value"); 
        var targetBox = $("." + inputValue); 
        $(".selectt").not(targetBox).hide(); 
        $(targetBox).show(); 
        alert("User is not logged in. Cannot leave a review"); 
    }); 
});  */
</script>


</body>
</html>