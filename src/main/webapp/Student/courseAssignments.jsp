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
                    <h1 class="h3 mb-2 text-gray-800">Manage Assignments</h1>

                    <div class="row">
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
                                            <th>Assignment Description</th>
                                            <th>Assignment URL</th>
                                            <th>Assignment Type</th>
                                            <th>Assignment Status</th>
                                            <th>Due Date and Time</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody id="assignmentTableBody">
                                        <!-- Assignments will be displayed here -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- Display Assignments Table -->


                </div>
        </div>
        <jsp:include page="Common/studentFooter.jsp"/>
    </div>
</div>
</div>
<jsp:include page="Common/studentFooterScripts.jsp"/>

<script>
    //get Course ID and Module ID from the URL
    const urlParams = new URLSearchParams(window.location.search);
    const courseID = urlParams.get('CourseID');
    const moduleID = urlParams.get('ModuleID');



    const addAssignmentUrl = "http://localhost:8080/EduPickRest_war_exploded/api/assignments";

    $(document).ready(function () {
        $('#addAssignmentForm').submit(async function (event) {
            event.preventDefault();

            const formData = {
                moduleID: moduleID,
                courseID: courseID,
                assignmentName: $('#assignmentName').val(),
                assignmentDescription: $('#assignmentDescription').val(),
                assignmentURL: $('#assignmentURL').val(),
                assignmentType: $('#assignmentType').val(),
                assignmentStatus: $('#assignmentStatus').val(),
                dueDateTime: $('#dueDateTime').val()
            };

            console.log(formData);

            try {
                const response = await fetch(addAssignmentUrl, {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(formData)
                });
                if (response.ok) {
                    alert("Assignment added successfully!");
                    refreshAssignmentTable();
                    // You can redirect or do other actions here upon successful addition
                } else {
                    alert("Failed to add assignment!");
                    refreshAssignmentTable();
                }
            } catch (error) {
                console.error("Error:", error);
            }
        });

        refreshAssignmentTable();
        //clear form fields
        $('#addAssignmentForm').trigger("reset");
    });

    // Initial load of assignments table
    refreshAssignmentTable();

    // Function to refresh the assignments table
    function refreshAssignmentTable() {
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
                $('#assignmentTableBody').empty();
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
                        '<button type="button" class="btn btn-success btn-edit" data-toggle="modal" data-target="#editAssignmentModal">Submit</button>' +
                        '</td>' +
                        '</tr>';
                    $('#assignmentTableBody').append(row);
                });
            })
            .catch(error => console.error(error));
    }

    // Event handler for deleting an assignment
    $(document).ready(function () {
        // Edit Assignment Handler
        $('#assignmentTableBody').on('click', '.btn-edit', function () {
            const row = $(this).closest('tr');
            const assignmentId = row.find('td:eq(0)').text();
            const moduleID = row.find('td:eq(1)').text();
            const courseID = row.find('td:eq(2)').text();
            const assignmentName = row.find('td:eq(3)').text();
            const assignmentDescription = row.find('td:eq(4)').text();
            const assignmentURL = row.find('td:eq(5)').text();
            const assignmentType = row.find('td:eq(6)').text();
            const assignmentStatus = row.find('td:eq(7)').text();
            const dueDateTime = row.find('td:eq(8)').text();

            // Populate the form with the existing values for editing
            $('#assignmentIdInput').val(assignmentId);
            $('#newmoduleID').val(moduleID);
            $('#newcourseID').val(courseID);
            $('#newAssignmentName').val(assignmentName);
            $('#newAssignmentDescription').val(assignmentDescription);
            $('#newAssignmentURL').val(assignmentURL);
            $('#newAssignmentType').val(assignmentType);
            $('#newAssignmentStatus').val(assignmentStatus);
            $('#newDueDateTime').val(dueDateTime);
        });

        // Delete Assignment Handler
        $('#assignmentTableBody').on('click', '.btn-delete', function () {
            const row = $(this).closest('tr');
            const assignmentId = row.find('td:eq(0)').text();

            // Ask for confirmation before deleting
            const isConfirmed = confirm('Are you sure you want to delete this assignment?');
            if (!isConfirmed) {
                return; // If not confirmed, exit the function
            }

            const url = 'http://localhost:8080/EduPickRest_war_exploded/api/assignments/' + assignmentId;

            const options = {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            };

            fetch(url, options)
                .then(response => {
                    if (response.ok) {
                        alert("Assignment deleted successfully!");
                        refreshAssignmentTable();
                    } else {
                        alert("Failed to delete assignment!");
                    }
                })
                .catch(error => console.error(error));
            refreshAssignmentTable();
        });


    // Update Assignment Form Submission
    $('#updateAssignmentForm').submit(async function (event) {
        event.preventDefault();

        // Retrieve assignment ID
        const assignmentId = $('#assignmentIdInput').val();
        if (!assignmentId) {
            alert("Please provide a valid assignment ID.");
            return;
        }

        // Retrieve form data
        const formData = {
            moduleID: $('#newmoduleID').val(),  // Corrected ID selection
            courseID: $('#newcourseID').val(),  // Corrected ID selection
            assignmentName: $('#newAssignmentName').val(),
            assignmentDescription: $('#newAssignmentDescription').val(),
            assignmentURL: $('#newAssignmentURL').val(),
            assignmentType: $('#newAssignmentType').val(),
            assignmentStatus: $('#newAssignmentStatus').val(),
            dueDateTime: $('#newDueDateTime').val()
        };

        console.log(formData);

        // Construct the URL for the API endpoint
        const url = 'http://localhost:8080/EduPickRest_war_exploded/api/assignments/' + assignmentId;

        try {
            // Send PUT request to update assignment
            const response = await fetch(url, {
                method: "PUT",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify(formData)
            });

            // Check response status
            if (response.ok) {
                alert("Assignment updated successfully!");
                refreshAssignmentTable(); // Refresh the table to reflect the changes
            } else {
                alert("Failed to update assignment!");
            }
        } catch (error) {
            console.error("Error:", error);
        }
    });
});



</script>


</body>
</html>
