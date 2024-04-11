<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$roletype = $_POST['roletype'];

// Query to insert role into the roles table
$query = "INSERT INTO roles (roletype) VALUES ('$roletype')";

if (mysqli_query($con, $query)) {
    echo "Role added successfully";
} else {
    echo "Error: " . mysqli_error($con);
}

// Close connection
mysqli_close($con);
?>