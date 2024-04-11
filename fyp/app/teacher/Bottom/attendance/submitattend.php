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
    $attendanceList = json_decode(file_get_contents("php://input"), true);
    foreach ($attendanceList as $attendance) {
        $rollNo = $attendance['roll_no'];
        $attendanceStatus = $attendance['attendance'];

        $que = "UPDATE student_attendance SET attendance = '$attendanceStatus' WHERE student_id = '$rollNo'";
        $run = mysqli_query($con, $que);
        if (!$run) {
            echo json_encode(['error' => 'Update Not Successful']);
            exit;
        }
    }

    echo json_encode(['success' => true]);
} else {
    // Invalid request method
    echo json_encode(['error' => 'Invalid request method']);
}

mysqli_close($con);
?>
