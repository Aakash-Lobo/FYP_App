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

$query = "SELECT * FROM `student_info` ORDER BY roll_no DESC";
$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$examineesData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $examineesData[] = $row;
}

header('Content-Type: application/json');
echo json_encode($examineesData);

mysqli_close($con);
?>
