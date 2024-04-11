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

$sql = "SELECT * FROM `merch_product`";
$result = mysqli_query($conn, $sql);

$pizzas = array();

while ($row = mysqli_fetch_assoc($result)) {
    $pizzas[] = $row;
}

header('Content-Type: application/json');
echo json_encode($pizzas);

// Close database connection
mysqli_close($conn);
?>
