<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT * FROM book";
$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$studentsData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $studentsData[] = $row;
}

header('Content-Type: application/json');
echo json_encode($studentsData);

mysqli_close($con);
?>
