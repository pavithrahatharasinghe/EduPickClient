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
                    <h1 class="h3 mb-2 text-gray-800">Manage Course Modules</h1>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card shadow mb-4">
                                <div class="card-body">
                                    <form id="addModuleForm">
                                        <div class="form-group">


                                        </div>
                                        <div class="form-group">
                                            <label for="moduleName">Module Name</label>
                                            <input type="text" class="form-control" id="moduleName"
                                                   name="moduleName"
                                                   placeholder="Enter Module Name" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="moduleDescription">Module Description</label>
                                            <textarea class="form-control" id="moduleDescription"
                                                      name="moduleDescription"
                                                      placeholder="Enter Module Description"
                                                      required></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="moduleURL">Module URL</label>
                                            <input type="text" class="form-control" id="moduleURL"
                                                   name="moduleURL"
                                                   placeholder="Enter Module URL" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="moduleStatus">Module Status</label>
                                            <input type="text" class="form-control" id="moduleStatus"
                                                   name="moduleStatus" placeholder="Enter Module Status"
                                                   required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Add Module</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card shadow mb-4">
                                <div class="card-body">
                                    <form id="updateModuleForm">
                                        <div class="form-group">

                                            <input type="text" class="form-control" id="moduleIdInput" placeholder="Existing Module ID"
                                                   name="moduleIdInput" required hidden>
                                        </div>
                                        <div class="form-group">
                                            <label for="newModuleName">New Module Name</label>
                                            <input type="text" class="form-control" id="newModuleName" placeholder="Enter New Module Name"
                                                   name="newModuleName" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="newModuleDescription">New Module Description</label>
                                            <textarea class="form-control" id="newModuleDescription" placeholder="Enter New Module Description"
                                                      name="newModuleDescription" required></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="newModuleURL">New Module URL</label>
                                            <input type="text" class="form-control" id="newModuleURL" placeholder="Enter New Module URL"
                                                   name="newModuleURL" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="newModuleStatus">New Module Status</label>
                                            <input type="text" class="form-control" id="newModuleStatus" placeholder="Enter New Module Status"
                                                   name="newModuleStatus" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Update Module</button>
                                    </form>
                                </div>

                            </div>
                        </div>

                    </div>

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
        <jsp:include page="Common/adminFooter.jsp"/>
    </div>
</div>
</div>
<jsp:include page="Common/adminFooterScripts.jsp"/>
</body>
</html>
<script>
    //get courseID from URL
    const urlParams = new URLSearchParams(window.location.search);
    const courseID = urlParams.get('courseID');


    $(document).ready(function () {
        $('#addModuleForm').submit(async function (event) {
            event.preventDefault();

            const formData = {
                courseID: courseID,
                moduleName: $('#moduleName').val(),
                moduleDescription: $('#moduleDescription').val(),
                moduleURL: $('#moduleURL').val(),
                moduleStatus: $('#moduleStatus').val()
            };

            const addModuleUrl = 'http://localhost:8080/EduPickRest_war_exploded/api/modules';

            try {
                const response = await fetch(addModuleUrl, {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(formData)
                });
                if (response.ok) {
                    alert("Module added successfully!");
                    refreshModuleTable();
                    // You can redirect or do other actions here upon successful addition
                } else {
                    alert("Failed to add module!");
                    refreshModuleTable();
                }
            } catch (error) {
                console.error("Error:", error);
            }
        });

        // Initial load of modules table
        refreshModuleTable();

        //clear form fields
        $('#addModuleForm').trigger("reset");
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
                        '<button type="button" class="btn btn-danger btn-delete">Delete</button>' +
                        '<button type="button" class="btn btn-primary btn-update" data-toggle="modal" data-target="#updateModuleModal">Update</button>' +
                        '<a href="viewModuleDetails.jsp?ModuleID=' + module.moduleID + '" class="btn btn-primary btn-view">View</a>' +
                        '<a href="courseAssignments.jsp?ModuleID=' + module.moduleID + '&CourseID=' + courseID + '" class="btn btn-primary btn-view">Assignments</a>' +
                        '</td>' +
                        '</tr>';
                    $('#moduleTableBody').append(row);
                });
            })
            .catch(error => console.error(error));
    }

    // Event handler for deleting a module
    $(document).ready(function () {
        $('#moduleTableBody').on('click', '.btn-delete', function () {
            const row = $(this).closest('tr');
            const moduleId = row.find('td:eq(0)').text();

            // Ask for confirmation before deleting
            const isConfirmed = confirm('Are you sure you want to delete this module?');
            if (!isConfirmed) {
                return; // If not confirmed, exit the function
            }

            const url = 'http://localhost:8080/EduPickRest_war_exploded/api/modules/' + moduleId;

            const options = {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            };

            fetch(url, options)
                .then(response => {
                    if (response.ok) {
                        alert("Module deleted successfully!");
                        refreshModuleTable();
                    } else {
                        alert("Failed to delete module!");
                    }
                })
                .catch(error => console.error(error));
            refreshModuleTable();
        });

        // Update Module Form Submission
        $('#updateModuleForm').submit(async function (event) {
            event.preventDefault();

            // Retrieve module ID
            const moduleId = $('#moduleIdInput').val();
            if (!moduleId) {
                alert("Please provide a valid module ID.");
                return;
            }

            // Retrieve form data
            const formData = {
                moduleID: moduleId,
                courseID: courseID,
                moduleName: $('#newModuleName').val(),
                moduleDescription: $('#newModuleDescription').val(),
                moduleURL: $('#newModuleURL').val(),
                moduleStatus: $('#newModuleStatus').val()
            };

            console.log(formData);
            alert(formData);

            // Construct the URL for the API endpoint
            const url = 'http://localhost:8080/EduPickRest_war_exploded/api/modules';

            try {
                // Send PUT request to update module
                const response = await fetch(url, {
                    method: "PUT",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(formData)
                });

                // Check response status
                if (response.ok) {
                    alert("Module updated successfully!");
                    refreshModuleTable(); // Refresh the table to reflect the changes
                } else {
                    alert("Failed to update module!");
                }
            } catch (error) {
                console.error("Error:", error);
            }

            refreshModuleTable();
        });

        // Event handler for updating a module
        $('#moduleTableBody').on('click', '.btn-update', function () {
            const row = $(this).closest('tr');
            const moduleId = row.find('td:eq(0)').text();
            const moduleName = row.find('td:eq(1)').text(); // Index adjusted to match the correct column
            const moduleDescription = row.find('td:eq(2)').text();
            const moduleURL = row.find('td:eq(3)').text(); // Index adjusted to match the correct column
            const moduleStatus = row.find('td:eq(4)').text(); // Index adjusted to match the correct column

            // Populate the update form fields with the retrieved values
            $('#moduleIdInput').val(moduleId);
            $('#newModuleName').val(moduleName);
            $('#newModuleDescription').val(moduleDescription);
            $('#newModuleURL').val(moduleURL); // Set the value of New Module URL field
            $('#newModuleStatus').val(moduleStatus); // Set the value of New Module Status field
        });








    });



</script>

