<?php
$host = "localhost"; // Your MySQL host
$username = "root"; // Your MySQL username
$password = ""; // Your MySQL password
$dbname = "fyp"; // Your MySQL database name

$connection = new mysqli($host, $username, $password, $dbname);

if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}

$username = $_POST['username'];
$password = $_POST['password'];

$query = "SELECT * FROM login WHERE username = '$username' AND password = '$password'";
$result = $connection->query($query);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $role = $row["role"];
    echo json_encode(["success" => "Login successful", "role" => $role, "username" => $username]);
} else {
    echo json_encode(["error" => "Login failed"]);
}

$connection->close();
?>
