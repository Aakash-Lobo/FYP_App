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

// Read the request body
$request_data = json_decode(file_get_contents("php://input"), true);

// Implement your logic to update exam details based on $request_data
// For example:
$examId = $request_data['examId'];
$courseName = $request_data['courseName'];
$examTitle = $request_data['examTitle'];
$examDescription = $request_data['examDescription'];
$examTimeLimit = $request_data['examTimeLimit'];
$displayLimit = $request_data['displayLimit'];

// Update the database or perform any other actions

// Respond with a success message
$response = ['message' => 'Exam details updated successfully'];
echo json_encode($response);
?>
