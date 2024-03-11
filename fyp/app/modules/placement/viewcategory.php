<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT * FROM `tblcategory`";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$categoriesData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $categoriesData[] = $row;
}

header('Content-Type: application/json');

if (empty($categoriesData)) {
    echo json_encode(['message' => 'No data found']);
} else {
    echo json_encode($categoriesData);
}

mysqli_close($con);
?>
