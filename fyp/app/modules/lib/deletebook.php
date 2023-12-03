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
    // Extract the request body
    $data = json_decode(file_get_contents("php://input"));

    // Extract the book id from the request body
    $bookId = $data->book_id;

    if (!empty($bookId)) {
        // Perform the delete operation
        $query = "DELETE FROM book WHERE book_id = '$bookId'";
        $result = mysqli_query($con, $query);

        if ($result) {
            // Successful deletion
            echo json_encode(['message' => 'Book deleted successfully']);
        } else {
            // Error in deletion
            $error_message = mysqli_error($con);
            error_log("Failed to delete book. Error: $error_message");
            echo json_encode(['message' => 'Failed to delete book']);
        }
    } else {
        // 'book_id' parameter not set
        echo json_encode(['message' => 'Missing book_id parameter']);
    }
} else {
    // Invalid request method
    echo json_encode(['message' => 'Invalid request method']);
}

mysqli_close($con);
?>
