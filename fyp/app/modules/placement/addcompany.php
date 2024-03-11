<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Replace with your actual database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the POST parameters (sanitize inputs)
    $companyName = mysqli_real_escape_string($con, $_POST['COMPANYNAME']);
    $companyAddress = mysqli_real_escape_string($con, $_POST['COMPANYADDRESS']);
    $companyContactNo = mysqli_real_escape_string($con, $_POST['COMPANYCONTACTNO']);

    // Perform the insert operation with prepared statement
    $companyInsertQuery = "INSERT INTO `tblcompany` (`COMPANYNAME`, `COMPANYADDRESS`, `COMPANYCONTACTNO`) 
        VALUES ('$companyName', '$companyAddress', '$companyContactNo')";

    $result = mysqli_query($con, $companyInsertQuery);

    if ($result) {
        // Successful insertion
        echo json_encode(['message' => 'Company added successfully']);
    } else {
        // Error in insertion
        echo json_encode(['message' => 'Failed to add company']);
    }
} else {
    // Invalid request method
    echo json_encode(['message' => 'Invalid request method']);
}

mysqli_close($con);
?>
