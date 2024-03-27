<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>

<%
    Properties properties = new Properties();
    try {
        String configFilePath = application.getRealPath("/WEB-INF/config.properties");
        properties.load(new FileInputStream(configFilePath));
    } catch (Exception e) {
        e.printStackTrace();
    }
    String host = properties.getProperty("host.url");

    String userID = request.getParameter("id");
    String apiUrl = host + "/api/users/" + userID;
    String userUpdateUrl = host + "/api/users";
%>
<jsp:include page="Common/adminHeader.jsp"/>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <jsp:include page="Common/adminSidebar.jsp"/>
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                <!-- Sidebar Toggle (Topbar) -->

                <jsp:include page="Common/adminNavbar.jsp"/>

                <div class="container-fluid">
                    <h1 class="h3 mb-2 text-gray-800">View User</h1>
                    <p class="mb-4">View and update user details.</p>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <form id="userForm">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName">
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName">
                                </div>
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="username">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email">
                                </div>
                                <div class="form-group">
                                    <label for="role">Role</label>
                                    <input type="text" class="form-control" id="role" name="role">
                                </div>
                                <button type="button" class="btn btn-primary" id="updateButton">Update</button>
                                <button type="button" class="btn btn-danger" id="setStatusInactiveButton"></button>
                            </form>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    <jsp:include page="Common/adminFooter.jsp"/>
</div>
</div>
<jsp:include page="Common/adminFooterScripts.jsp"/>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script>


    var userStatus ;

    $(document).ready(function () {
        // Fetch user details on page load
        fetchUserDetails();

        // Attach event listener to the update button
        $("#updateButton").click(updateUser);

        // Attach event listener to the Set Status Inactive button
        $("#setStatusInactiveButton").click(setStatusInactive);
    });

    function fetchUserDetails() {
        fetch("<%= apiUrl %>")
            .then(response => response.json())
            .then(data => {
                $("#firstName").val(data.firstName);
                $("#lastName").val(data.lastName);
                $("#username").val(data.username);
                $("#email").val(data.email);
                $("#role").val(data.role);
            })
            .catch(error => console.error('Error:', error));
    }

    function updateUser() {
        const userData = {
            "userID": "<%= userID %>",
            "firstName": $("#firstName").val(),
            "lastName": $("#lastName").val(),
            "username": $("#username").val(),
            "email": $("#email").val(),
            "role": $("#role").val()
        };

        fetch("<%= userUpdateUrl %>", {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(userData)
        })
            .then(response => {
                if (response.ok) {
                    alert("User details updated successfully!");
                } else {
                    alert("Failed to update user details!");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("An error occurred while updating user details.");
            });
    }

    function toggleUserStatus() {
        if()
        document.getElementById("setStatusInactiveButton").value("Set Status Inactive");
        const currentStatus = $("#status").val();
        const newStatus = (currentStatus === "Active") ? "Inactive" : "Active";
        setStatus(newStatus);
    }

    function setStatus(status) {
        const userData = {
            "userID": "<%= userID %>",
            "status": status
        };

        const statusUrl = "<%= host %>/api/users/<%= userID %>/status/" + status;

        fetch(statusUrl, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(userData)
        })
            .then(response => {
                if (response.ok) {
                    alert("User status set to " + status + " successfully!");
                } else {
                    alert("Failed to set user status to " + status + "!");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("An error occurred while setting user status to " + status + ".");
            });
    }
</script>

</body>
</html>
