<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Register</title>
	<link rel="stylesheet" href="HomePage.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
</head>

<body>

<div class = "top">
	<div class = "logo">
		<a href="HomePage.jsp"><img src="bookworm.png"/></a>
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
			
		</form>
</div>
		<hr>

<div id="login-form" class="registerPage">
            <div id="content" class="divcontent">
            <form id="applyform">
            	<div class="userLogin" id="usernamediv">
            		Username <input type="text" class="loginText" name="username" id="username">
            	</div>
                <div class="userLogin" id="passworddiv">
                	Password <input type="password" class="loginText" name="password" id="password">
                </div>
                <div class="userLogin" id="confirmpassworddiv">
                	Confirm Password <input type="password" class="loginText" name="confirmpassword" id="confirmpassword">
                </div>          
                
                <div id = "alignButton"><button id = "login" class="loginButton" type="submit">Register</button> </div> 
                <div id = "list" class="listLogin" name = "list"> </div>
            </form>
            
            	
            	
            	
            </div>
    </div>

</body>

<script>

var form = document.getElementById('applyform');
form.addEventListener('submit', validateform);

function validateform(e) { 
    e.preventDefault(); 
    if (document.getElementById('password').value!=document.getElementById('confirmpassword').value) {
    	document.getElementById("list").innerHTML = "Password do not match."
    } else {
    	 var obj = {}
    	    obj.username=document.getElementById('username').value
    	    obj.password=document.getElementById('password').value
    	    $.ajax({
    	        type: 'POST',
    	        url: './Register',
    	        data: JSON.stringify(obj),
    	        contentType: "application/json"
    	    })
    	    .done(function(data) {
    	    	var split = data.split('+');
    	    	console.log(split[0]);
    	        var s = split[0];
    	    	if(s=="Success"){
    	        	window.location.href = 'HomePage.jsp?auth='+split[1];
    	        }else{
    	        	document.getElementById("list").innerHTML = data;
    	        }
    	        
    	    })
    	    .fail(function(data) {
    	        console.log(data);
    	    });
    	
        
    }
    
   
}





</script>


