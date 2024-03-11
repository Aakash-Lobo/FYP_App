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

// Query to select cart items for the user with the given username
$query = "SELECT cafe_product.productName, cafe_product.productPrice, viewcart.itemQuantity
          FROM cafe_product
          INNER JOIN viewcart ON cafe_product.productId = viewcart.productId
          INNER JOIN student_info ON viewcart.userId = student_info.roll_no
          INNER JOIN login ON student_info.email = login.username
          WHERE login.username = '$username'";

$result = mysqli_query($conn, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($conn));
}

$cartData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $cartData[] = $row;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($cartData);

// Close connection
mysqli_close($conn);
?>
