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

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Replace with your actual database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Read the request body
$request_data = json_decode(file_get_contents("php://input"), true);

// Extract student details from $request_data
$studentId = $request_data['studentId'];
$firstName = $request_data['firstName'];
$middleName = $request_data['middleName'];
$lastName = $request_data['lastName'];
$regNo = $request_data['regNo'];

// Implement your logic to update student details based on $request_data
$query = "UPDATE roomregistration SET first_name=?, middle_name=?, last_name=?, reg_no=? WHERE id=?";
$stmt = $con->prepare($query);
$stmt->bind_param('ssssi', $firstName, $middleName, $lastName, $regNo, $studentId);
$result = $stmt->execute();

if ($result) {
    // Respond with a success message
    echo json_encode(['message' => 'Student details updated successfully']);
} else {
    // Respond with an error message
    echo json_encode(['message' => 'Failed to update student details']);
}

$stmt->close();
mysqli_close($con);
?>
