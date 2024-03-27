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
    String apiUrl = properties.getProperty("api.url"); // Assuming you have this or similar setup for your API base URL
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
                    <h1 class="h3 mb-2 text-gray-800">Add New Course</h1>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <form id="addCourseForm">
                                <div class="form-group">
                                    <label for="courseName">Course Name</label>
                                    <input type="text" class="form-control" id="courseName" name="courseName" placeholder="Enter Course Name" required>
                                </div>
                                <div class="form-group">
                                    <label for="courseDescription">Course Description</label>
                                    <textarea class="form-control" id="courseDescription" name="courseDescription" placeholder="Enter Course Description" required></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="courseImage">Course Image URL</label>
                                    <input type="text" class="form-control" id="courseImage" name="courseImage" placeholder="Enter Course Image URL" required>
                                </div>
                                <div class="form-group">
                                    <label for="courseCategory">Course Category</label>
                                    <input type="text" class="form-control" id="courseCategory" name="courseCategory" placeholder="Enter Course Category" required>
                                </div>
                                <div class="form-group">
                                    <label for="courseLevel">Course Level</label>
                                    <input type="text" class="form-control" id="courseLevel" name="courseLevel" placeholder="Enter Course Level" required>
                                </div>
                                <div class="form-group">
                                    <label for="courseLanguage">Course Language</label>
                                    <input type="text" class="form-control" id="courseLanguage" name="courseLanguage" placeholder="Enter Course Language" required>
                                </div>
                                <div class="form-group">
                                    <label for="coursePrice">Course Price</label>
                                    <input type="number" class="form-control" id="coursePrice" name="coursePrice" placeholder="Enter Course Price" required>
                                </div>
                                <div class="form-group">
                                    <label for="courseURL">Course URL</label>
                                    <input type="text" class="form-control" id="courseURL" name="courseURL" placeholder="Enter Course URL" required>
                                </div>
                                <div class="form-group">
                                    <label for="courseDuration">Course Duration (in weeks)</label>
                                    <input type="number" class="form-control" id="courseDuration" name="courseDuration" placeholder="Enter Course Duration" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Add Course</button>
                            </form>
                        </div>
                    </div>

                </div>
        </div>
        <jsp:include page="Common/adminFooter.jsp"/>
    </div>
</div>
</div>
<jsp:include page="Common/adminFooterScripts.jsp"/>

<script>
    const addCourseUrl = "http://localhost:8080/EduPickRest_war_exploded/api/courses";

    $(document).ready(function() {
        $('#addCourseForm').submit(async function(event) {
            event.preventDefault();

            const formData = {
                courseName: $('#courseName').val(),
                courseDescription: $('#courseDescription').val(),
                courseImage: $('#courseImage').val(),
                courseCategory: $('#courseCategory').val(),
                courseLevel: $('#courseLevel').val(),
                courseLanguage: $('#courseLanguage').val(),
                coursePrice: parseFloat($('#coursePrice').val()),
                courseURL: $('#courseURL').val(),
                courseDuration: $('#courseDuration').val()
            };

            try {
                const response = await fetch(addCourseUrl, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(formData)
                });
                if (response.ok) {
                    alert("Course added successfully!");
                    // You can redirect or do other actions here upon successful addition
                } else {
                    alert("Failed to add course!");
                }
            } catch (error) {
                console.error("Error:", error);
            }
        });
    });
</script>


</body>
</html>

