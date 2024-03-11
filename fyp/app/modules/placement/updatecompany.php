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

    $companyId = isset($data['COMPANYID']) ? $data['COMPANYID'] : null;
    $updatedName = isset($data['COMPANYNAME']) ? $data['COMPANYNAME'] : null;
    $updatedContact = isset($data['COMPANYCONTACTNO']) ? $data['COMPANYCONTACTNO'] : null;

    if ($companyId != null && $updatedName != null && $updatedContact != null) {
        // Update the company in the database
        $query = "UPDATE tblcompany SET COMPANYNAME = '$updatedName', COMPANYCONTACTNO = '$updatedContact' WHERE COMPANYID = $companyId";

        if (mysqli_query($con, $query)) {
            $response = array('status' => 'success', 'message' => 'Company updated successfully');
        } else {
            $response = array('status' => 'error', 'message' => 'Error updating company: ' . mysqli_error($con));
        }
    } else {
        $response = array('status' => 'error', 'message' => 'Invalid data received');
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
