<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve POST data
    $name = $_POST["name"];
    $desc = $_POST["desc"];

    // Establish database connection
    $host = "localhost";
    $username = "root";
    $password = "";
    $database = "fyp";

    $conn = mysqli_connect($host, $username, $password, $database);

    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }

    // Prepare SQL statement
    $sql = "INSERT INTO `merch_categories` (`categorieName`, `categorieDesc`) VALUES ('$name', '$desc')";

    // Execute SQL statement
    if (mysqli_query($conn, $sql)) {
        echo "Category added successfully";
    } else {
        echo "Error: " . $sql . "<br>" . mysqli_error($conn);
    }

    // Close connection
    mysqli_close($conn);
} else {
    echo "Only POST requests are allowed";
}
?>
