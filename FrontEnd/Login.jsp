<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="LoginStyleSheet.css">
</head>
<body onload="updateSpace();">
<div id="container">
	<div id="catagories">
		<div id="vendingLogo">
			<figure class="logo"><a href="Homepage.jsp" style="text-decoration: none"> <img id ="logo" src="logo.png" width="400%" height="200%"></a></figure>
		</div>
			
	</div>
	<div id="searchbox">
		<%
			String username = (String) request.getAttribute("username");
			if(username == null) username = "";
			String loginError = (String) request.getAttribute("loginError");
			if(loginError == null) {
				loginError = "";
			}
		%>
		<form name="login" method="POST" action="LoginValidation">
			<h2 id="usernameText">Username</h2>
			<input class="gimmespace" type="text" name="username" id="usernameid"/>
			<h2 id="passwordText">Password</h2>
			<input class="gimmespace" type="password" name="password" id="passwordid"/>
			<div id="loginError" style="color:red;"><%=loginError %></div>
			<div id="signup"> 
				<input type="submit" name="submit" value="Sign In" id="logbutton"/>
			</div>
		</form>
	</div>
</div>



</body>


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
</html>