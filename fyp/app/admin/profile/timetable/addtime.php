<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$courseCode = $_POST["course_code"];
$semester = $_POST["semester"];
$timingFrom = $_POST["timing_from"];
$timingTo = $_POST["timing_to"];
$day = $_POST["day"];
$subjectCode = $_POST["subject_code"];
$roomNo = $_POST["room_no"];

// Insert data into the database
$query = "INSERT INTO time_table (course_code, semester, timing_from, timing_to, day, subject_code, room_no) 
          VALUES ('$courseCode', '$semester', '$timingFrom', '$timingTo', '$day', '$subjectCode', '$roomNo')";

if ($conn->query($query) === TRUE) {
    $response = array('status' => 'success');
    echo json_encode($response);
} else {
    $response = array('status' => 'error', 'message' => 'Failed to add timetable entry');
    echo json_encode($response);
}

$conn->close();
?>