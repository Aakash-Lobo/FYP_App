<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve data from POST request
    $data = json_decode(file_get_contents("php://input"), true);

    $pizzaId = isset($data['pizzaId']) ? $data['pizzaId'] : null;

    if ($pizzaId != null) {
        // Delete the pizza from the database
        $deleteSql = "DELETE FROM `pizza` WHERE pizzaId = $pizzaId";

        if (mysqli_query($conn, $deleteSql)) {
            $response = array('status' => 'success', 'message' => 'Pizza deleted successfully');
        } else {
            $response = array('status' => 'error', 'message' => 'Error deleting pizza: ' . mysqli_error($conn));
        }
    } else {
        $response = array('status' => 'error', 'message' => 'Missing pizzaId parameter');
    }

    // Send a clean JSON response
    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    // Invalid request method
    $response = array('status' => 'error', 'message' => 'Invalid request method');

    // Send a clean JSON response
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close database connection
mysqli_close($conn);
?>
