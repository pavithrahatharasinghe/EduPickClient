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
    String apiUrl = properties.getProperty("api.url");
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
                    <h1 class="h3 mb-2 text-gray-800">View Course</h1>

                    <!-- Layout for left and right columns -->
                    <div class="d-flex">
                        <!-- Left column for course details -->
                        <div class="container mt-5 flex-fill mr-2">
                            <form id="updateCourseForm">
                                <!-- Hidden field for the course ID -->
                                <input type="hidden" id="courseId" name="courseId">

                                <div class="form-group">
                                    <label for="courseName">Name</label>
                                    <input type="text" class="form-control" id="courseName" name="courseName" required>
                                </div>

                                <div class="form-group">
                                    <label for="courseDescription">Description</label>
                                    <textarea class="form-control" id="courseDescription" name="courseDescription"
                                              rows="3" required></textarea>
                                </div>

                                <%--       courseImage--%>
                                <div class="form-group">
                                    <label for="courseImage">Image</label>
                                    <input type="text" class="form-control" id="courseImage" name="courseImage"
                                           required>
                                </div>
                                <%--        courseCategory--%>
                                <div class="form-group">
                                    <label for="courseCategory">Category</label>
                                    <input type="text" class="form-control" id="courseCategory" name="courseCategory"
                                           required>
                                </div>

                                <%--        courseLevel--%>
                                <div class="form-group">
                                    <label for="courseLevel">Level</label>
                                    <input type="text" class="form-control" id="courseLevel" name="courseLevel"
                                           required>
                                </div>
                                <%--        courseLanguage--%>
                                <div class="form-group">
                                    <label for="courseLanguage">Language</label>
                                    <input type="text" class="form-control" id="courseLanguage" name="courseLanguage"
                                           required>
                                </div>
                                <%--        coursePrice--%>
                                <div class="form-group">
                                    <label for="coursePrice">Price</label>
                                    <input type="number" class="form-control" id="coursePrice" name="coursePrice"
                                           required>
                                </div>
                                <%--        courseURL--%>
                                <div class="form-group">
                                    <label for="courseURL">URL</label>
                                    <input type="text" class="form-control" id="courseURL" name="courseURL" required>
                                </div>
                                <%--        courseDuration--%>
                                <div class="form-group">
                                    <label for="courseDuration">Duration</label>
                                    <input type="number" class="form-control" id="courseDuration" name="courseDuration"
                                           required>
                                </div>

                                <button type="submit" class="btn btn-primary">Update Course</button>
                            </form>
                        </div>

                        <!-- Right column for clickable cards -->
                        <div class="container mt-5 flex-fill ml-2">
                            <div class="row">
                                <!-- Each card represents a link to different sections -->
                                <div class="col-md-12 mb-4">
                                    <div class="card h-100"
                                         onclick="window.location.href='courseModules.jsp?courseID=<%=request.getParameter("courseID")%>';"
                                         style="cursor:pointer;">
                                        <div class="card-body">
                                            <h5 class="card-title">Modules</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 mb-4">
                                    <div class="card h-100"
                                         onclick="window.location.href='courseMaterials.jsp?courseID=<%=request.getParameter("courseID")%>';"
                                         style="cursor:pointer;">
                                        <div class="card-body">
                                            <h5 class="card-title">Course Materials</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 mb-4">
                                    <div class="card h-100"
                                         onclick="window.location.href='viewEnrollments.jsp?courseID=<%=request.getParameter("courseID")%>';"
                                         style="cursor:pointer;">
                                        <div class="card-body">
                                            <h5 class="card-title">User Enrollments</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <jsp:include page="Common/adminFooter.jsp"/>
    </div>
</div>
</div>
<jsp:include page="Common/adminFooterScripts.jsp"/>

<script>
    $(document).ready(function () {
        const queryParams = new URLSearchParams(window.location.search);
        const courseID = queryParams.get('courseID');
        if (courseID) {
            fetchCourseDetails(courseID);
        }
    });

    function fetchCourseDetails(courseID) {
        const apiUrl = "http://localhost:8080/EduPickRest_war_exploded/api/courses/" + courseID;

        fetch(apiUrl)
            .then(response => response.json())
            .then(course => {
                $('#courseName').val(course.courseName);
                $('#courseDescription').val(course.courseDescription);
                $('#courseImage').val(course.courseImage);
                $('#courseCategory').val(course.courseCategory);
                $('#courseLevel').val(course.courseLevel);
                $('#courseLanguage').val(course.courseLanguage);
                $('#coursePrice').val(course.coursePrice);
                $('#courseURL').val(course.courseURL);
                $('#courseDuration').val(course.courseDuration);

            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to load course details.');
            });
    }

    $('#updateCourseForm').submit(function (event) {
        event.preventDefault();

        const updatedCourseData = {
            // Assume you have inputs for each of these fields in your form
            courseName: $('#courseName').val(),
            // Add other fields here
        };

        const updateUrl = "http://localhost:8080/EduPickRest_war_exploded/api/courses/" + courseID; // Use the courseID from the URL or a hidden input field

        fetch(updateUrl, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(updatedCourseData),
        })
            .then(response => {
                if (response.ok) {
                    alert('Course updated successfully!');
                    // Optionally, redirect or refresh
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



