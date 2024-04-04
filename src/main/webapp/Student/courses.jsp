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
                        '<button class="btn btn-warning" onclick="enrollCourse(' + course.courseID + ')">Enroll</button>' +
                        '</td>' +
                        '</tr>'
                    );
                });
            });
    }

    function viewCourse(courseID) {
        window.location.href = 'viewCourse.jsp?courseID=' + courseID; // Correct redirection with courseID as a parameter
    }

    async function enrollCourse(courseID) {
        if (confirm("Are you sure you want to enroll to this course?")) {
            const enrollmentDate = new Date();
            const completionDate = new Date(enrollmentDate.getFullYear() + 4, enrollmentDate.getMonth(), enrollmentDate.getDate());

            const formData = {
                userID: 1,
                courseID: courseID,
                enrollmentDate: enrollmentDate.toISOString().split('T')[0],
                completionDate: completionDate.toISOString().split('T')[0],
                completionStatus: 1 // 1-Enrolled , 0-Unenrolled
            };

            const enrollUrl = "<%= host %>/api/enrollments";
            try {
                const response = await fetch(enrollUrl, {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(formData)
                });
                if (response.ok) {
                    alert("Enrolled to course successfully!");
                    refreshTable();
                } else {
                    alert("Failed to enroll to course!");
                    refreshTable();
                }
            } catch (error) {
                console.error("Error:", error);
            }

            refreshTable();
        }
    }
</script>

</body>
</html>
