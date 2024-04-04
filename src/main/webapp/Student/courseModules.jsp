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
                    <h1 class="h3 mb-2 text-gray-800">Manage Course Modules</h1>

                    <div class="row">
                        <div class="card shadow mb-4">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <tr>
                                            <th>Module ID</th>
                                            <th>Module Name</th>
                                            <th>Module Description</th>
                                            <th>Module URL</th>
                                            <th>Module Status</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody id="moduleTableBody">
                                        <!-- Modules will be displayed here -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- Display Modules Table -->
                </div>
        </div>
        <jsp:include page="Common/studentFooter.jsp"/>
    </div>
</div>
</div>
<jsp:include page="Common/studentFooterScripts.jsp"/>
</body>
</html>
<script>
    //get courseID from URL
    const urlParams = new URLSearchParams(window.location.search);
    const courseID = urlParams.get('courseID');


    $(document).ready(function () {
        // Initial load of modules table
        refreshModuleTable();
    });

    // Function to refresh the modules table
    function refreshModuleTable() {

        const url = 'http://localhost:8080/EduPickRest_war_exploded/api/modules/byCourse/' + courseID;
        const options = {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        };

        fetch(url, options)
            .then(response => response.json())
            .then(data => {
                console.log(data);
                $('#moduleTableBody').empty();
                $.each(data, function (index, module) {
                    const row = '<tr>' +
                        '<td>' + module.moduleID + '</td>' +
                        '<td>' + module.moduleName + '</td>' +
                        '<td>' + module.moduleDescription + '</td>' +
                        '<td>' + module.moduleURL + '</td>' +
                        '<td>' + module.moduleStatus + '</td>' +
                        '<td>' +
                        '<a href="viewModuleDetails.jsp?ModuleID=' + module.moduleID + '" class="btn btn-primary btn-view">View</a>' +
                        // '<a href="courseAssignments.jsp?ModuleID=' + module.moduleID + '&CourseID=' + courseID + '" class="btn btn-secondary btn-view">Assignments</a>' +
                        '</td>' +
                        '</tr>';
                    $('#moduleTableBody').append(row);
                });
            })
            .catch(error => console.error(error));
    }
</script>

