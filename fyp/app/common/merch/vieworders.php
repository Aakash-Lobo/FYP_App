<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

// Establish connection
$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Fetch username from the request
$username = $_GET['username'];
// $username = 'aakash@gmail.com';
$sql = "SELECT merch_orders.* FROM `merch_orders` INNER JOIN student_info ON merch_orders.userId = student_info.roll_no WHERE student_info.email= '$username'";
$result = mysqli_query($conn, $sql);
$orders = array();

while($row = mysqli_fetch_assoc($result)) {
    $orders[] = $row;
}

$response = array('orders' => $orders);
echo json_encode($response);
// } else {
// echo json_encode(array('error' => 'Username parameter is missing'));
// }
?>
