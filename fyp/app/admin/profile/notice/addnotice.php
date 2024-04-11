<?php
// courses.php

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}
$title = $_POST['title'];
$message = $_POST['message'];

// Query to insert notice into main_notice table
$query = "INSERT INTO main_notice (post_date, to_whom, title, message) VALUES (NOW(), 'All', '$title', '$message')";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

echo "Notice added successfully";

// Close connection
mysqli_close($con);
?>