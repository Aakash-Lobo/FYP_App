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

    // Extract the company id from the request body
    $companyId = $data->COMPANYID;

    if (!empty($companyId)) {
        // Perform the delete operation
        $query = "DELETE FROM tblcompany WHERE COMPANYID = '$companyId'";
        $result = mysqli_query($con, $query);

        if ($result) {
            // Successful deletion
            http_response_code(200);
            echo json_encode(['message' => 'Company deleted successfully']);
        } else {
            // Error in deletion
            $error_message = mysqli_error($con);
            error_log("Failed to delete company. Error: $error_message");
            http_response_code(500); // Internal Server Error
            echo json_encode(['message' => 'Failed to delete company']);
        }
    } else {
        // 'company_id' parameter not set
        http_response_code(400); // Bad Request
        echo json_encode(['message' => 'Missing company_id parameter']);
    }
} else {
    // Invalid request method
    http_response_code(405); // Method Not Allowed
    echo json_encode(['message' => 'Invalid request method']);
}

mysqli_close($con);
?>
