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
                    <h1 class="h3 mb-2 text-gray-800">All Courses</h1>
                    <p class="mb-4">Overview of all courses available in the institute.</p>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <form id="predictionForm">
                                <div class="row">
                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label for="hobbies">Hobbies:</label>
                                            <select id="hobbies" name="hobbies" class="form-control" required>
                                                <option value="Reading">Reading</option>
                                                <option value="Sports">Sports</option>
                                                <option value="Music">Music</option>
                                                <option value="Art">Art</option>
                                                <option value="Travel">Travel</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="skills">Skills:</label>
                                            <select id="skills" name="skills" class="form-control" required>
                                                <option value="Programming">Programming</option>
                                                <option value="Communication">Communication</option>
                                                <option value="Problem Solving">Problem Solving</option>
                                                <option value="Leadership">Leadership</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="interest">Interest:</label>
                                            <select id="interest" name="interest" class="form-control" required>
                                                <option value="Science">Science</option>
                                                <option value="Business">Business</option>
                                                <option value="Arts">Arts</option>
                                                <option value="Technology">Technology</option>
                                                <option value="Engineering">Engineering</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="university">University:</label>
                                            <select id="university" name="university" class="form-control" required>
                                                <option value="Informatics Institute of Technology">Informatics
                                                    Institute of Technology
                                                </option>
                                                <option value="Sri Lanka Institute of Information Technology">Sri Lanka
                                                    Institute of Information Technology
                                                </option>
                                                <option value="ICBT Campus">ICBT Campus</option>
                                                <option value="Esoft Metro Campus">Esoft Metro Campus</option>
                                                <option value="Asia Pacific Institute of Information Technology">Asia
                                                    Pacific Institute of Information Technology
                                                </option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="dedicationHours">Dedication Hours Per Week:</label>
                                            <select id="dedicationHours" name="dedicationHours" class="form-control"
                                                    required>
                                                <option value="Under 10 hours">Under 10 hours</option>
                                                <option value="10 - 20 hours">10 - 20 hours</option>
                                                <option value="20 - 30 hours">20 - 30 hours</option>
                                                <option value="Over 30 hours">Over 30 hours</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="sportsClubs">Sports/Clubs:</label>
                                            <select id="sportsClubs" name="sportsClubs" class="form-control" required>
                                                <option value="Yes">Yes</option>
                                                <option value="No">No</option>
                                            </select>
                                        </div>

                                    </div>
                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label for="choiceOfSelection">Choice of Selection:</label>
                                            <select id="choiceOfSelection" name="choiceOfSelection" class="form-control"
                                                    required>
                                                <option value="Internship">Internship</option>
                                                <option value="Success Rates">Success Rates</option>
                                                <option value="Teaching Style">Teaching Style</option>
                                                <option value="Extra Curricular Activities">Extra Curricular
                                                    Activities
                                                </option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="courseFee">Course Fee:</label>
                                            <select id="courseFee" name="courseFee" class="form-control" required>
                                                <option value="Less than Rs 1,000,000/=">Less than Rs 1,000,000/=
                                                </option>
                                                <option value="Rs 1,000,000 - Rs 3,000,000/=">Rs 1,000,000 - Rs
                                                    3,000,000/=
                                                </option>
                                                <option value="More than Rs 3,000,000/=">More than Rs 3,000,000/=
                                                </option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="learningEnvironment">Learning Environment:</label>
                                            <select id="learningEnvironment" name="learningEnvironment"
                                                    class="form-control" required>
                                                <option value="Large Lectures">Large Lectures</option>
                                                <option value="Discussion Groups">Discussion Groups</option>
                                                <option value="Hands-on Projects">Hands-on Projects</option>
                                                <option value="Online Lectures">Online Lectures</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="assessment">Assessment:</label>
                                            <select id="assessment" name="assessment" class="form-control" required>
                                                <option value="Exams">Exams</option>
                                                <option value="Reports">Reports</option>
                                                <option value="Presentations">Presentations</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="desiredIndustries">Desired Industries:</label>
                                            <select id="desiredIndustries" name="desiredIndustries" class="form-control"
                                                    required>
                                                <option value="Computer Science">Computer Science</option>
                                                <option value="Software Engineering">Software Engineering</option>
                                                <option value="AI & Data Science">AI & Data Science</option>
                                                <option value="Network Security">Network Security</option>
                                                <option value="Cyber Security">Cyber Security</option>
                                                <option value="Business Information Systems">Business Information
                                                    Systems
                                                </option>
                                                <option value="Business Management">Business Management</option>
                                                <option value="Business Analytics">Business Analytics</option>
                                                <option value="Art">Art</option>
                                                <option value="Law">Law</option>
                                                <option value="Healthcare">Healthcare</option>
                                            </select>
                                        </div>
        
                                        <button type="button" class="btn btn-primary" onclick="makePrediction()">
                                            Predict
                                        </button>

                                    </div>
                                </div>
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

<script>
    function makePrediction() {
        // Collect form data
        var formData = {
            "Hobbies": $("#hobbies").val(),
            "Skills": $("#skills").val(),
            "Interest": $("#interest").val(),
            "University": $("#university").val(),
            "Dedication_Hours_Per_Week": $("#dedicationHours").val(),
            "Sports/Clubs": $("#sportsClubs").val(),
            "Choice_of_Selection": $("#choiceOfSelection").val(),
            "Course_Fee": $("#courseFee").val(),
            "Learning_Environment": $("#learningEnvironment").val(),
            "Assessment": $("#assessment").val(),
            "Desired_Industries": $("#desiredIndustries").val()
        };

        console.log(formData);

        // Make a POST request to Flask endpoint
        $.ajax({
            type: "POST",
            url: "http://127.0.0.1:8000/predict_industry",  // Update with your Flask app endpoint
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function (response) {
                // Display prediction result using SweetAlert
                Swal.fire({
                    title: response.predicted_industry,
                    text: 'Predicted Industry',
                    //icon: 'success',
                    confirmButtonText: 'OK'
                });

                console.log(response);
            },
            error: function (error) {
                console.log("Error:", error);
            }
        });
    }
</script>


</body>
</html>
