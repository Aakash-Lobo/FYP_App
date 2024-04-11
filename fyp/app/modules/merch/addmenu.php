<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Retrieve POST data
$name = $_POST["name"];
$description = $_POST["description"];
$categoryId = $_POST["categoryId"];
$price = $_POST["price"];

// Establish database connection
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Replace with your actual database name

$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Prepare SQL statement
$sql = "INSERT INTO `merch_product` (`productName`, `productPrice`, `productDesc`, `productCategorieId`, `productPubDate`) VALUES ('$name', '$price', '$description', '$categoryId', current_timestamp())";

// Execute SQL statement
if (mysqli_query($conn, $sql)) {
    echo "product added successfully";
} else {
    echo "Error: " . $sql . "<br>" . mysqli_error($conn);
}

// Close connection
mysqli_close($conn);
?>
