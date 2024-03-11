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
$username = $_GET['username'];

// Query to select orders made by the user with the given username using INNER JOIN
$query = "SELECT * FROM cafe_orders 
          INNER JOIN student_info ON cafe_orders.userId = student_info.roll_no 
          INNER JOIN login ON student_info.email = login.username  
          WHERE login.username = '$username'";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$ordersData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $ordersData[] = $row;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($ordersData);

// Close connection
mysqli_close($con);
?>
