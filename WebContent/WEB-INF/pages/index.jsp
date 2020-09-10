<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DangerInfo</title>
    <!-- Main styles (bootstrap included) -->
    <link rel="stylesheet" href="./css/styles.css" />
    <!-- Font Awesome icons-->
    <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"></script>
    <link rel="shortcut icon" href="#">
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
</head>

<body id="page-top">
    <header class="hero">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="hero-subheading">Danger Info</div>
                    <div class="hero-heading text-uppercase">Keep in touch with dangers near you</div>
                </div>
                <div class="col-md-6">
                    <div class="containter bg-light">
                        <div class="text-center">
                            <h2 class="section-heading text-uppercase">Login</h2>
                        </div>
                        <form id="loginForm" name="login" action="?action=login" method="POST">
                            <div class="row justify-content-center">
                                <div class="col-10">
                                    <div class="form-group">
                                        <input class="form-control" id="username" type="text" placeholder="Username"
                                            required="required" name="username"
                                            data-validation-required-message="Please enter username." />
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                            </div>
                            <div class="row justify-content-center">
                                <div class="col-10">
                                    <div class="form-group">
                                        <input class="form-control" id="password" type="password" placeholder="Password"
                                            required="required" name="password"
                                            data-validation-required-message="Please enter your password." />
                                        <p class="help-block text-danger"></p>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center">
                                <div id="success"></div>
                                <button class="btn btn-primary btn-xl text-uppercase" id="loginButton"
                                    type="submit">Login</button>
                            </div>
                        </form>
                        <div class="text-center">Need an account?<a href="?action=register">Register</a> now</div>
                    </div>
                </div>
            </div>
        </div>
    </header>
</body>

</html>