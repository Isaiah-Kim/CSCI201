<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HomePage</title>
<link rel="stylesheet" href="HomePage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

<script>
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
	
</script>


</head>
<body>

	<div class="headerHome">
		<img src="bookworm.png" width=150 height=100 />
		
		<div class="loginRegister" id="authenticated">
			<a class="link" href="Login.jsp">Login</a>
			<a class="link" href="Register.jsp">Register</a>
		</div>
		
		<div class="profile" id="profile">
			<a class="link" style="cursor: pointer" onClick="toProfile()">Profile</a>
			<a class="link" href="HomePage.jsp">Log Out</a>
		</div>
	</div>
	<div class="bg-img">
		
		
		<form name="myform" method=GET action="SearchResults.jsp"
			class="container">
			<div class="middle">BookWorm: Just a Mini Program... Happy Days!</div>
			<input class="mainInput" type="text" name="book"
				placeholder="Search for your favorite book!"> <br> <br>
			
		
				<div class="radio3">
				<input type="radio" name="button" value="Name"> Name <br>
				<input type="radio" name="button" value="ISBN"> ISBN 
				</div>
				<div class="radio3">
				<input  type="radio" name="button" value="Author"> Author<br>
				<input  type="radio" name="button" value="Publisher"> Publisher 
				</div>
				
				<input type="text" id="hiddenAuth" name="auth" style="display: none">

				<input class="inputHome" type="submit" value="Search!">


		</form>

	</div>

</body>

</html>