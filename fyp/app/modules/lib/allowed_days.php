<?php
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$allowedDaysQuery = mysqli_query($con, "SELECT * FROM allowed_days");

// Fetch allowed days into an array
$allowedDays = array();
while ($row = mysqli_fetch_assoc($allowedDaysQuery)) {
    $allowedDays[] = $row;
}

// Return the data in a consistent format
$response = array('data' => $allowedDays);
echo json_encode($response);

?>
