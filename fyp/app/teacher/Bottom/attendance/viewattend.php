<?php
header('Content-Type: application/json');

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Update with your database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $count = $_POST['count'];
    for ($i = 0; $i < $count; $i++) {
        $date = date("d-m-y");
        $que = "INSERT INTO student_attendance (course_code, subject_code, semester, student_id, attendance, attendance_date)
                VALUES ('" . $_POST['course_code'][$i] . "', '" . $_POST['subject_code'][$i] . "', '" . $_POST['semester'][$i] . "', '" . $_POST['roll_no'][$i] . "', '" . $_POST['attendance'][$i] . "', '$date')";
        $run = mysqli_query($con, $que);
        if (!$run) {
            echo json_encode(['error' => 'Insert Not Successful']);
            exit;
        }
    }

    echo json_encode(['message' => 'Attendance added successfully']);
} else {
    // Invalid request method
    echo json_encode(['error' => 'Invalid request method']);
}

mysqli_close($con);
?>
