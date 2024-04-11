<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// if (isset($_POST['submit'])) {
    $courseCode = $_POST['course_code'];
    $rollNo = $_POST['roll_no'];
    $subjectCode = $_POST['subject_code'];
    $subjectName = $_POST['subject_name'];
    $semester = $_POST['semester'];

    // Establish database connection and insert logic here
    for ($i = 0; $i < $count; $i++) {
        $date = date("d-m-y");
        $que = "INSERT INTO student_courses (course_code, semester, roll_no, subject_code, assign_date) VALUES ('$courseCode[$i]', '" . $_POST['semester'][$i] . "', '$rollNo[$i]', '" . $_POST['subject_code'][$i] . "', '$date')";
        $run = mysqli_query($con, $que);
        if (!$run) {
            $error_message = "All Subjects Not Successfully Assigned To The Student";
            break; // Break the loop if any error occurs
        }
    }

    if (isset($error_message)) {
        $response = ['error' => $error_message];
        echo json_encode($response);
    } else {
        $success_message = "All Subjects Successfully Assigned To The Student";
        $response = ['message' => $success_message];
        echo json_encode($response);
    }

//      else {
//     $response = ['error' => 'Invalid parameters'];
//     echo json_encode($response);
// }
?>
