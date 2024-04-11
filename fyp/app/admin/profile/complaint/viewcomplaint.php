<?php
// courses.php

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT * FROM tblcomplaints";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$complaintsData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $complaintsData[] = $row;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($complaintsData);

// Close connection
mysqli_close($con);
?>