<?php
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$allowedDaysId = $_POST['allowed_days_id'];
$noOfDays = $_POST['no_of_days'];

$query = "UPDATE allowed_days SET no_of_days = $noOfDays WHERE allowed_days_id = $allowedDaysId";

if (mysqli_query($con, $query)) {
    echo "Updated successfully";
} else {
    echo "Error updating record: " . mysqli_error($con);
}

mysqli_close($con);
?>
