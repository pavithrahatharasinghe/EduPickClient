<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../assets/img/favicon.ico">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>Admin Login</title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!-- Fonts and icons -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
  <!-- CSS Files -->
  <link href="../assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="../assets/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
  <!-- CSS Just for demo purpose, don't include it in your project -->
  <link href="../assets/css/demo.css" rel="stylesheet" />


  <meta charset="utf-8"/>
  <script src="assets/js/core/jquery.3.2.1.min.js"></script>
  <script src="assets/js/core/bootstrap.min.js"></script>
  <script src="assets/js/core/popper.min.js"></script>
  <script src="assets/js/plugins/bootstrap-notify.js"></script>
  <script src="assets/js/plugins/bootstrap-datepicker.js"></script>
  <script src="assets/js/plugins/bootstrap-switch.js"></script>


  <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/core.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/md5.js"></script>

  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-notify/0.2.0/js/bootstrap-notify.js"></script>


  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
        name='viewport'/>
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet"/>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"/>
  <!-- CSS Files -->
  <link href="assets/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="assets/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet"/>
  <!-- CSS Just for demo purpose, don't include it in your project -->
  <link href="assets/css/demo.css" rel="stylesheet"/>
  <!-- Include jQuery from a CDN -->




  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Arial', sans-serif;
    }

    .card {
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      border: none;
      border-radius: 5px;
    }

    .btn-primary {
      background-color: #AF9700;
      border-color: #AF9700;
      color: #ffffff;
    }

    .btn-primary:hover {
      background-color: #AF9100;
      border-color: #AF9100;
      color: #ffffff;
    }

    .login-form {
      max-width: 400px;
      margin: 50px auto;
    }

    .login-container {
      display: flex;
      align-items: center;
    }

    .login-image {
      flex: 1;
      padding: 20px;
    }

    .login-image img {
      max-width: 100%;
      height: auto;
    }

    .login-form-container {
      flex: 1;
    }
  </style>
</head>

<body>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="shortcut icon" href="assets/img/favicon.png" type="image/png">
  <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/css/swiper-bundle.min.css">
  <link rel="stylesheet" href="assets/css/styles.css">

  <title>Financial Insights</title>
</head>

<body>
<header class="header" id="header">
  <nav class="nav container">
    <a href="#" class="nav__logo">EduPick</a>
    <div class="nav__menu" id="nav-menu">
      <ul class="nav__list">
        <li class="nav__item"><a href="#courses" class="nav__link active-link">Courses</a></li>
        <li class="nav__item"><a href="#instructors" class="nav__link">Instructors</a></li>
        <li class="nav__item"><a href="#about" class="nav__link">About Us</a></li>
        <li class="nav__item"><a href="login.jsp" class="nav__link">Login/Signup</a></li>
      </ul>
      <i class="ri-close-line nav__close" id="nav-close"></i>
    </div>
    <div class="nav__toggle" id="nav-toggle"><i class="ri-function-line"></i></div>
  </nav>
</header>
