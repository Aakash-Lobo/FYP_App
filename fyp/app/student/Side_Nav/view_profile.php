<?php
$servername = 'localhost';
$dbUsername = 'root';
$dbPassword = '';
$dbName = 'fyp';

// Create a database connection
$conn = mysqli_connect($servername, $dbUsername, $dbPassword, $dbName);
$teacher_email = $_POST['teacher_email'];
// $teacher_email = 'aakash@gmail.com';
$query = "SELECT `roll_no`, `first_name`, `middle_name`, `last_name`, `father_name`, `email` FROM student_info where email='$teacher_email'";

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
