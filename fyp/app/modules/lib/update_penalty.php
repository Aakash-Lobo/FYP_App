<?php
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$penaltyId = $_POST['penalty_id'];
$penaltyAmount = $_POST['penalty_amount'];

$updateQuery = mysqli_query($con, "UPDATE penalty SET penalty_amount = '$penaltyAmount' WHERE penalty_id = '$penaltyId'");

if ($updateQuery) {
    echo 'Penalty updated successfully';
} else {
    echo 'Failed to update penalty';
}

mysqli_close($con);
?>
