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
                    <h1 class="h3 mb-2 text-gray-800">Personality Prediction Form</h1>
                    <p class="mb-4">Please fill out the form to predict your personality type.</p>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <form id="personalityForm">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="gender">Gender:</label>
                                            <select id="gender" name="gender" class="form-control" required>
                                                <option value="">Select Gender</option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="age">Age:</label>
                                            <input type="number" id="age" class="form-control" min="10" max="80" required>
                                            <script>
                                                // Restrict the input to numbers only with range of 10 - 80
                                                document.getElementById("age").addEventListener("input", function () {
                                                    if (this.value.length > 2) {
                                                        this.value = this.value.slice(0, 2);
                                                    }
                                                });
                                            </script>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>In the range of 0 to 10, what is your level of openness?</label><br>
                                            <% for (int i = 1; i <= 10; i++) { %>
                                            <input type="radio" name="openness" value="<%= i %>" required> <%= i %>
                                            <% } %>
                                        </div>

                                        <div class="form-group">
                                            <label>In the range of 0 to 10, what is your level of Neuroticism?</label><br>
                                            <% for (int i = 1; i <= 10; i++) { %>
                                            <input type="radio" name="neuroticism" value="<%= i %>" required> <%= i %>
                                            <% } %>
                                        </div>

                                        <div class="form-group">
                                            <label>In the range of 0 to 10, what is your level of Conscientiousness?</label><br>
                                            <% for (int i = 1; i <= 10; i++) { %>
                                            <input type="radio" name="conscientiousness" value="<%= i %>" required> <%= i %>
                                            <% } %>
                                        </div>

                                        <div class="form-group">
                                            <label>In the range of 0 to 10, what is your level of Agreeableness?</label><br>
                                            <% for (int i = 1; i <= 10; i++) { %>
                                            <input type="radio" name="agreeableness" value="<%= i %>" required> <%= i %>
                                            <% } %>
                                        </div>

                                        <div class="form-group">
                                            <label>In the range of 0 to 10, what is your level of Extraversion?</label><br>
                                            <% for (int i = 1; i <= 10; i++) { %>
                                            <input type="radio" name="extraversion" value="<%= i %>" required> <%= i %>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-primary" onclick="validateForm()">Predict</button>
                            </form>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
    function validateForm() {
        if (document.getElementById("personalityForm").checkValidity()) {
            makePrediction();
        } else {
            // Form is not valid
            alert("Please fill out all the required fields correctly.");
        }
    }

    function makePrediction() {
        // Map gender string value to numeric representation
        var genderValue = $("#gender").val() === "Male" ? 0 : 1;

        // Prepare the data in the required format
        var data = [
            [genderValue, parseInt($("#age").val()), parseInt($('input[name=openness]:checked').val()),
                parseInt($('input[name=neuroticism]:checked').val()), parseInt($('input[name=conscientiousness]:checked').val()),
                parseInt($('input[name=agreeableness]:checked').val()), parseInt($('input[name=extraversion]:checked').val())]
        ];

        console.log(data);

        // Make a POST request to the endpoint
        $.ajax({
            type: "POST",
            url: "http://127.0.0.1:5000/predict",
            contentType: "application/json",
            data: JSON.stringify({"data": data}),
            success: function (response) {
                // Check if the response is valid
                if (response && response.prediction && response.prediction.length > 0) {
                    // Display prediction result using SweetAlert
                    Swal.fire({
                        title: "Your Personality Type:",
                        text: response.prediction[0],
                        icon: 'info',
                        confirmButtonText: 'OK'
                    });


                } else {
                    // Handle unexpected response format
                    console.error("Unexpected response format:", response);
                    Swal.fire({
                        title: "Error",
                        text: "Unexpected response format",
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                }
            },
            error: function (error) {
                // Handle AJAX request error
                console.error("Error:", error);
                Swal.fire({
                    title: "Error",
                    text: "Failed to make prediction. Please try again later.",
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            }
        });
    }


</script>

</body>
</html>
