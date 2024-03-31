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

                <jsp:include page="Common/adminNavbar.jsp"/>

                <div class="container-fluid">
                    <h1 class="h3 mb-2 text-gray-800">Manage Courses</h1>
                    <p class="mb-4">Overview of all courses available in the system.</p>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <form id="addCourseForm">
                                <div class="form-group">
                                    <label for="courseName">Course Name</label>
                                    <input type="text" class="form-control" id="courseName" name="courseName"
                                           placeholder="Enter Course Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <textarea class="form-control" id="description" name="description"
                                              placeholder="Enter Course Description" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Add Course</button>
                            </form>
                        </div>
                    </div>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="coursesTable" width="100%" cellspacing="0">
                                    <thead>
                                    <tr>
                                        <th>Course ID</th>
                                        <th>Course Name</th>
                                        <th>Description</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody id="coursesTableBody">
                                    <!-- Course rows will be inserted here dynamically -->
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
        refreshCoursesTable();

        $('#addCourseForm').submit(async function (event) {
            event.preventDefault();

            const formData = {
                courseName: $('#courseName').val(),
                description: $('#description').val()
            };

            try {
                const response = await fetch('<%= host %>/api/courses', {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(formData)
                });
                if (response.ok) {
                    alert("Course added successfully!");
                    refreshCoursesTable();
                } else {
                    alert("Failed to add course!");
                }
            } catch (error) {
                console.error("Error:", error);
            }

            $('#addCourseForm').trigger("reset");
        });
    });

    function refreshCoursesTable() {
        const apiUrl = "<%= host %>/api/courses";

        fetch(apiUrl)
            .then(response => response.json())
            .then(courses => {
                $('#coursesTableBody').empty();
                $.each(courses, function (index, course) {
                    $('#coursesTableBody').append(
                        '<tr>' +
                        '<td>' + course.courseID + '</td>' +
                        '<td>' + course.courseName + '</td>' +
                        '<td>' + course.description + '</td>' +
                        '<td>' +
                        '<button class="btn btn-primary" onclick="editCourse(' + course.courseID + ')">Edit</button>' +
                        '<button class="btn btn-danger" onclick="deleteCourse(' + course.courseID + ')">Delete</button>' +
                        '</td>' +
                        '</tr>'
                    );
                });
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to load courses.');
            });
    }

    function editCourse(courseID) {
        // Redirect to edit course page or show a modal for editing
        window.location.href = 'editCourse.jsp?courseID=' + courseID;
    }

    function deleteCourse(courseID) {
        const confirmation = confirm("Are you sure you want to delete this course?");
        if (confirmation) {
            fetch('<%= host %>/api/courses/' + courseID, {
                method: 'DELETE'
            })
                .then(response => {
                    if (response.ok) {
                        alert("Course deleted successfully!");
                        refreshCoursesTable();
                    } else {
                        alert("Failed to delete course!");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Failed to delete course.');
                });
        }
    }
</script>

</body>
</html>
