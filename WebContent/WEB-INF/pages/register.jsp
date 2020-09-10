<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="marko.ip.beans.UserBean" scope="session" />

<%
	Object registerResponseMessage = session.getAttribute("registerResultMessage");
	if(registerResponseMessage == null){
		registerResponseMessage="";
	}
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danger Info</title>
    <link rel="stylesheet" href="css/styles.css" />
</head>

<body class="bg-light">
    <!--Register form-->
    <section class="page-section" id="#register">
        <div class="container justify-content-center align-items-center">
            <div class="text-center">
                <h2 class="section-heading text-uppercase text-primary">Register</h2>
                <h3 class="section-subheading text-muted">Please fill up the form with your info.</h3>
            </div>
            <form id="registerForm" action="?action=registerUser" method="POST">
                <div class=" row justify-content-center form-group">
                    <input class="form-control col-md-6 col-lg-5" id="fname" type="text" placeholder="First Name " name="firstName"
                        required="required"/>
                </div>
                <div class="row justify-content-center form-group">
                    <input class="form-control col-md-6 col-lg-5" id="lname" type="text" placeholder="Last Name " name="lastName"
                        required="required"/>
                </div>
                <div class="form-group row justify-content-center">
                    <input class="form-control col-md-6 col-lg-5" id="username" type="text" placeholder="Username " name="username"
                        required="required"/>
                </div>
                <div class="form-group row justify-content-center">
                    <input class="form-control col-md-6 col-lg-5" id="email" type="email" placeholder="Email " name="email"
                        required="required"/>
                </div>
                <div class="form-group row justify-content-center">
                    <input class="form-control col-md-6 col-lg-5" id="password1" type="password" placeholder="Password " name="password1"
                        required="required"/>
                </div>
                <div class="form-group row justify-content-center">
                    <input class="form-control col-md-6 col-lg-5" id="password2" type="password" placeholder="Repeat Password "
                        name="password2" required="required"/>
                </div>
                <p id="res" class="row help-block justify-content-center text-danger"><%= registerResponseMessage %></p>
                <div class="text-center">
                    <div id="success"></div>
                    <button class="btn btn-primary btn-xl text-uppercase" id="registerButton"
                        type="submit">Register</button>
                </div>
            </form>
            <div class="text-center">Already have an acount? <a href="?action=index">Login</a></div>
        </div>
    </section>
</body>

</html>