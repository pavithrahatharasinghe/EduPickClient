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
                    <h1 class="h3 mb-2 text-gray-800">All Courses</h1>
                    <p class="mb-4">Overview of all courses available in the institute.</p>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                    <tr>
                                        <th>Course ID</th>
                                        <th>Name</th>
                                        <th>Description</th>
                                        <th>Duration (weeks)</th>
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
        const apiUrl = "<%= host %>/api/courses";

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
                $.each(data, function (index, course) {
                    $('#dataTableBody').append(
                        '<tr>' +
                        '<td>' + course.courseID + '</td>' +
                        '<td>' + course.courseName + '</td>' +
                        '<td>' + course.courseDescription + '</td>' +
                        '<td>' + course.courseDuration + '</td>' +
                        '<td>' +
                        '<button class="btn btn-primary" onclick="viewCourse(' + course.courseID + ')">View</button>' +
                        '<button class="btn btn-danger" onclick="enrollCourse(' + course.courseID + ')">Enroll</button>' +
                        '</td>' +
                        '</tr>'
                    );
                });
            });
    }

    function viewCourse(courseID) {
        // You can implement view functionality here
        alert('Viewing course with ID: ' + courseID);
    }

    function enrollCourse(courseID) {
        if (confirm("Are you sure you want to enroll to this course?")) {
            const enrollUrl = "<%= host %>/api/courses/" + courseID;

            fetch(enrollUrl, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(response => {
                    if (response.ok) {
                        alert("Course deleted successfully!");
                        refreshTable(); // Refresh the table after deletion
                    } else {
                        alert("Failed to delete course!");
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
