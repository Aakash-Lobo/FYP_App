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

// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $teacher_email = $_POST['teacher_email'];
    // $teacher_email = "jane@gmail.com";
    $query1 = "SELECT * FROM teacher_info WHERE email='$teacher_email'";
    $run1 = $run = mysqli_query($con, $query1);
    while ($row = mysqli_fetch_array($run1)) {
        $teacher_id = $row["teacher_id"];
    }

    $query = "SELECT tc.course_code, tc.subject_code, tt.room_no, tc.semester, tt.timing_to, tc.total_classes FROM teacher_courses tc INNER JOIN time_table tt ON tc.subject_code=tt.subject_code WHERE teacher_id='$teacher_id'";
    $run = mysqli_query($con, $query);

    $courses = [];
    while ($row = mysqli_fetch_assoc($run)) {
        $courses[] = $row;
    }

    echo json_encode($courses);
// } else {
//     echo json_encode(['error' => 'Invalid request method']);
// }

mysqli_close($con);
?>
