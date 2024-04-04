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
<jsp:include page="Common/studentHeader.jsp"/>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">


    <jsp:include page="Common/studentSidebar.jsp"/>
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                <!-- Sidebar Toggle (Topbar) -->

                <jsp:include page="Common/studentNavbar.jsp"/>

                <div class="container-fluid">
                    <h1 class="h3 mb-2 text-gray-800">Enrolled Courses</h1>
                    <p class="mb-4">Overview of all courses you've enrolled.</p>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                    <tr>
                                        <th>Enrollment ID</th>
                                        <th>User ID</th>
                                        <th>Course ID</th>
                                        <th>Enrollment Date</th>
                                        <th>Completion Date</th>
                                        <th>Completion Status</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody id="dataTableBody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    <jsp:include page="Common/studentFooter.jsp"/>
</div>
</div>
<jsp:include page="Common/studentFooterScripts.jsp"/>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script>
    $(document).ready(function () {
        refreshTable();
    });

    function refreshTable() {
        const apiUrl = "<%= host %>/api/enrollments";

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
                let status = "";
                $.each(data, function (index, enrollment) {
                    if (enrollment.completionStatus == 1){
                        status = "Enrolled";
                    }else {
                        status = "Unenrolled";
                    }
                    $('#dataTableBody').append(
                        '<tr>' +
                        '<td>' + enrollment.enrollmentID + '</td>' +
                        '<td>' + enrollment.userID + '</td>' +
                        '<td>' + enrollment.courseID + '</td>' +
                        '<td>' + enrollment.enrollmentDate + '</td>' +
                        '<td>' + enrollment.completionDate + '</td>' +
                        '<td>' + status + '</td>' +
                        '<td>' +
                        '<button class="btn btn-danger" onclick="unenroll(' + enrollment.enrollmentID + ')">Unenroll</button>' +
                        '</td>' +
                        '</tr>'
                    );
                });
            });
    }

    function unenroll(enrollmentID) {
        if (confirm("Are you sure you want to unenroll from this course?")) {
            const deleteUrl = "<%= host %>/api/enrollments/" + enrollmentID;

            fetch(deleteUrl, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(response => {
                    if (response.ok) {
                        alert("Course unenrolled successfully!");
                        refreshTable(); // Refresh the table after deletion
                    } else {
                        alert("Failed to unenroll from course!");
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                    alert("An error occurred while deleting the course.");
                });
        }
    }
</script>

</body>
</html>
