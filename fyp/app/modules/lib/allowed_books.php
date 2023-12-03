<?php
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$allowedBooksQuery = mysqli_query($con, "SELECT * FROM allowed_book");

// Fetch allowed books into an array
$allowedBooks = array();
while ($row = mysqli_fetch_assoc($allowedBooksQuery)) {
    $allowedBooks[] = $row;
}

// Return the data in a consistent format
$response = array('data' => $allowedBooks);
echo json_encode($response);

?>
