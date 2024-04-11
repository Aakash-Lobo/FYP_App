<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}
// $doctor = $row['doctor'];
$doctor = "ryan"; // Update with the doctor's name or ID
$query = "SELECT pid, fname, lname, ID, appdate, apptime, disease, allergy, prescription FROM counsel_prestb WHERE counsel='$doctor'";
$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$prescriptionsData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $prescriptionsData[] = $row;
}

header('Content-Type: application/json');
echo json_encode($prescriptionsData);

mysqli_close($con);
?>
