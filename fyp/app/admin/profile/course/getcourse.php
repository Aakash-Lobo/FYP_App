<?php
// getcourses.php

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT course_code FROM courses";
$run = mysqli_query($con, $query);

if ($run) {
    $courses = [];
    while ($row = mysqli_fetch_assoc($run)) {
        $courses[] = $row;
    }

    http_response_code(200);
    echo json_encode($courses);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch courses']);
}

mysqli_close($con);
?>
