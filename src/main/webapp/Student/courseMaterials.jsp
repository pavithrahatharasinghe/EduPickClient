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
                    <h1 class="h3 mb-2 text-gray-800">Manage Course Materials</h1>

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
                        '<button type="button" class="btn btn-success btn-delete">Download</button>' +
                        '</td>' +
                        '</tr>';
                    $('#materialTableBody').append(row);
                });
            })
            .catch(error => console.error(error));
    }

</script>
