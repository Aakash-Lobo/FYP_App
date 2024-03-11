<?php
// Allow requests from any origin
header("Access-Control-Allow-Origin: *");

// Allow DELETE requests and preflight OPTIONS requests
header("Access-Control-Allow-Methods: DELETE, OPTIONS");

// Allow specific headers
header("Access-Control-Allow-Headers: Content-Type");

// Set Content-Type to application/json
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
    // Extract the request body
    $data = json_decode(file_get_contents("php://input"));

    // Extract the exam id from the request body
    $examId = $data->examId;

    if (!empty($examId)) {
        // Ensure $examId is an integer
        $examId = intval($examId);

        // Perform the delete operation
        $query = "DELETE FROM exam_tbl WHERE ex_id = '$examId'";
        $result = mysqli_query($con, $query);

        if ($result) {
            // Successful deletion
            http_response_code(200);
            echo json_encode(['message' => 'Exam deleted successfully']);
        } else {
            // Error in deletion
            $error_message = mysqli_error($con);
            error_log("Failed to delete exam. Error: $error_message");
            http_response_code(500); // Internal Server Error
            echo json_encode(['message' => 'Failed to delete exam']);
        }
    } else {
        // 'examId' parameter not set
        http_response_code(400); // Bad Request
        echo json_encode(['message' => 'Missing examId parameter']);
    }
} else {
    // Invalid request method
    http_response_code(405); // Method Not Allowed
    echo json_encode(['message' => 'Invalid request method']);
}

mysqli_close($con);
?>
