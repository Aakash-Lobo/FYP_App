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
    // Get the POST parameters
    $first_name = $_POST['first_name'];
    $middle_name = $_POST['middle_name'];
    $last_name = $_POST['last_name'];
    $father_name = $_POST['father_name'];
    $email = $_POST['email'];
    $phone_no = $_POST['phone_no'];
    $teacher_status = $_POST['teacher_status'];
    $application_status = $_POST['application_status'];
    $dob = $_POST['dob'];
    $other_phone = $_POST['other_phone'];
    $gender = $_POST['gender'];
    $permanent_address = $_POST['permanent_address'];
    $current_address = $_POST['current_address'];
    $place_of_birth = $_POST['place_of_birth'];
    $last_qualification = $_POST['last_qualification'];
    $state = $_POST['state'];

    // Get the current date
    $hire_date = date('d-m-y');

    // Perform the insert operation
    $query = "INSERT INTO teacher_info (first_name, middle_name, last_name, father_name, email, phone_no, teacher_status, application_status, dob, other_phone, gender, permanent_address, current_address, place_of_birth, last_qualification, state, hire_date)
    VALUES ('$first_name', '$middle_name', '$last_name', '$father_name', '$email', '$phone_no', '$teacher_status', '$application_status', '$dob', '$other_phone', '$gender', '$permanent_address', '$current_address', '$place_of_birth', '$last_qualification', '$state', '$hire_date')";

    $result = mysqli_query($con, $query);

    if ($result) {
        // Successful insertion
        echo json_encode(['message' => 'Teacher added successfully']);
    } else {
        // Error in insertion
        echo json_encode(['message' => 'Failed to add teacher']);
    }
} else {
    // Invalid request method
    echo json_encode(['message' => 'Invalid request method']);
}
?>