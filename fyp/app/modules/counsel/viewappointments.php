<?php
header('Content-Type: application/json');

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Update with your database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT pid, fname, lname, gender, email, contact, appdate, apptime, userStatus, counselStatus FROM counsel_appointmenttb";
$result = mysqli_query($con, $query);

$appointments = [];
while ($row = mysqli_fetch_assoc($result)) {
    $appointments[] = $row;
}

echo json_encode($appointments);

mysqli_close($con);
?>
