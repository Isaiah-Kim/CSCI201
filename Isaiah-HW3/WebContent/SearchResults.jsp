<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 

<meta charset="UTF-8">
<title>This is the SearchResults page. </title>
<link rel="stylesheet" href = "HomePage.css" >

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

<script>

var url= (window.location.search).substring(6).split("&");
console.log(window.location.search);
var previous = window.location.search;
var name = url[0];
var temp = url[1] != null ? url[1].split("="): "N/A";
var type = temp[1];
var search =";"

var arr = window.location.href;
var autharr = arr.split("auth=");
var auth = autharr[1];

$(document).ready(function() {
	
	
	console.log(auth);
	
	if(auth==null || auth.length!=64)
	{
		document.getElementById("profile").style="display: none";
	}else{
		document.getElementById("profile").style="display: flex";
		document.getElementById("hiddenAuth").value=auth;
	}
		
	if(name=="" || type =="/"){
		alert("Error: No Results. Redirecting to HomePage.")
		window.location.href = 'HomePage.jsp'
	}else{
		if(type=="Name"){
			search = 'https://www.googleapis.com/books/v1/volumes?q=intitle:'+name
		}else if(type=="Author"){
			search = 'https://www.googleapis.com/books/v1/volumes?q=inauthor:'+name
		}else if(type=="ISBN"){
			search = 'https://www.googleapis.com/books/v1/volumes?q=isbn:'+name
		}else if(type=="Publisher"){
			search = 'https://www.googleapis.com/books/v1/volumes?q=inpublisher:'+name
		} else {
			alert("Error: No Results. Redirecting to HomePage.")
			window.location.href = 'HomePage.jsp'
		}
		
		console.log(name + " " + type)
		$.ajax({
	        type: 'GET',
	        url: search,
	        contentType: "application/json"
	    }).done(function(data) {
			saved = JSON.parse(JSON.stringify(data))
			console.log(saved)
			if(saved.totalItems==0)
				{
					alert("Error: No Results. Redirecting to HomePage.")
					window.location.href = 'HomePage.jsp'
				}
			else{
				for(i=0;i<saved.items.length;i++){
					$("#queryList").append('<div class="search_container"><hr><a href="Details.jsp?' +saved.items[i].id+previous +'"><img class = "search_image" src='+saved.items[i].volumeInfo.imageLinks.thumbnail +'alt="" height="82"> </a>' + '<div class="search_text"> <h2>'+saved.items[i].volumeInfo.title+'</h2>'+'<h3><i>'+saved.items[i].volumeInfo.authors+"</i></h3><p> <b>Summary: </b>"+saved.items[i].volumeInfo.description +'</p></div></div><hr>');
				}
				console.log(saved.items);
			}
			
			
	    })
	}
});

function toProfile(){
	
	location.href='Profile.jsp?auth='+auth;
}

function toHome(){
	location.href='HomePage.jsp?auth='+auth;
}

</script>

</head>
<body>

<div class = "top">
	<div class="logo">
		<a onClick="toHome()" style="cursor:pointer"><img
			src="bookworm.png" /></a>
	</div>
	<form name="myformSearchPage" method=GET action="SearchResults.jsp"
			class="containerSearchPage">

			<input type="text" name="book"
				placeholder="Search for your favorite book!" class = "searchInput"> 
			
			<button class = "inputSearch"    type="submit">
				<img class="inputImage" src="magnifying_glass.png"/>
			 </button>
			
			
			
			<div style = "margin-left: 20%^">
				<div class="radio2">
				<input type="radio" name="button" value="Name"> Name <br>
				<input type="radio" name="button" value="ISBN"> ISBN 
				</div>
			<div class="radio2">
				<input  type="radio" name="button" value="Author"> Author<br>
				<input  type="radio" name="button" value="Publisher"> Publisher 
			</div>
			</div>
			<input type="text" id="hiddenAuth" name="auth" style="display: none">
			<div class="profilePic" style="display: none; cursor: pointer"id="profile" onclick="toProfile()">
				<img class="profileImage" src="profile.png"/>
		</div>
		</form>
		
</div>
		<hr>


	<div  class = "searchHeader"> 
		<h1> Results for: "<%= request.getParameter("book") %>" </h1>
	</div>
	
	
	<div id="queryResult"> 
			
            <ol id="queryList" style="list-style-type:circle;"></ol>
        </div>
	
</body>
</html>