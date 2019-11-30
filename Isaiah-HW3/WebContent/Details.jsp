<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Details.</title>
<link rel="stylesheet" href="HomePage.css" >
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
	type="text/javascript"></script>
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
	

<script>

let url= (window.location.search).substring().split("?")
console.log(url);
let search =  "https://www.googleapis.com/books/v1/volumes/"+url[1]
let previous = url[2];

var arr = window.location.href;
var autharr = arr.split("auth=");
var auth = autharr[1];

$(document).ready(function() {


	if(auth==null || auth.length!=64)
	{
		document.getElementById("profile").style="display: none";
	}else{
		document.getElementById("profile").style="display: flex";
		document.getElementById("hiddenAuth").value=auth;
	}

	
	
	$.ajax({
        type: 'GET',
        url: search,
        contentType: "application/json"
    }).done(function(data) {
		saved = JSON.parse(JSON.stringify(data))
    	let isbn13 = ""
		let rating = saved.volumeInfo.averageRating !=null ? saved.volumeInfo.averageRating : "N/A"
		let description = saved.volumeInfo.description!=null? saved.volumeInfo.description : "N/A"
		let publisher = saved.volumeInfo.publisher!="" ? saved.volumeInfo.publisher : "N/A"
		let publishedDate = saved.volumeInfo.publishedDate != null ? saved.volumeInfo.publishedDate : "N/A"
				
		let checkedStars = "<span class='fa fa-star checked'></span>"
		let unCheckedStars = "<span class='fa fa-star-o'></span>"
		let halfStar = 	"<span class='fa fa-star-half-o'></span>"
			
		
		let ratingStars = ""
			
		console.log("rating "+rating)
		if(rating != "N/A")
			{
			if(rating==5){
				for(var i=0;i<5;i++) ratingStars+=checkedStars
			}else if(rating==4.5) {
				for(var i=0;i<4;i++) ratingStars+=checkedStars
				ratingStars+=halfStar
			}else if(rating==4){
				for(var i=0;i<4;i++) ratingStars+=checkedStars
				ratingStars+=unCheckedStars
			}else if(rating ==3){
				for(var i=0;i<3;i++) ratingStars+=checkedStars
				ratingStars+=unCheckedStars
				ratingStars+=unCheckedStars
			}else if(rating==3.5){
				for(var i=0;i<3;i++) ratingStars+=checkedStars
				ratingStars+=halfStar
				ratingStars+=unCheckedStars
			}else if(rating==2.5){
				for(var i=0;i<2;i++) ratingStars+=checkedStars
				ratingStars+=halfStar
				ratingStars+=unCheckedStars
				ratingStars+=unCheckedStars
			}else if(rating==2){
				for(var i=0;i<2;i++) ratingStars+=checkedStars
				for(var j=0;j<3;j++) ratingStars+=unCheckedStars
			}else if(rating==1){
				for(var i=0;i<1;i++) ratingStars+=checkedStars
				for(var j=0;j<4;j++) ratingStars+=unCheckedStars
			}else if(rating ==1.5){
				for(var i=0;i<1;i++) ratingStars+=checkedStars
				ratingStars+=halfStar
				for(var j=0;j<3;j++) ratingStars+=unCheckedStars
			}else if(rating==.5 || rating ==0.5){
				ratingStars+=halfStar
				for(var j=0;j<4;j++) ratingStars+=unCheckedStars
			}
			}else{
				for(var j=0;j<5;j++) ratingStars+=unCheckedStars
			}
		
		
		if(saved.volumeInfo.industryIdentifiers!=null){
			saved.volumeInfo.industryIdentifiers.forEach((s)=> 
			{
				if(s.type=="ISBN_13"){
					isbn13=s.identifier
				}
			})
		}else{isbn13="N/A"}
				
		$("#queryList").append('<div class="search_container"><div class="search_left"><a id="link" href="SearchResults.jsp?'+previous+'">'+ '<img class="details_search_image" id="thumbnail" src='+saved.volumeInfo.imageLinks.thumbnail +'alt="" height="82"> </a>' + '<i><h4><b> Rating:</b> '+ ratingStars  +'</i></h4>'+ '<button class="favstyle" id="favbutton" onClick="favoriteBook()" value="Favorite"><span class="starText">&#9733;</span> Favorite</button><button id="delbutton" onClick="deleteBook()" value="Delete" class="favstyle" style="display: none"><span class="starText">&#9733;</span> Remove</button><p id="error" style="display: none">Error: Need to login.</p>' + '</div>'+ '<div class="search_text"><h1 id="title">'+saved.volumeInfo.title+'</h1><i><h2><b> Author: </b><div id="author">'+saved.volumeInfo.authors+"</div></i></h2>" + '<i><h4> <b>Publisher: </b></i>'+publisher +'</h4>' + '<i><h4><b> Published Date: </b></i>'+publishedDate +'</h4>' + '<i><h4> <b>ISBN: </b></i>'+isbn13 +'</h4>'+  "<p> <b>Summary</b>: <div id='summary'>"+description +'</div></p></div><hr></div>')

		console.log(document.getElementById("link"));
		if(previous.substring(0,4)=="auth"){
			document.getElementById("link").href="Profile.jsp?auth="+auth;
			console.log(document.getElementById("link"));
		}
		
	    })
	    
		$.ajax({
		    type: 'POST',
		    url: './FavList',
		    data: JSON.stringify({auth:auth}),
		    contentType: "application/json"
		}).done(function(data) {
			saved = JSON.parse(JSON.stringify(data))
			console.log(saved)
			
			for (var i = 0; i < saved.length; i++) {
			    if((saved[i].id)==(url[1])){
			    	console.log("SAME BOOK")
			    	document.getElementById("delbutton").style="display: flex"
			    	document.getElementById("favbutton").style="display: none"
			    	break;
			    }
			    } 
			    
		})  
	    

})

function favoriteBook(){
	if(auth==null || auth.length!=64)
	{
		document.getElementById("error").style="display: flex";
	}else{
		$.ajax({
	        type: 'POST',
	        url: './Favorite',
	        data: JSON.stringify({ auth : auth, bookid : url[1], thumbnail: document.getElementById("thumbnail").src, title:document.getElementById("title").innerHTML, author: document.getElementById("author").innerHTML, summary : document.getElementById("summary").innerHTML }),
	        contentType: "application/json"
	    }).done(function(data) {
			saved = JSON.parse(JSON.stringify(data))
			console.log(saved)
			console.log("SAME BOOK")
			if(saved=="True"){
				document.getElementById("delbutton").style="display: flex"
			    document.getElementById("favbutton").style="display: none"
			}
	    	
	  })
		
	}
	
}

function deleteBook(){
	if(auth==null || auth.length!=64)
	{
		document.getElementById("error").style="display: flex";
	}else{
		$.ajax({
	        type: 'DELETE',
	        url: './Favorite',
	        data: JSON.stringify({ auth : auth, bookid : url[1]}),
	        contentType: "application/json"
	    }).done(function(data) {
			saved = JSON.parse(JSON.stringify(data))
			console.log(saved)
			console.log("SAME BOOK")
			if(saved=="True"){
				document.getElementById("delbutton").style="display: none"
			    document.getElementById("favbutton").style="display: flex"
			}
	    	
	  })
		
	}
	
	
	
}

function toProfile(){
	
	location.href='Profile.jsp?auth='+auth;
}

function toHome(){
	location.href='HomePage.jsp?auth='+auth;
}

</script>
</head>

<div class="top">
	<div class="logo">
		<a onClick="toHome()" style="cursor:pointer"><img
			src="bookworm.png" /></a>
	</div>
	<form name="myformSearchPage" method=GET
		action="SearchResults.jsp"
		class="containerSearchPage">

		<input type="text" name="book"
			placeholder="Search for your favorite book!" class="searchInput">
		
		<button class = "inputSearch"    type="submit">
				<img class="inputImage" src="magnifying_glass.png"/>
			 </button>
			 
		<div style="margin-left: 20%^">
			<div class="radio2">
				<input type="radio" name="button" value="Name"> Name <br>
				<input type="radio" name="button" value="ISBN"> ISBN
			</div>
			<div class="radio2">
				<input type="radio" name="button" value="Author"> Author<br>
				<input type="radio" name="button" value="Publisher">
				Publisher
			</div>
		</div>
		<input type="text" id="hiddenAuth" name="auth" style="display: none">
		<div class="profilePic" style="display: none; cursor: pointer"id="profile" onclick="toProfile()">
				<img class="profileImage" src="profile.png"/>
		</div>
	</form>
	
</div>
<hr>

<body>
	<div id="queryResult">
		<ol id="queryList" style="list-style-type: circle;"></ol>
	</div>










</body>
</html>