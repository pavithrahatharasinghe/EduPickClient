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
                    <h1 class="h3 mb-2 text-gray-800">Manage Course Materials</h1>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card shadow mb-4">
                                <div class="card-body">
                                    <form id="addMaterialForm">
                                        <div class="form-group">
                                            <label for="materialName">Material Name</label>
                                            <input type="text" class="form-control" id="materialName"
                                                   name="materialName"
                                                   placeholder="Enter Material Name" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="materialType">Material Type</label>
                                            <input type="text" class="form-control" id="materialType"
                                                   name="materialType"
                                                   placeholder="Enter Material Type" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="materialLink">Material Link</label>
                                            <input type="text" class="form-control" id="materialLink"
                                                   name="materialLink"
                                                   placeholder="Enter Material Link" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Add Material</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card shadow mb-4">
                                <div class="card-body">
                                    <form id="updateMaterialForm">
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="materialIdInput" placeholder="Existing Material ID"
                                                   name="materialIdInput" required hidden>
                                        </div>
                                        <div class="form-group">
                                            <label for="newMaterialName">New Material Name</label>
                                            <input type="text" class="form-control" id="newMaterialName" placeholder="Enter New Material Name"
                                                   name="newMaterialName" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="newMaterialType">New Material Type</label>
                                            <input type="text" class="form-control" id="newMaterialType" placeholder="Enter New Material Type"
                                                   name="newMaterialType" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="newMaterialLink">New Material Link</label>
                                            <input type="text" class="form-control" id="newMaterialLink" placeholder="Enter New Material Link"
                                                   name="newMaterialLink" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Update Material</button>
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
                                            <th>Material ID</th>
                                            <th>Material Name</th>
                                            <th>Material Type</th>
                                            <th>Material Link</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody id="materialTableBody">
                                        <!-- Materials will be displayed here -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- Display Materials Table -->


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
        $('#addMaterialForm').submit(async function (event) {
            event.preventDefault();

            const formData = {
                courseId: courseID,
                materialName: $('#materialName').val(),
                materialType: $('#materialType').val(),
                materialLink: $('#materialLink').val()
            };

            const addMaterialUrl = 'http://localhost:8080/EduPickRest_war_exploded/api/courseMaterial';

            try {
                const response = await fetch(addMaterialUrl, {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(formData)
                });
                if (response.ok) {
                    alert("Material added successfully!");
                    refreshMaterialTable();
                    // You can redirect or do other actions here upon successful addition
                } else {
                    alert("Failed to add material!");
                    refreshMaterialTable();
                }
            } catch (error) {
                console.error("Error:", error);
            }
        });

        // Initial load of materials table
        refreshMaterialTable();

        //clear form fields
        $('#addMaterialForm').trigger("reset");
    });

    // Function to refresh the materials table
    function refreshMaterialTable() {

        const url = 'http://localhost:8080/EduPickRest_war_exploded/api/courseMaterial/Course/' + courseID;
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
                $('#materialTableBody').empty();
                $.each(data, function (index, material) {
                    const row = '<tr>' +
                        '<td>' + material.materialId + '</td>' +
                        '<td>' + material.materialName + '</td>' +
                        '<td>' + material.materialType + '</td>' +
                        '<td>' + material.materialLink + '</td>' +
                        '<td>' +
                        '<button type="button" class="btn btn-danger btn-delete">Delete</button>' +
                        '<button type="button" class="btn btn-primary btn-update" data-toggle="modal" data-target="#updateMaterialModal">Update</button>' +
                        '</td>' +
                        '</tr>';
                    $('#materialTableBody').append(row);
                });
            })
            .catch(error => console.error(error));
    }

    // Event handler for deleting a material
    $(document).ready(function () {
        $('#materialTableBody').on('click', '.btn-delete', function () {
            const row = $(this).closest('tr');
            const materialId = row.find('td:eq(0)').text();

            // Ask for confirmation before deleting
            const isConfirmed = confirm('Are you sure you want to delete this material?');
            if (!isConfirmed) {
                return; // If not confirmed, exit the function
            }

            const url = 'http://localhost:8080/EduPickRest_war_exploded/api/courseMaterial/' + materialId;

            const options = {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            };

            fetch(url, options)
                .then(response => {
                    if (response.ok) {
                        alert("Material deleted successfully!");
                        refreshMaterialTable();
                    } else {
                        alert("Failed to delete material!");
                    }
                })
                .catch(error => console.error(error));
            refreshMaterialTable();
        });

        // Update Material Form Submission
        $('#updateMaterialForm').submit(async function (event) {
            event.preventDefault();

            // Retrieve material ID
            const materialId = $('#materialIdInput').val();
            if (!materialId) {
                alert("Please provide a valid material ID.");
                return;
            }

            // Retrieve form data
            const formData = {
                materialId: materialId,
                courseId: courseID,
                materialName: $('#newMaterialName').val(),
                materialType: $('#newMaterialType').val(),
                materialLink: $('#newMaterialLink').val()
            };

            console.log(formData);
            alert(formData);

            // Construct the URL for the API endpoint
            const url = 'http://localhost:8080/EduPickRest_war_exploded/api/courseMaterial';

            try {
                // Send PUT request to update material
                const response = await fetch(url, {
                    method: "PUT",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(formData)
                });

                // Check response status
                if (response.ok) {
                    alert("Material updated successfully!");
                    refreshMaterialTable(); // Refresh the table to reflect the changes
                } else {
                    alert("Failed to update material!");
                }
            } catch (error) {
                console.error("Error:", error);
            }

            refreshMaterialTable();
        });

        // Event handler for updating a material
        $('#materialTableBody').on('click', '.btn-update', function () {
            const row = $(this).closest('tr');
            const materialId = row.find('td:eq(0)').text();
            const materialName = row.find('td:eq(1)').text(); // Index adjusted to match the correct column
            const materialType = row.find('td:eq(2)').text();
            const materialLink = row.find('td:eq(3)').text(); // Index adjusted to match the correct column

            // Populate the update form fields with the retrieved values
            $('#materialIdInput').val(materialId);
            $('#newMaterialName').val(materialName);
            $('#newMaterialType').val(materialType);
            $('#newMaterialLink').val(materialLink); // Set the value of New Material Link field
        });

    });



</script>
