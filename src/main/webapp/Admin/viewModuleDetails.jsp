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
                    <h1 class="h3 mb-2 text-gray-800">View Course Modules</h1>

                    <!-- Layout for left and right columns -->
                    <div class="d-flex">
                        <!-- Left column for course details -->
                        <div class="container mt-5 flex-fill mr-2">
                            <form id="updateCourseForm">
                                <!-- Hidden field for the course ID -->
                                <input type="hidden" id="courseId" name="courseId">


                                <div class="form-group">
                                    <label for="moduleName">Module Name</label>
                                    <input type="text" class="form-control" id="moduleName" name="moduleName" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="moduleDescription">Module Description</label>
                                    <textarea class="form-control" id="moduleDescription" name="moduleDescription" rows="3" readonly></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="moduleURL">Module URL</label>
                                    <input type="text" class="form-control" id="moduleURL" name="moduleURL" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="moduleStatus">Module Status</label>
                                    <input type="text" class="form-control" id="moduleStatus" name="moduleStatus" readonly>
                                </div>


                                <button type="submit" class="btn btn-primary">Update Course</button>
                            </form>
                        </div>

                        <!-- Right column for clickable cards -->
                        <div class="container mt-5 flex-fill ml-2">
                            <div class="row">
                                <!-- Each card represents a link to different sections -->

                                <div class="col-md-6 mb-4">
                                    <div class="card h-100" onclick="window.location.href='viewAssignments.jsp?courseID=<%=request.getParameter("courseID")%>';" style="cursor:pointer;">
                                        <div class="card-body">
                                            <h5 class="card-title">Assignments</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <div class="card h-100" onclick="window.location.href='viewExams.jsp?courseID=<%=request.getParameter("courseID")%>';" style="cursor:pointer;">
                                        <div class="card-body">
                                            <h5 class="card-title">Exams</h5>
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
        const ModuleID = queryParams.get('ModuleID');
        if (ModuleID) {
            fetchCourseDetails(ModuleID);
        }
    });

    function fetchCourseDetails(ModuleID) {
        const apiUrl = "http://localhost:8080/EduPickRest_war_exploded/api/modules/" + ModuleID;

        fetch(apiUrl)
            .then(response => response.json())
            .then(module => {

                $('#moduleName').val(module.moduleName);
                $('#moduleDescription').val(module.moduleDescription);
                $('#moduleURL').val(module.moduleURL);
                $('#moduleStatus').val(module.moduleStatus);


            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to load course details.');
            });
    }

    $('#updateModuleForm').submit(function(event) {
        event.preventDefault();

        const updateModuleData = {
            // Assume you have inputs for each of these fields in your form
            courseName: $('#courseName').val(),
            // Add other fields here
        };

        const updateUrl = "http://localhost:8080/EduPickRest_war_exploded/api/modules/" + moduleID; // Use the courseID from the URL or a hidden input field

        fetch(updateUrl, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(updateModuleData),
        })
            .then(response => {
                if (response.ok) {
                    alert('Module updated successfully.');
                    // Optionally, redirect or refresh
                } else {
                    alert('Failed to update module.');
                }
            })
            .catch(error => {
                console.error('Error updating module:', error);
                alert('An error occurred while updating the module.');
            });
    });

</script>

</body>
</html>



