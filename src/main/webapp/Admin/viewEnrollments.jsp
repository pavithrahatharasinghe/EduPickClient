<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>

<%
    // Load configuration properties
    Properties properties = new Properties();
    try {
        String configFilePath = application.getRealPath("/WEB-INF/config.properties");
        properties.load(new FileInputStream(configFilePath));
    } catch (Exception e) {
        e.printStackTrace();
    }
    // Assuming you have a host URL defined in your properties file
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

                <jsp:include page="Common/adminNavbar.jsp"/>

                <div class="container-fluid">
                    <h1 class="h3 mb-2 text-gray-800">View User Enrollments</h1>
                    <p class="mb-4">Enrollments for specific course</p>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="enrollmentsTable" width="100%" cellspacing="0">
                                    <thead>
                                    <tr>
                                        <th>Enrollment id</th>
                                        <th>User ID</th>
                                        <th>Course ID</th>
                                        <th>Enrollment Date</th>
                                        <th>Completion Date</th>
                                        <th>Completion Status</th>
                                    </tr>
                                    </thead>
                                    <tbody id="enrollmentsTableBody">
                                    <!-- Enrollments will be displayed here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    </div>
</div>
<jsp:include page="Common/adminFooter.jsp"/>


<jsp:include page="Common/adminFooterScripts.jsp"/>

<script>
    $(document).ready(function () {
        // Fetch enrollments for a specific course
        const courseId = getParameterByName('courseID'); // Assuming you have a function to get query parameters
        if (courseId) {
            fetchEnrollments(courseId);
        }
    });

    function fetchEnrollments(courseId) {
        const apiUrl = '<%= host %>/api/enrollments/Course/' + courseId;

        fetch(apiUrl)
            .then(response => response.json())
            .then(enrollments => {
                $('#enrollmentsTableBody').empty();
                enrollments.forEach(enrollment => {
                    $('#enrollmentsTableBody').append(
                        '<tr>' +
                        '<td>' + enrollment.enrollmentID + '</td>' +
                        '<td>' + enrollment.userID + '</td>' +
                        '<td>' + enrollment.courseID + '</td>' +
                        '<td>' + enrollment.enrollmentDate + '</td>' +
                        '<td>' + enrollment.completionDate + '</td>' +
                        '<td>' + enrollment.completionStatus + '</td>' +
                        '</tr>'
                    );
                });
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to load enrollments.');
            });
    }

    // Function to get query parameter by name
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, '\\$&');
        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }
</script>


</body>
</html>
