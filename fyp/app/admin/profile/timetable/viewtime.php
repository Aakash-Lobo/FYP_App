<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT id, course_code, TIME_FORMAT(timing_from,'%h:%i %p') as timing_from, TIME_FORMAT(timing_to,'%h:%i %p') as timing_to, semester, day_name, day_id, day, subject_code, room_no FROM time_table tt INNER JOIN weekdays wd ON tt.day=wd.day_id";
$result = $conn->query($query);

$data = array();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

echo json_encode($data);

$conn->close();
?>