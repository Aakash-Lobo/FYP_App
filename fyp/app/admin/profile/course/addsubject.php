<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $subjectCode = mysqli_real_escape_string($con, $_POST['subject_code']);
    $subjectName = mysqli_real_escape_string($con, $_POST['subject_name']);
    $semester = mysqli_real_escape_string($con, $_POST['semester']);
    $courseCode = mysqli_real_escape_string($con, $_POST['course_code']);
    $creditHours = mysqli_real_escape_string($con, $_POST['credit_hours']);

    $insertQuery = "INSERT INTO course_subjects (subject_code, subject_name, course_code, semester, credit_hours) VALUES ('$subjectCode', '$subjectName', '$courseCode', '$semester', '$creditHours')";
    $insertResult = mysqli_query($con, $insertQuery);

    if ($insertResult) {
        http_response_code(200);
        echo json_encode(['message' => 'Subject added successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to add subject']);
    }
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Invalid request method']);
}

mysqli_close($con);
?>
