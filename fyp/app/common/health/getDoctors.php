<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "hospitalms";

// Establish connection
$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Query to select doctors
$query = "SELECT username, fname, lname, spec FROM doctb";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$doctorsData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $doctorsData[] = $row;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($doctorsData);

// Close connection
mysqli_close($con);
?>
