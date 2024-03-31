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
                    <h1 class="h3 mb-2 text-gray-800">View Courses</h1>
                    <p class="mb-4">Overview of all courses available in the system.</p>

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
</div>
<jsp:include page="Common/adminFooter.jsp"/>

<jsp:include page="Common/adminFooterScripts.jsp"/>

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
                        '<button class="btn btn-danger" onclick="deleteCourse(' + course.courseID + ')">Delete</button>' +
                        '</td>' +
                        '</tr>'
                    );
                });
            });
    }

    function viewCourse(courseID) {
        window.location.href = 'viewCourse.jsp?courseID=' + courseID; // Correct redirection with courseID as a parameter
    }


    function deleteCourse(courseID) {
        if (confirm("Are you sure you want to delete this course?")) {
            const deleteUrl = "<%= host %>/api/courses/" + courseID;

            fetch(deleteUrl, {
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

    function updateCourse(courseID) {
        // Here, fetch the course details from the API by the courseID
        // and then fill the modal inputs with those details.
        const courseUrl = "<%= host %>/api/courses/" + courseID;

        fetch(courseUrl)
            .then(response => response.json())
            .then(course => {
                $('#updateCourseId').val(course.courseID);
                $('#updateCourseName').val(course.courseName);
                $('#updateCourseDescription').val(course.courseDescription);
                // Fill other fields as necessary

                $('#updateCourseModal').modal('show');
            })
            .catch(error => {
                console.error('Error fetching course details:', error);
                alert('Could not fetch course details for editing.');
            });
    }

    $('#updateCourseForm').submit(function (event) {
        event.preventDefault(); // Prevent the default form submission

        const courseID = $('#updateCourseId').val(); // Assuming you have a hidden input for courseID
        const updateUrl = "<%= host %>/api/courses/" + courseID;

        const updatedCourseData = {
            courseName: $('#updateCourseName').val(),
            courseDescription: $('#updateCourseDescription').val(),
            // Add other fields as necessary
        };

        fetch(updateUrl, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(updatedCourseData),
        })
            .then(response => {
                if (response.ok) {
                    $('#updateCourseModal').modal('hide');
                    alert('Course updated successfully!');
                    refreshTable(); // Refresh the table to show the updated details
                } else {
                    alert('Failed to update course.');
                }
            })
            .catch(error => {
                console.error('Error updating course:', error);
                alert('An error occurred while updating the course.');
            });
    });


</script>

</body>
</html>
