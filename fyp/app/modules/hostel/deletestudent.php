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
$database = "fyp"; // Replace with your actual database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Extract the request body
    $data = json_decode(file_get_contents("php://input"));

    // Extract the student id from the request body
    $studentId = $data->studentId;

    if (!empty($studentId)) {
        // Ensure $studentId is an integer
        $studentId = intval($studentId);

        // Perform the delete operation
        $query = "DELETE FROM roomregistration WHERE id = '$studentId'";
        $result = mysqli_query($con, $query);

        if ($result) {
            // Successful deletion
            http_response_code(200);
            echo json_encode(['message' => 'Student deleted successfully']);
        } else {
            // Error in deletion
            $error_message = mysqli_error($con);
            error_log("Failed to delete student. Error: $error_message");
            http_response_code(500); // Internal Server Error
            echo json_encode(['message' => 'Failed to delete student']);
        }
    } else {
        // 'studentId' parameter not set
        http_response_code(400); // Bad Request
        echo json_encode(['message' => 'Missing studentId parameter']);
    }
} else {
    // Invalid request method
    http_response_code(405); // Method Not Allowed
    echo json_encode(['message' => 'Invalid request method']);
}

mysqli_close($con);
?>
