<?php
// delete-course.php

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $courseCode = $_POST['course_code'];

    $deleteQuery = "DELETE FROM courses WHERE course_code = '$courseCode'";
    $deleteResult = mysqli_query($con, $deleteQuery);

    if ($deleteResult) {
        http_response_code(200);
        echo json_encode(['message' => 'Course deleted successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to delete course']);
    }
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Invalid request method']);
}

mysqli_close($con);
?>
