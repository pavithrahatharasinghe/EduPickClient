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
                    <h1 class="h3 mb-2 text-gray-800">Submitted Assignments</h1>
                    <p class="mb-4">Overview of all assignments submitted.</p>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                    <tr>
                                        <th>Assignment ID</th>
                                        <th>Module ID</th>
                                        <th>Course ID</th>
                                        <th>Assignment Name</th>
                                        <th>Description</th>
                                        <th>URL</th>
                                        <th>Type</th>
                                        <th>Status</th>
                                        <th>Due Date/Time</th>
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
    const addAssignmentUrl = "http://localhost:8080/EduPickRest_war_exploded/api/assignments";
    refreshTable();
    // $(document).ready(async function () {
    //     const formData = {
    //         moduleID: moduleID,
    //         courseID: courseID,
    //         assignmentName: $('#assignmentName').val(),
    //         assignmentDescription: $('#assignmentDescription').val(),
    //         assignmentURL: $('#assignmentURL').val(),
    //         assignmentType: $('#assignmentType').val(),
    //         assignmentStatus: $('#assignmentStatus').val(),
    //         dueDateTime: $('#dueDateTime').val()
    //     };
    //
    //     console.log(formData);
    //
    //     try {
    //         const response = await fetch(addAssignmentUrl, {
    //             method: "POST",
    //             headers: {"Content-Type": "application/json"},
    //             body: JSON.stringify(formData)
    //         });
    //         if (response.ok) {
    //             alert("Assignment added successfully!");
    //             refreshTable();
    //             // You can redirect or do other actions here upon successful addition
    //         } else {
    //             alert("Failed to add assignment!");
    //             refreshTable();
    //         }
    //     } catch (error) {
    //         console.error("Error:", error);
    //     }
    //
    //     refreshTable();
    // });

    // Function to refresh the assignments table
    function refreshTable() {
        const url = 'http://localhost:8080/EduPickRest_war_exploded/api/assignments';
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
                $('#dataTableBody').empty();
                $.each(data, function (index, assignment) {
                    const row = '<tr>' +
                        '<td>' + assignment.assignmentID + '</td>' +
                        '<td>' + assignment.moduleID + '</td>' +
                        '<td>' + assignment.courseID + '</td>' +
                        '<td>' + assignment.assignmentName + '</td>' +
                        '<td>' + assignment.assignmentDescription + '</td>' +
                        '<td>' + assignment.assignmentURL + '</td>' +
                        '<td>' + assignment.assignmentType + '</td>' +
                        '<td>' + assignment.assignmentStatus + '</td>' +
                        '<td>' + assignment.dueDateTime + '</td>' +
                        '<td>' +
                        '<button type="button" class="btn btn-danger btn-delete">Delete</button>' +
                        '</td>' +
                        '</tr>';
                    $('#dataTableBody').append(row);
                });
            })
            .catch(error => console.error(error));
    }
</script>

</body>
</html>
