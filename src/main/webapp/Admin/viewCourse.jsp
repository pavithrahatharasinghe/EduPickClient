<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Course</title>
    <!-- Include Bootstrap for styling & jQuery for easy DOM manipulation and AJAX -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>

<div class="container mt-5">
    <h1>Course Details</h1>
    <form id="updateCourseForm">
        <!-- Hidden field for the course ID -->
        <input type="hidden" id="courseId" name="courseId">

        <div class="form-group">
            <label for="courseName">Name</label>
            <input type="text" class="form-control" id="courseName" name="courseName" required>
        </div>

        <div class="form-group">
            <label for="courseDescription">Description</label>
            <textarea class="form-control" id="courseDescription" name="courseDescription" rows="3" required></textarea>
        </div>

<%--       courseImage--%>
        <div class="form-group">
            <label for="courseImage">Image</label>
            <input type="text" class="form-control" id="courseImage" name="courseImage" required>
        </div>
<%--        courseCategory--%>
        <div class="form-group">
            <label for="courseCategory">Category</label>
            <input type="text" class="form-control" id="courseCategory" name="courseCategory" required>
        </div>

<%--        courseLevel--%>
        <div class="form-group">
            <label for="courseLevel">Level</label>
            <input type="text" class="form-control" id="courseLevel" name="courseLevel" required>
        </div>
<%--        courseLanguage--%>
        <div class="form-group">
            <label for="courseLanguage">Language</label>
            <input type="text" class="form-control" id="courseLanguage" name="courseLanguage" required>
        </div>
<%--        coursePrice--%>
        <div class="form-group">
            <label for="coursePrice">Price</label>
            <input type="number" class="form-control" id="coursePrice" name="coursePrice" required>
        </div>
<%--        courseURL--%>
        <div class="form-group">
            <label for="courseURL">URL</label>
            <input type="text" class="form-control" id="courseURL" name="courseURL" required>
        </div>
<%--        courseDuration--%>
        <div class="form-group">
            <label for="courseDuration">Duration</label>
            <input type="number" class="form-control" id="courseDuration" name="courseDuration" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Course</button>
    </form>
</div>


<script>
    $(document).ready(function () {
        const queryParams = new URLSearchParams(window.location.search);
        const courseID = queryParams.get('courseID');
        if (courseID) {
            fetchCourseDetails(courseID);
        }
    });

    function fetchCourseDetails(courseID) {
        const apiUrl = "http://localhost:8080/EduPickRest_war_exploded/api/courses/" + courseID;

        fetch(apiUrl)
            .then(response => response.json())
            .then(course => {
                $('#courseName').val(course.courseName);
                // Populate other fields
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to load course details.');
            });
    }

    $('#updateCourseForm').submit(function(event) {
        event.preventDefault();

        const updatedCourseData = {
            // Assume you have inputs for each of these fields in your form
            courseName: $('#courseName').val(),
            // Add other fields here
        };

        const updateUrl = "http://localhost:8080/EduPickRest_war_exploded/api/courses/" + courseID; // Use the courseID from the URL or a hidden input field

        fetch(updateUrl, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(updatedCourseData),
        })
            .then(response => {
                if (response.ok) {
                    alert('Course updated successfully!');
                    // Optionally, redirect or refresh
                } else {
                    alert('Failed to update course.');
                }
            })
            .catch(error => {
                console.error('Error updating course:', error);
                alert('An error occurred while updating the course.');
            });
    });

</script>

</body>
</html>
