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
    parse_str(file_get_contents('php://input'), $_DELETE);

    // Check if the 'teacher_id' parameter is set in the request body or query parameters
    $teacherId = isset($_DELETE['teacher_id']) ? $_DELETE['teacher_id'] : $_GET['teacher_id'];

    if (!empty($teacherId)) {
        // Perform the delete operation
        $query = "DELETE FROM teacher_info WHERE teacher_id = '$teacherId'";
        $result = mysqli_query($con, $query);

        if ($result) {
            // Successful deletion
            echo json_encode(['message' => 'Teacher deleted successfully']);
        } else {
            // Error in deletion
            echo json_encode(['message' => 'Failed to delete teacher']);
        }
    } else {
        // 'teacher_id' parameter not set
        echo json_encode(['message' => 'Missing teacher_id parameter']);
    }
} else {
    // Invalid request method
    echo json_encode(['message' => 'Invalid request method']);
}

mysqli_close($con);
?>
