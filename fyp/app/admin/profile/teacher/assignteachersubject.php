<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if (isset($_POST['btn_save2'])) {
    $course_code = $_POST['course_code'];
    $semester = $_POST['semester'];
    $teacher_id = $_POST['teacher_id'];
    $subject_code = $_POST['subject_code'];
    $total_classes = $_POST['total_classes'];
    $date = date("d-m-y");

    $query3 = "INSERT INTO teacher_courses(course_code, semester, teacher_id, subject_code, assign_date, total_classes) VALUES ('$course_code', '$semester', '$teacher_id', '$subject_code', '$date', '$total_classes')";
    $run3 = mysqli_query($con, $query3);

    if ($run3) {
        echo "Your Data has been submitted";
    } else {
        echo "Your Data has not been submitted";
    }
}
?>