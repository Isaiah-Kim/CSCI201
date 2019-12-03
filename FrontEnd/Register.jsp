  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Signup Page</title>
<link rel="stylesheet" type="text/css" href="RegisterStyleSheet.css">
</head>

<body onload="updatefields();">
	<div id="container">
		<div id="catagories">
			<div id="vendingLogo">
				<figure class="logo"><a href="Homepage.jsp" style="text-decoration: none"> <img id ="logo" src="logo.png" width="400%" height="200%"></a></figure>
			</div>		
		</div>
		<div id="searchbox">
			<%
				String registerError = (String) request.getAttribute("registerError");
				if(registerError == null) registerError = "";
				String username = (String) request.getAttribute("username");
				if(username == null) username = "";
			
			%>
			<form name="signup" method="POST" action="SingupValidation">
				<h2 id="usernameText">Username</h2>
				<input class="gimmespace" type="text" name="username" id="usernameid"/>
				<h2 id="passwordText">Password</h2>
				<input class="gimmespace" type="password" name="password" id="passwordid"/>
				<h2 id="confirmPass">Confirm Password</h2>
				<input class="gimmespace" type="password" name="confirmpassword" id="confirmPassid"/>
				<div id="registerError" style="color:red;"><%=registerError %></div>	
				<div id="signup"> 
					<input type="submit" name="submit" value="Register" id="signupButton"/>
				</div>
			</form>
		</div> <!-- end of search box -->
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<script>
<%
/* What the username was */
String olduser = request.getParameter("username");
%>
//Updates the form fields to keep the values used previously
function updatefields() {	
	if ("<%= olduser %>" != "null"){
		document.querySelector("#usernameid").value = "<%= olduser %>";	
	}
} /* end of function */
</script>
</body>
</html>