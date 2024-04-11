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
// $username = $_GET['username'];
$username = "1";

// Query to select prescription details for the given username
$query = "SELECT doctor, ID, appdate, apptime, disease, allergy, prescription FROM health_prestb WHERE pid='$username';";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$prescriptions = array();

while ($row = mysqli_fetch_assoc($result)) {
    $prescriptions[] = $row;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($prescriptions);

// Close connection
mysqli_close($con);
?>
