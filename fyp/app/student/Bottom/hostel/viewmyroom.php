<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

// Establish connection
$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Fetch username from the request
$username = $_GET['username'];

// Query to select room details for the user with the given username
$query = "SELECT * FROM roomregistration WHERE emailid = '$username'";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$roomData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $roomData[] = $row;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($roomData);

// Close connection
mysqli_close($con);
?>
