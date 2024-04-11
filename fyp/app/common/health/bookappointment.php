<?php
// Database connection
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Fetching session data
session_start();
$pid = $_SESSION['pid'];
$username = $_SESSION['username'];
$email = $_SESSION['email'];
$fname = $_SESSION['fname'];
$lname = $_SESSION['lname'];
$gender = $_SESSION['gender'];
$contact = $_SESSION['contact'];
$doctor = $_POST['doctor'];
$email = $_SESSION['email'];
$docFees = $_POST['docFees'];
$appdate = $_POST['appdate'];
$apptime = $_POST['apptime'];

// Insert appointment into the database
$query = mysqli_query($con, "INSERT INTO health_appointmenttb(pid, fname, lname, gender, email, contact, doctor, docFees, appdate, apptime, userStatus, doctorStatus) VALUES($pid, '$fname', '$lname', '$gender', '$email', '$contact', '$doctor', '$docFees', '$appdate', '$apptime', '1', '1')");

if ($query) {
    echo "<script>alert('Appointment booked successfully!');</script>";
} else {
    echo "<script>alert('Unable to book the appointment. Please try again.');</script>";
}

// Close connection
mysqli_close($con);
?>
