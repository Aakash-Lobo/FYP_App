<?php
$servername = 'localhost';
$dbUsername = 'root';
$dbPassword = '';
$dbName = 'fyp';

// Create a database connection
$conn = mysqli_connect($servername, $dbUsername, $dbPassword, $dbName);
$teacher_email = $_POST['teacher_email'];
// $teacher_email = 'priya@gmail.com';
$query = "SELECT `teacher_id`, `first_name`, `middle_name`, `last_name`, `father_name`, `email`, `phone_no`, `teacher_status`, `application_status`, `dob`, `other_phone`, `gender`, `permanent_address`, `current_address`, `place_of_birth`, `last_qualification`, `state`, `hire_date` FROM teacher_info where email='$teacher_email'";

$result = $conn->query($query);

if ($result->num_rows > 0) {
    $teacherProfiles = array();
    while ($row = $result->fetch_assoc()) {
        $teacherProfile[] = $row;
    }
    echo json_encode($teacherProfile);
} else {
    echo json_encode(array());
}
?>
