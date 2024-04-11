<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

// Establish connection
$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Select companies from the database
$query = "SELECT * FROM `tblcompany`";
$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$companies = array();

while ($row = mysqli_fetch_assoc($result)) {
    $company = array(
        'id' => $row['COMPANYID '],
        'name' => $row['COMPANYNAME'],
        'address' => $row['COMPANYADDRESS'],
        'contactNo' => $row['COMPANYCONTACTNO']
    );
    $companies[] = $company;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($companies);

// Close connection
mysqli_close($con);
?>
