
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import=" java.util.List, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>History</title>
<link rel="stylesheet" href="HistoryStyleSheet.css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
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
	  <input type="range" min="0" max="5" value="1" step="1"
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

<div class="profileImage">
	
	<img class="inputImageProfile" src="instagram+person+profile+icon-1320184028516722357.png" />
	
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

		//String user=(String)session.getAttribute("user");

%>

<%

		 /* List<VendingMachine> hist= new ArrayList<VendingMachine>();
		if((ArrayList<VendingMachine>)session.getAttribute("historyMachines") != null)
		hist = (ArrayList<VendingMachine>)session.getAttribute("historyMachines");
		for(int i = 0; i < hist.size(); i++) { 
			VendingMachine vm = hist.get(i);
			String name = vm.getName();
			int id= vm.getId();
			String url = "/Details.jsp?id="+id;
			String loc = vm.getLocation();
			String itemValue =vm.getItemValue();
			double rating = vm.getRating(); */
								
%>
	
	<div style="padding-top:2%;">
		
		<h2 class="title"> Hyunjae's History </h2><br>
		
		<div class="vm-image">
			<a href="/Details.jsp?">
		    	<img src="IMG_8333.JPG" width="60%" height="30%">
			</a>
		</div>
		<div class="info">
			<h3> Vending Machine 1</h3>
<%
			double j=0.0;
%>
<%
			for(j = 4.5; j >= 1; j--){
%>
									<i class="fa fa-star" aria-hidden="true" style="color: gold;"></i>&nbsp;
<%
								}
								if(j == 0.5){
%>
									<i class="fa fa-star-half-o" aria-hidden="true" style="color: gold;"></i>&nbsp;
<%
								}
								for(double k = 5 - 4.5; k >= 1; k--){
%>
									<i class="fa fa-star-o" aria-hidden="true" style="color: gold;"></i>&nbsp;
<%
									String rand = "";
								}
%>
			<h5>Location: VKC</h5>
			<h5>Type: Drink</h5>
			
			</div>
			<hr style="margin-top:23%; width:950px; ">
	</div>



</body>
</html>