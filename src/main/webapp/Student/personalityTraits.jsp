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
                                        <div class="slidecontainer">
                                            <label><h4>In the range of 1 to 10, what is your level of Openness?</h4></label><br>
                                            <input type="range" min="1" max="10" value="5" class="slider" id="openness">
                                            <p>Value: <span id="opennessValue">5</span></p>
                                        </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="slidecontainer">
                                                <label><h4>In the range of 1 to 10, what is your level of Neuroticism?</h4></label><br>
                                                <input type="range" id="neuroticism" name="neuroticism" min="1" max="10" value="5" class="slider form-control" required>
                                                <p>Value: <span id="neuroticismValue">5</span></p>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="slidecontainer">
                                                <label><h4>In the range of 1 to 10, what is your level of Conscientiousness?</h4></label><br>
                                                <input type="range" id="conscientiousness" name="conscientiousness" min="1" max="10" value="5" class="slider form-control" required>
                                                <p>Value: <span id="conscientiousnessValue">5</span></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">


                                        <div class="form-group">
                                            <div class="slidecontainer">
                                                <label><h4>In the range of 1 to 10, what is your level of Agreeableness?</h4></label><br>
                                                <input type="range" id="agreeableness" name="agreeableness" min="1" max="10" value="5" class="slider form-control" required>
                                                <p>Value: <span id="agreeablenessValue">5</span></p>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="slidecontainer">
                                                <label><h4>In the range of 1 to 10, what is your level of Extraversion?</h4></label><br>
                                                <input type="range" id="extraversion" name="extraversion" min="1" max="10" value="5" class="slider form-control" required>
                                                <p>Value: <span id="extraversionValue">5</span></p>
                                            </div>
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
                                        <div class="form-group">
                                            <label for="gender">Gender:</label>
                                            <select id="gender" name="gender" class="form-control" required>
                                                <option value="">Select Gender</option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                            </select>
                                        </div>
                                    </div>

                                </div>
                                <style>
                                    .slidecontainer {
                                        width: 100%;
                                    }

                                    .slider {
                                        -webkit-appearance: none;
                                        width: 100%;
                                        height: 15px;
                                        border-radius: 5px;
                                        background: #d3d3d3;
                                        outline: none;
                                        opacity: 0.7;
                                        -webkit-transition: .2s;
                                        transition: opacity .2s;
                                    }

                                    .slider:hover {
                                        opacity: 1;
                                    }

                                    .slider::-webkit-slider-thumb {
                                        -webkit-appearance: none;
                                        appearance: none;
                                        width: 25px;
                                        height: 25px;
                                        border-radius: 50%;
                                        background: #3185f1;
                                        cursor: pointer;
                                    }

                                    .slider::-moz-range-thumb {
                                        width: 25px;
                                        height: 25px;
                                        border-radius: 50%;
                                        background: #3185f1;
                                        cursor: pointer;
                                    }
                                </style>
                                <script>
                                    // Openness
                                    var sliderOpenness = document.getElementById("openness");
                                    var outputOpenness = document.getElementById("opennessValue");
                                    outputOpenness.innerHTML = sliderOpenness.value;
                                    sliderOpenness.oninput = function() {
                                        outputOpenness.innerHTML = this.value;
                                    }

                                    // Neuroticism
                                    var sliderNeuroticism = document.getElementById("neuroticism");
                                    var outputNeuroticism = document.getElementById("neuroticismValue");
                                    outputNeuroticism.innerHTML = sliderNeuroticism.value;
                                    sliderNeuroticism.oninput = function() {
                                        outputNeuroticism.innerHTML = this.value;
                                    }

                                    // Conscientiousness
                                    var sliderConscientiousness = document.getElementById("conscientiousness");
                                    var outputConscientiousness = document.getElementById("conscientiousnessValue");
                                    outputConscientiousness.innerHTML = sliderConscientiousness.value;
                                    sliderConscientiousness.oninput = function() {
                                        outputConscientiousness.innerHTML = this.value;
                                    }

                                    // Agreeableness
                                    var sliderAgreeableness = document.getElementById("agreeableness");
                                    var outputAgreeableness = document.getElementById("agreeablenessValue");
                                    outputAgreeableness.innerHTML = sliderAgreeableness.value;
                                    sliderAgreeableness.oninput = function() {
                                        outputAgreeableness.innerHTML = this.value;
                                    }

                                    // Extraversion
                                    var sliderExtraversion = document.getElementById("extraversion");
                                    var outputExtraversion = document.getElementById("extraversionValue");
                                    outputExtraversion.innerHTML = sliderExtraversion.value;
                                    sliderExtraversion.oninput = function() {
                                        outputExtraversion.innerHTML = this.value;
                                    }
                                </script>

                                <button type="button" class="btn btn-primary" onclick="validateForm()">Predict</button>
                            </form>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    </div>
</div>
<jsp:include page="Common/studentFooter.jsp"/>
<jsp:include page="Common/studentFooterScripts.jsp"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
    function validateForm() {
        if (document.getElementById("personalityForm").checkValidity()) {
            makePrediction();
        } else {
            // Form is not valid
            Swal.fire({
                title: "Error",
                text: "Please fill out all the fields.",
                icon: 'error',
                confirmButtonText: 'OK'
            });
        }
    }
    function makePrediction() {
        // Get values from the form
        var gender = document.getElementById("gender").value;
        // if male its 0 otherwise its 1
        if (gender === 'Male') {
            gender = 0;
        } else {
            gender = 1;
        }
        var age = document.getElementById("age").value;
        var openness = document.getElementById("openness").value;
        var neuroticism = document.getElementById("neuroticism").value;
        var conscientiousness = document.getElementById("conscientiousness").value;
        var agreeableness = document.getElementById("agreeableness").value;
        var extraversion = document.getElementById("extraversion").value;
        // Prepare the data in the required format
        var data = {
            "data": [
                [gender, age, openness, neuroticism, conscientiousness, agreeableness, extraversion]
            ]
        };

        console.log(data);
        // Make a POST request to the endpoint
        $.ajax({
            type: "POST",
            url: "http://127.0.0.1:5000/predict_personality",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function (response) {
                // Check if the response is valid
                if (response && response.predicted_personality && response.predicted_personality.length > 0) {
                    // Display prediction result using SweetAlert
                    Swal.fire({
                        title: response.predicted_personality[0],
                        text: "is your Personality Type:",
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
