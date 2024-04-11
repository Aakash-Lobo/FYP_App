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
    $empid = $_POST['empid'];
    $leavetype = $_POST['leavetype'];
    $fromdate = $_POST['fromdate'];
    $todate = $_POST['todate'];
    $description = $_POST['description'];
    $status = 0;
    $isread = 0;

    // Check if the starting date is before the end date
    if ($fromdate > $todate) {
        echo json_encode(['error' => 'Please enter correct details: End Date should be after Starting Date.']);
        exit;
    }

    // Perform the insert operation with prepared statement
    $query = "INSERT INTO `tblleaves` (`LeaveType`, `ToDate`, `FromDate`, `Description`, `Status`, `IsRead`, `empid`) 
              VALUES (?, ?, ?, ?, ?, ?, ?)";

    $stmt = mysqli_prepare($con, $query);
    mysqli_stmt_bind_param($stmt, "ssssiis", $leavetype, $todate, $fromdate, $description, $status, $isread, $empid);

    if (mysqli_stmt_execute($stmt)) {
        // Successful insertion
        echo json_encode(['message' => 'Leave application submitted successfully']);
    } else {
        // Error in insertion
        echo json_encode(['error' => 'Failed to submit leave application']);
    }

    mysqli_stmt_close($stmt);
} else {
    // Invalid request method
    echo json_encode(['error' => 'Invalid request method']);
}

mysqli_close($con);
?>
