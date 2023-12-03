<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT classname FROM book_category";
$run = mysqli_query($con, $query);

if ($run) {
    $categories = [];
    while ($row = mysqli_fetch_assoc($run)) {
        $categories[] = $row;
    }

    http_response_code(200);
    echo json_encode($categories);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch categories']);
}

mysqli_close($con);
?>
