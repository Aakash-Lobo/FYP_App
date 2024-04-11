<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if (isset($_POST['sub'])) {
    $count = $_POST['count'];
    for ($i = 0; $i < $count; $i++) {
        $date = date("d-m-y");
        $courseCode = $_POST['course_code'][$i];
        $subjectCode = $_POST['subject_code'][$i];
        $semester = $_POST['semester'][$i];
        $rollNo = $_POST['roll_no'][$i];
        $attendance = $_POST['attendance'][$i];

        $que = "INSERT INTO student_attendance (course_code, subject_code, semester, student_id, attendance, attendance_date) VALUES ('$courseCode', '$subjectCode', '$semester', '$rollNo', '$attendance', '$date')";
        $run = mysqli_query($con, $que);
        if ($run) {
            echo "Insert Successfully";
        } else {
            echo "Insert Not Successfully";
        }
    }
}
?>
