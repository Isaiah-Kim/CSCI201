<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 

<meta charset="UTF-8">
<title>This is the Profile page. </title>
<link href = "HomePage.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

<script>
let url= (window.location.search).substring().split("?")
console.log(url);
let search =  "https://www.googleapis.com/books/v1/volumes/"+url[1]
let previous = url[2];

var arr = window.location.href;
var autharr = arr.split("auth=");
var auth = autharr[1];

$(document).ready(function() {
	//http://localhost:8080/isaiahki_CSCI201L_HW2/Details.jsp?ER_9AgAAQBAJ?book=harry&button=Name&auth=56a1eb711f30b1fef228826e998b3e0dd33e35c192ca65eaf216c1e128e3976a
	
	//http://localhost:8080/isaiahki_CSCI201L_HW2/Details.jsp?ER_9AgAAQBAJundefined
	console.log(auth);
	
	if(auth==null || auth.length!=64)
	{
		document.getElementById("profile").style="display: none";
	}else{
		document.getElementById("profile").style="display: flex";
		document.getElementById("hiddenAuth").value=auth;
	}
	
	
	
		$.ajax({
	        type: 'POST',
	        url: './Profile',
	        data: JSON.stringify({auth: auth}),
	        contentType: "application/json"
	    }).done(function(data) {
			saved = JSON.parse(JSON.stringify(data))
			console.log(saved);
			if(saved==null)
				{
					alert("Error: No Results. Redirecting to HomePage.")
					//window.location.href = '/isaiahki_CSCI201L_HW2//HomePage.jsp'
				}
			else{
				document.getElementById("welcome").innerHTML = saved[0].username+"'s favorites:" 
				
				for(i=1;i<saved.length;i++){
					$("#queryList").append('<div id='+saved[i].bookid+'><div class="search_container"><hr><div class="search_left"><a href="Details.jsp?' +saved[i].bookid+'?auth='+ auth +'"><img class = "search_image" src='+saved[i].thumbnail +'alt="" height="82"> </a> </div>' + '<div class="search_text"> <h2>'+saved[i].title+'</h2>'+'<h3><i>'+saved[i].author+"</i></h3><p> <b>Summary: </b>"+saved[i].summary +'</p> <button class="favstyleProfile" id="delbutton" onClick="deleteBook(value)" value='+saved[i].bookid+'><span class="starText">&#9733;</span> Remove</button></div></div> <div style="display=hidden" id="bookid" value=saved[i].bookid></div><hr></div>');
				}
			}
			
			
	    })
	
});


function deleteBook(event){
	var id = event;
	console.log(id);
	if(auth==null || auth.length!=64)
	{
		document.getElementById("error").style="display: flex";
	}else{
		$.ajax({
	        type: 'DELETE',
	        url: './Favorite',
	        data: JSON.stringify({ auth : auth, bookid : id}),
	        contentType: "application/json"
	    }).done(function(data) {
			saved = JSON.parse(JSON.stringify(data))
			console.log(saved)
			console.log("SAME BOOK")
			if(saved=="True"){
			    var elem = document.getElementById(id);
				elem.parentNode.removeChild(elem);
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
		<h1 id="welcome">  </h1>
	</div>
	
	
	<div id="queryResult"> 
			
            <ol id="queryList" style="list-style-type:circle;"></ol>
        </div>
	
</body>
</html>