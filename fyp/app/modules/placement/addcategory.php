<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Replace with your actual database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the POST parameters (sanitize inputs)
    $category = mysqli_real_escape_string($con, $_POST['CATEGORY']);

    // Perform the insert operation with prepared statement
    $categoryInsertQuery = "INSERT INTO `tblcategory` (`category`) VALUES ('$category')";
    $result = mysqli_query($con, $categoryInsertQuery);

    if ($result) {
        // Successful insertion
        echo json_encode(['message' => 'Category added successfully']);
    } else {
        // Error in insertion
        echo json_encode(['message' => 'Failed to add category']);
    }
} else {
    // Invalid request method
    echo json_encode(['message' => 'Invalid request method']);
}

mysqli_close($con);
?>
