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

// Fetch username from the appointmenttb
$username = $_GET['username'];

// Query to select appointments for the user
$query = "SELECT ID, doctor, docFees, appdate, apptime, userStatus, doctorStatus FROM health_appointmenttb WHERE email = '$username'";
$result = mysqli_query($con, $query);

$appointmentsData = array();

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$cnt = 1;
while ($row = mysqli_fetch_assoc($result)) {
    $appointmentsData[] = $row;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($appointmentsData);

// Close connection
mysqli_close($con);
?>
