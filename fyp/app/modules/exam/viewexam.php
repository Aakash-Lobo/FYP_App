<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT * FROM exam_tbl ORDER BY ex_id DESC";
$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$examsData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $examsData[] = $row;
}

header('Content-Type: application/json');
echo json_encode($examsData);

mysqli_close($con);
?>
