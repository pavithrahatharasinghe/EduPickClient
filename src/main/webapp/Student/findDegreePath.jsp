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
                    <h1 class="h3 mb-2 text-gray-800">Degree Pathway Prediction Form</h1>
                    <p class="mb-4">Please fill out the form to predict your degree pathway.</p>

                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <form id="degreePredictionForm">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="university">Institution:</label>
                                            <select id="university" name="university" class="form-control" required>
                                                <option value="Select an institution">Select an institution</option>
                                                <option value="Informatics Institute of Technology">Informatics Institute of Technology</option>
                                                <option value="Sri Lanka Institute of Information Technology">Sri Lanka Institute of Information Technology</option>
                                                <option value="ICBT Campus">ICBT Campus</option>
                                                <option value="Esoft Metro Campus">Esoft Metro Campus</option>
                                                <option value="Asia Pacific Institute of Information Technology">Asia Pacific Institute of Information Technology</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="influenceSelection">Influence:</label>
                                            <select id="influenceSelection" name="influenceSelection" class="form-control" required>
                                                <option value="Select an influence">Select an influence</option>
                                                <option value="Internship Opportunities">Internship Opportunities</option>
                                                <option value="Transferring Opportunities">Transferring Opportunities</option>
                                                <option value="Curriculum and Teaching Style">Curriculum and Teaching Style</option>
                                                <option value="Extra Curricular Activities">Extra Curricular Activities (Clubs & Societies, Sports)</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="studyHours">Weekly Study Hours:</label>
                                            <select id="studyHours" name="studyHours" class="form-control" required>
                                                <option value="Select weekly study hours">Select weekly study hours</option>
                                                <option value="Under 10 hours">Under 10 hours</option>
                                                <option value="10 - 20 hours">10 - 20 hours</option>
                                                <option value="20 - 30 hours">20 - 30 hours</option>
                                                <option value="Over 30 hours">Over 30 hours</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="sportsEngagement">Sports Engagement:</label>
                                            <select id="sportsEngagement" name="sportsEngagement" class="form-control" required>
                                                <option value="Yes">Yes</option>
                                                <option value="No">No</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="nonJobSpecificSkills">Non-Job Specific Skills:</label>
                                            <select id="nonJobSpecificSkills" name="nonJobSpecificSkills" class="form-control" required>
                                                <option value="Select a non-job specific skill">Select a non-job specific skill</option>
                                                <option value="Communication">Communication</option>
                                                <option value="Teamwork">Teamwork</option>
                                                <option value="Problem Solving">Problem Solving</option>
                                                <option value="Time Management">Time Management</option>
                                                <option value="Adaptability">Adaptability</option>
                                                <option value="Creativity">Creativity</option>
                                                <option value="Work Ethic">Work Ethic</option>
                                                <option value="Interpersonal Skills">Interpersonal Skills</option>
                                                <option value="Attention to Detail">Attention to Detail</option>
                                                <option value="Resilience">Resilience</option>
                                                <option value="Leadership">Leadership</option>
                                                <option value="Emotional Intelligence">Emotional Intelligence</option>
                                                <option value="Critical Thinking">Critical Thinking</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="educationPathwayDifficulties">Difficulties Faced:</label>
                                            <select id="educationPathwayDifficulties" name="educationPathwayDifficulties" class="form-control" required>
                                                <option value="Yes">Yes</option>
                                                <option value="No">No</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="pathwayInfluence">Influence on Pathway Selection:</label>
                                            <select id="pathwayInfluence" name="pathwayInfluence" class="form-control" required>
                                                <option value="Select an influence on pathway selection">Select an influence on pathway selection</option>
                                                <option value="Influenced by a third person">Influenced by a third person</option>
                                                <option value="The selection was based on your choice and preference">The selection was based on your choice and preference</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="changeDegreePathway">Change Pathway:</label>
                                            <select id="changeDegreePathway" name="changeDegreePathway" class="form-control">
                                                <option value="Yes">Yes</option>
                                                <option value="No">No</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="educationalPlatformOpinion">Opinion on Educational Platform:</label>
                                            <select id="educationalPlatformOpinion" name="educationalPlatformOpinion" class="form-control" required>
                                                <option value="Yes">Yes</option>
                                                <option value="No">No</option>
                                            </select>
                                        </div>

                                        <button type="button" class="btn btn-primary" onclick="validateForm()">Predict Degree</button>
                                    </div>
                                </div>
                            </form>

                            <script>
                                function validateForm() {
                                    var university = document.getElementById("university");
                                    var influenceSelection = document.getElementById("influenceSelection");
                                    var studyHours = document.getElementById("studyHours");
                                    var sportsEngagement = document.getElementById("sportsEngagement");
                                    var nonJobSpecificSkills = document.getElementById("nonJobSpecificSkills");
                                    var educationPathwayDifficulties = document.getElementById("educationPathwayDifficulties");
                                    var pathwayInfluence = document.getElementById("pathwayInfluence");
                                    var changeDegreePathway = document.getElementById("changeDegreePathway");
                                    var educationalPlatformOpinion = document.getElementById("educationalPlatformOpinion");

                                    if (university.value === "Select an institution" || influenceSelection.value === "Select an influence" || studyHours.value === "Select weekly study hours" || sportsEngagement.value === "Select sports engagement" || nonJobSpecificSkills.value === "Select a non-job specific skill" || educationPathwayDifficulties.value === "Select difficulties faced" || pathwayInfluence.value === "Select an influence on pathway selection" || changeDegreePathway.value === "Select change pathway" || educationalPlatformOpinion.value === "Select opinion on educational platform") {
                                        Swal.fire({
                                            title: "Error",
                                            text: "Please fill out all the fields.",
                                            icon: 'error',
                                            confirmButtonText: 'OK'
                                        });
                                    } else {
                                        makePrediction();
                                    }
                                }
                            </script>

                        </div>
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
    function makePrediction() {
        // Collect form data
        var formData = {
            "Institution": $("#university").val(),
            "Influence": $("#influenceSelection").val(),
            "Weekly Study Hours": $("#studyHours").val(),
            "Sports Engagement": $("#sportsEngagement").val(),
            "Career Goal": $("#careerGoal").val(), // Corrected field name
            "Non-Job Specific Skills": $("#nonJobSpecificSkills").val(),
            "Difficulties Faced": $("#educationPathwayDifficulties").val(), // Corrected field name
            "Influence on Pathway Selection": $("#pathwayInfluence").val(), // Corrected field name
            "Change Pathway": $("#changeDegreePathway").val(), // Corrected field name
            "Opinion on Educational Platform": $("#educationalPlatformOpinion").val() // Corrected field name
        };


        console.log(formData);

        // Make a POST request to Flask endpoint
        $.ajax({
            type: "POST",
            url: "http://127.0.0.1:5000/predict_degree",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function (response) {
                // Display prediction result using SweetAlert
                Swal.fire({

                    title: response.predicted_degree[0],
                    text: "might be the ideal degree pathway for you.",
                    icon: 'info',
                    confirmButtonText: 'OK'
                });

                console.log(response);
            },
            error: function (error) {
                console.log("Error:", error);
                Swal.fire({
                    title: "Error",
                    text: "An error occurred while making the prediction.",
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            }
        });
    }
</script>

</body>
</html>
