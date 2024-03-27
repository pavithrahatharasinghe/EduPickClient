<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Cookie[] cookies = request.getCookies(); // Get all cookies sent by the client
  if (cookies != null) {
    for (Cookie cookie : cookies) {
      if (cookie.getName().equals("isLoggedIn") ||
              cookie.getName().equals("customer_email") ||
              cookie.getName().equals("admin_email") ||
              cookie.getName().equals("userId") ||
              cookie.getName().equals("fname") ||
              cookie.getName().equals("lName") ||
              cookie.getName().equals("email") ||
              cookie.getName().equals("role") ||
              cookie.getName().equals("status")) {
        cookie.setValue(""); // Clear the cookie by setting its value to an empty string
        response.addCookie(cookie); // Add the updated cookie to the response object
      }
    }
  }
  response.sendRedirect("login.jsp"); // Redirect the user to login.jsp page
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
