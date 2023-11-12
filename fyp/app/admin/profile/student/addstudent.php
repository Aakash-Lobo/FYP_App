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
    $firstName = $_POST['first_name'];
    $middleName = $_POST['middle_name'];
    $lastName = $_POST['last_name'];
    $fatherName = $_POST['father_name'];
    $rollNo = $_POST['roll_no'];
    $email = $_POST['email'];
    $courseCode = $_POST['course_code'];
    $prospectusIssued = $_POST['prospectus_issued'];
    $prospectusAmount = $_POST['prospectus_amount'];
    $applicantStatus = $_POST['applicant_status'];
    $applicationStatus = $_POST['application_status'];
    $dob = $_POST['dob'];
    $mobileNo = $_POST['mobile_no'];
    $gender = $_POST['gender'];
    $permanentAddress = $_POST['permanent_address'];
    $currentAddress = $_POST['current_address'];
    $placeOfBirth = $_POST['place_of_birth'];

    $insertQuery = "INSERT INTO student_info (roll_no, first_name, middle_name, last_name, father_name, email, mobile_no, course_code, prospectus_issued, applicant_status, application_status, dob, gender, permanent_address, current_address, place_of_birth) VALUES ('$rollNo', '$firstName', '$middleName', '$lastName', '$fatherName', '$email', '$mobileNo', '$courseCode', '$prospectusIssued', '$applicantStatus', '$applicationStatus', '$dob', '$gender', '$permanentAddress', '$currentAddress', '$placeOfBirth')";
    $insertResult = mysqli_query($con, $insertQuery);

    if ($insertResult) {
        http_response_code(200);
        echo json_encode(['message' => 'Student added successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to add student']);
    }
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Invalid request method']);
}

mysqli_close($con);
?>
