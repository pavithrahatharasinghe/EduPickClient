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
                    <h1 class="h3 mb-2 text-gray-800">Students</h1>
                    <p class="mb-4">Overview of all students registered in the system.</p>

                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Students List</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                    <tr>
                                        <th>User ID</th>
                                        <th>Name</th>
                                        <th>Username</th>
                                        <th>E-Mail</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody id="dataTableBody">
                                    </tbody>
                                </table>
                                <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

                                <script>
                                    $(document).ready(function () {
                                        refreshTable();
                                    });

                                    function refreshTable() {
                                        const apiUrl = "<%= host %>/api/users/usetype/student";

                                        const options = {
                                            method: 'GET',
                                            headers: {
                                                'Content-Type': 'application/json'
                                            }
                                        };

                                        fetch(apiUrl, options)
                                            .then(response => response.json())
                                            .then(data => {
                                                console.log(data);
                                                $('#dataTableBody').empty();
                                                $.each(data, function (index, user) {
                                                    $('#dataTableBody').append(
                                                        '<tr>' +
                                                        '<td>' + user.userID + '</td>' +
                                                        '<td>' + user.firstName + ' ' + user.middleName + ' ' + user.lastName + '</td>' +
                                                        '<td>' + user.username + '</td>' +
                                                        '<td>' + user.email + '</td>' +
                                                        '<td>' + user.status + '</td>' +
                                                        '<td>' +
                                                        '<button class="btn btn-primary" onclick="viewStudent(' + user.userID + ')">View</button>' +
                                                        '<button class="btn btn-danger" onclick="deleteStudent(' + user.userID + ')">Delete</button>' +
                                                        '</td>' +
                                                        '</tr>'
                                                    );
                                                });
                                            });

                                    }

                                    viewStudent = function viewStudent(id) {
                                        window.location.href = "viewUser.jsp?id=" + id;
                                    }

                                    function deleteStudent(id) {
                                        if (confirm("Are you sure you want to delete this student?")) {
                                            const deleteUrl = "<%= host %>/api/users/" + id;

                                            fetch(deleteUrl, {
                                                method: 'DELETE',
                                                headers: {
                                                    'Content-Type': 'application/json'
                                                }
                                            })
                                                .then(response => {
                                                    if (response.ok) {
                                                        alert("Student deleted successfully!");
                                                        refreshTable(); // Refresh the table after deletion
                                                    } else {
                                                        alert("Failed to delete student!");
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error("Error:", error);
                                                    alert("An error occurred while deleting the student.");
                                                });
                                        }
                                    }

                                </script>
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


</body>
</html>
