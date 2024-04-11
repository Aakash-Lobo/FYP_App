<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

// Get doctor from the POST request
$username = $_POST['username'];

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Fetch appointment details
$appdate = $_POST['appdate'];
$apptime = $_POST['apptime'];
$disease = $_POST['disease'];
$allergy = $_POST['allergy'];
$fname = $_POST['fname'];
$lname = $_POST['lname'];
$pid = $_POST['pid'];
$ID = $_POST['ID'];
$prescription = $_POST['prescription'];

// Insert prescription into database
$query = mysqli_query($con, "INSERT INTO health_prestb (doctor, pid, ID, fname, lname, appdate, apptime, disease, allergy, prescription) VALUES ('$username', '$pid', '$ID', '$fname', '$lname', '$appdate', '$apptime', '$disease', '$allergy', '$prescription')");

if ($query) {
    echo "<script>alert('Prescribed successfully!');</script>";
} else {
    echo "<script>alert('Unable to process your request. Try again!');</script>";
}

mysqli_close($con);
?>
