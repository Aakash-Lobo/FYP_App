<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT staff_id, first_name, middle_name, last_name, current_address, hire_date, email FROM staff_info";
$run = mysqli_query($con, $query);

$teachersData = array();

while ($row = mysqli_fetch_assoc($run)) {
    $teachersData[] = $row;
}

echo json_encode($teachersData);
?>