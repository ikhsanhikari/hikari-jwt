<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Hikari Learning</title>
        <link rel="icon" type="image/png" href="resources/img/favicon.png"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="resources/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
        <link href="resources/css/font-awesome.css" rel="stylesheet">
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
        <link href="resources/css/style.css" rel="stylesheet" type="text/css">
        <link href="resources/css/pages/signin.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="login">
                        Hikari Learning				
                    </a>
                    <div class="nav-collapse">
                        <ul class="nav pull-right">
                            <li class="">
                                <a href="signup" class="">
                                    Don't have an account?
                                </a>
                            </li>
                            <li class="">
                                <a href="index.html" class="">
                                    <i class="icon-chevron-left"></i> Back to Homepage
                                </a>
                            </li>
                        </ul>
                    </div>
                    <!--/.nav-collapse -->
                </div>
                <!-- /container -->
            </div>
            <!-- /navbar-inner -->
        </div>
        <!-- /navbar -->
        <div class="account-container">
            <div class="content clearfix">
                <h1>Member Login</h1>
                <div class="login-fields">
                    <span id="messageError" style="color: red; font-size: 10px"></span>
                    <div class="field">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" value="" placeholder="Username" class="login username-field" />
                    </div>
                    <div class="field">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" value="" placeholder="Password" class="login password-field" />
                    </div>
                </div>
                <div class="login-actions">
                    <span class="login-checkbox">
                        <input id="Field" name="Field" type="checkbox" class="field login-checkbox" value="First Choice" tabindex="4" />
                        <label class="choice" for="Field">Keep me signed in</label>
                    </span>
                    <button class="button btn btn-success btn-large" id="btnLogin">Sign In</button>
                </div>
            </div>
        </div>
        <div class="login-extra">
            <a href="#">Reset Password</a>
        </div>
        <!-- /login-extra -->
        <script src="resources/js/jquery-1.7.2.min.js"></script>
        <script src="resources/js/bootstrap.js"></script>
        <script src="resources/js/signin.js"></script>
    </body>
    <script>
        var base_url = '/hikari-jwt/';
        $('#btnLogin').click(function () {
            login();
        });
        function login() {
            var username = $('#username').val();
            var password = $('#password').val();

            $('#btnLogin').addClass('loading');

            $.post('users/signin?username=' + username + '&password=' + password, function (data) {
                if (data.code == 200) {
                    localStorage.setItem('token', data.token);
                    $('#btnLogin').removeClass('loading');
                    window.location.href = 'index';
                }
            }).fail(function () {
                $('#btnLogin').removeClass('loading');
                document.querySelector('#messageError').innerHTML = 'invalid username or password'
            })
        }
    </script>
    <style>
        .loading:after {
            overflow: hidden;
            display: inline-block;
            vertical-align: bottom;
            -webkit-animation: ellipsis steps(4,end) 900ms infinite;      
            animation: ellipsis steps(4,end) 900ms infinite;
            content: "\2026"; /* ascii code for the ellipsis character */
            width: 0px;
        }

        @keyframes ellipsis {
            to {
                width: 20px;    
            }
        }

        @-webkit-keyframes ellipsis {
            to {
                width: 20px;    
            }
        }

    </style>
</html>