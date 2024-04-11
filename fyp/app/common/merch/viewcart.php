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
// $username = 'aakash@gmail.com';
// Fetch username from the request
$username = $_GET['username'];
$sql = "SELECT merch_viewcart.* FROM merch_viewcart INNER JOIN student_info ON merch_viewcart.userId = student_info.roll_no WHERE student_info.email= '$username'";
$result = mysqli_query($conn, $sql);
$cartItems = array();
$totalPrice = 0.0;
$counter = 0;

while($row = mysqli_fetch_assoc($result)) {
    $productId = $row['productId'];
    $quantity = $row['itemQuantity'];
    $productSql = "SELECT * FROM `merch_product` WHERE productId = $productId";
    $productResult = mysqli_query($conn, $productSql);
    $productRow = mysqli_fetch_assoc($productResult);
    $productName = $productRow['productName'];
    $productPrice = $productRow['productPrice'];
    $total = $productPrice * $quantity;
    $counter++;
    $totalPrice += $total;

    $cartItems[] = array(
        'productId' => $productId,
        'productName' => $productName,
        'productPrice' => $productPrice,
        'itemQuantity' => $quantity
    );
}

$response = array(
    'items' => $cartItems,
    'totalPrice' => $totalPrice
);

echo json_encode($response);

?>