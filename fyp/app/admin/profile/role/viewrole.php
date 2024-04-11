<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT * FROM roles";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$rolesData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $rolesData[] = $row;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($rolesData);

// Close connection
mysqli_close($con);
?>