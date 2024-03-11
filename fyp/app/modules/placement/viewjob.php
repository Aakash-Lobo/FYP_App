<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT * FROM `tbljob` j, `tblcompany` c WHERE j.COMPANYID=c.COMPANYID";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$jobsData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $jobsData[] = $row;
}

header('Content-Type: application/json');

if (empty($jobsData)) {
    echo json_encode(['message' => 'No data found']);
} else {
    echo json_encode($jobsData);
}

mysqli_close($con);
?>
