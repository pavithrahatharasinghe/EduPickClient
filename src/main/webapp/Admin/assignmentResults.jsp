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
                    <h1 class="h3 mb-2 text-gray-800">Manage Results</h1>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card shadow mb-4">
                                <div class="card-body">
                                    <form id="addResultForm">
                                        <div class="form-group">
                                            <label for="userID">User ID</label>
                                            <input type="text" class="form-control" id="userID"
                                                   name="userID"
                                                   placeholder="Enter User ID" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="marks">Marks</label>
                                            <input type="number" class="form-control" id="marks"
                                                   name="marks"
                                                   placeholder="Enter Marks" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="resultDate">Result Date</label>
                                            <input type="date" class="form-control" id="resultDate"
                                                   name="resultDate" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Add Result</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card shadow mb-4">
                                <div class="card-body">
                                    <form id="updateResultForm">
                                        <div class="form-group">

                                            <input type="text" class="form-control" id="resultIdInput"
                                                   placeholder="Existing Result ID" name="resultIdInput"
                                                   required hidden>
                                        </div>
                                        <div class="form-group">
                                            <label>New User ID</label>
                                            <input type="text" class="form-control" id="newUserID"
                                                   placeholder="Enter New User ID" name="newUserID"
                                                   required>
                                        </div>

                                        <div class="form-group">
                                            <label>New Marks</label>
                                            <input type="number" class="form-control" id="newMarks"
                                                   placeholder="Enter New Marks" name="newMarks"
                                                   required>
                                        </div>
                                        <div class="form-group">
                                            <label>New Result Date</label>
                                            <input type="date" class="form-control" id="newResultDate"
                                                   placeholder="Enter New Result Date" name="newResultDate"
                                                   required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Update Result</button>
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
                                            <th>Result ID</th>
                                            <th>User ID</th>
                                            <th>Assignment ID</th>
                                            <th>Marks</th>
                                            <th>Result Date</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody id="resultTableBody">
                                        <!-- Results will be displayed here -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!-- Display Results Table -->


                </div>
        </div>
        <jsp:include page="Common/adminFooter.jsp"/>
    </div>
</div>
</div>
<jsp:include page="Common/adminFooterScripts.jsp"/>
<script>
    //get Assignment ID from URL
    const urlParams = new URLSearchParams(window.location.search);
    const assignmentID = urlParams.get('AssignmentID');

    const addResultUrl = "http://localhost:8080/EduPickRest_war_exploded/api/results";

    $(document).ready(function () {
        $('#addResultForm').submit(async function (event) {
            event.preventDefault();

            const formData = {
                userID: $('#userID').val(),
                assignmentID: assignmentID,
                marks: $('#marks').val(),
                resultDate: $('#resultDate').val()
            };

            console.log(formData);

            try {
                const response = await fetch(addResultUrl, {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(formData)
                });
                if (response.ok) {
                    alert("Result added successfully!");
                    refreshResultTable();
                    // You can redirect or do other actions here upon successful addition
                } else {
                    alert("Failed to add result!");
                    refreshResultTable();
                }
            } catch (error) {
                console.error("Error:", error);
            }
        });

        refreshResultTable();
        //clear form fields
        $('#addResultForm').trigger("reset");
    });

    // Initial load of results table
    refreshResultTable();

    // Function to refresh the results table
    function refreshResultTable() {
        const url = 'http://localhost:8080/EduPickRest_war_exploded/api/results/Assignment/' + assignmentID;
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
                $('#resultTableBody').empty();
                $.each(data, function (index, result) {
                    const row = '<tr>' +
                        '<td>' + result.resultId + '</td>' +
                        '<td>' + result.userID + '</td>' +
                        '<td>' + result.assignmentID + '</td>' +
                        '<td>' + result.marks + '</td>' +
                        '<td>' + result.resultDate + '</td>' +
                        '<td>' +
                        '<button type="button" class="btn btn-danger btn-delete">Delete</button>' +
                        '<button type="button" class="btn btn-primary btn-edit" data-toggle="modal" data-target="#editResultModal">Edit</button>' +
                        '</td>' +
                        '</tr>';
                    $('#resultTableBody').append(row);
                });
            })
            .catch(error => console.error(error));
    }

    // Event handler for deleting a result
    $(document).ready(function () {
        $('#resultTableBody').on('click', '.btn-delete', function () {
            const row = $(this).closest('tr');
            const resultId = row.find('td:eq(0)').text();

            // Ask for confirmation before deleting
            const isConfirmed = confirm('Are you sure you want to delete this result?');
            if (!isConfirmed) {
                return; // If not confirmed, exit the function
            }

            const url = 'http://localhost:8080/EduPickRest_war_exploded/api/results/' + resultId;

            const options = {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            };

            fetch(url, options)
                .then(response => {
                    if (response.ok) {
                        alert("Result deleted successfully!");
                        refreshResultTable();
                    } else {
                        alert("Failed to delete result!");
                    }
                })
                .catch(error => console.error(error));
            refreshResultTable();
        });

        // Update Result Form Submission
        $('#updateResultForm').submit(async function (event) {
            event.preventDefault();

            // Retrieve result ID
            const resultId = $('#resultIdInput').val();
            if (!resultId) {
                alert("Please provide a valid result ID.");
                return;
            }

            // Retrieve form data
            const formData = {
                userID: $('#newUserID').val(),
                assignmentID: assignmentID,
                marks: $('#newMarks').val(),
                resultDate: $('#newResultDate').val()
            };

            console.log(formData);

            // Construct the URL for the API endpoint
            const url = 'http://localhost:8080/EduPickRest_war_exploded/api/results/' + resultId;

            try {
                // Send PUT request to update result
                const response = await fetch(url, {
                    method: "PUT",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(formData)
                });

                // Check response status
                if (response.ok) {
                    alert("Result updated successfully!");
                    refreshResultTable(); // Refresh the table to reflect the changes
                } else {
                    alert("Failed to update result!");
                }
            } catch (error) {
                console.error("Error:", error);
            }

            refreshResultTable();
        });

        // Event handler for editing a result
        $('#resultTableBody').on('click', '.btn-edit', function () {
            const row = $(this).closest('tr');
            const resultId = row.find('td:eq(0)').text();
            const userId = row.find('td:eq(1)').text();

            const marks = row.find('td:eq(3)').text();
            const resultDate = row.find('td:eq(4)').text();

            // Populate the form with the existing values for editing
            $('#resultIdInput').val(resultId);
            $('#newUserID').val(userId);

            $('#newMarks').val(marks);
            $('#newResultDate').val(resultDate);
        });

    });


</script>

</body>
</html>
```