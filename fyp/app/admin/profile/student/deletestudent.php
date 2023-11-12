<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Extract the roll number from the URL
    $rollNo = $_GET['roll_no'];

    // Perform the deletion based on the $rollNo
    $deleteQuery = "DELETE FROM student_info WHERE roll_no = '$rollNo'";
    $deleteResult = mysqli_query($con, $deleteQuery);

    if ($deleteResult) {
        // Successful deletion
        http_response_code(200);
        echo json_encode(['message' => 'Student deleted successfully']);
    } else {
        // Error in deletion
        http_response_code(500);
        echo json_encode(['error' => 'Failed to delete student']);
    }
} else {
    // Invalid request method
    http_response_code(405);
    echo json_encode(['error' => 'Invalid request method']);
}

mysqli_close($con);
?>
