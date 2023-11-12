<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT subject_code, subject_name, course_code, semester, credit_hours FROM course_subjects";
$run = mysqli_query($con, $query);

if ($run) {
    $subjects = [];
    $srNo = 1;
    while ($row = mysqli_fetch_assoc($run)) {
        $row['srNo'] = $srNo++;
        $subjects[] = $row;
    }

    http_response_code(200);
    echo json_encode($subjects);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch subjects']);
}

mysqli_close($con);
?>
