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
    $subjectCode = $_POST['subject_code'];

    $query = "DELETE FROM course_subjects WHERE subject_code = '$subjectCode'";
    $run = mysqli_query($con, $query);

    if ($run) {
        http_response_code(200);
        echo json_encode(['message' => 'Subject deleted successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to delete subject']);
    }
} else {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid request']);
}

mysqli_close($con);
?>
