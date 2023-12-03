<?php
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$penaltyQuery = mysqli_query($con, "SELECT * FROM penalty");

// Fetch penalties into an array
$penalties = array();
while ($row = mysqli_fetch_assoc($penaltyQuery)) {
    $penalties[] = $row;
}

// Return the data in a consistent format
$response = array('data' => $penalties);
echo json_encode($response);

?>
