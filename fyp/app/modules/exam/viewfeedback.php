<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: *");

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT * FROM feedbacks_tbl ORDER BY fb_id DESC";
$result = mysqli_query($conn, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($conn));
}

$feedbackData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $feedbackData[] = $row;
}

header('Content-Type: application/json');
echo json_encode($feedbackData);

mysqli_close($conn);
?>
