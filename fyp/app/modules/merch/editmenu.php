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

// Handle POST request for editing pizza
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve data from POST request
    $data = json_decode(file_get_contents("php://input"), true);

    $pizzaId = isset($data['pizzaId']) ? $data['pizzaId'] : null;
    $newPizzaName = isset($data['newPizzaName']) ? $data['newPizzaName'] : null;
    $newPizzaDesc = isset($data['newPizzaDesc']) ? $data['newPizzaDesc'] : null;

    if ($pizzaId != null && $newPizzaName != null && $newPizzaDesc != null) {
        // Update the pizza in the database
        $updateSql = "UPDATE `merch_product` SET productName = '$newPizzaName', productDesc = '$newPizzaDesc' WHERE productId = $pizzaId";

        if (mysqli_query($conn, $updateSql)) {
            $response = array('status' => 'success', 'message' => ' updated successfully');
        } else {
            $response = array('status' => 'error', 'message' => 'Error updating : ' . mysqli_error($conn));
        }
    } else {
        $response = array('status' => 'error', 'message' => 'Missing parameters');
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
