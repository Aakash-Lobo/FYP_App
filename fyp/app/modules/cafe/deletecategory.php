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

    $catId = isset($data['catId']) ? $data['catId'] : null;

    if ($catId != null) {
        // Delete the category from the database
        $query = "DELETE FROM cafe_categories WHERE categorieId = $catId";

        if (mysqli_query($con, $query)) {
            $response = array('status' => 'success', 'message' => 'Category deleted successfully');
        } else {
            $response = array('status' => 'error', 'message' => 'Error deleting category: ' . mysqli_error($con));
        }
    } else {
        $response = array('status' => 'error', 'message' => 'Missing catId parameter');
    }
} else {
    // Invalid request method
    $response = array('status' => 'error', 'message' => 'Invalid request method');
}

// Send a clean JSON response
header('Content-Type: application/json');
echo json_encode($response);

mysqli_close($con);
?>
