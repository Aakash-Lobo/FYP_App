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

// Extract room details from $request_data
$roomId = $request_data['roomId'];
$roomNo = $request_data['roomNo'];
$seater = $request_data['seater'];
$fees = $request_data['fees'];

// Implement your logic to update room details based on $request_data
// For example:
$query = "UPDATE rooms SET room_no=?, seater=?, fees=? WHERE id=?";
$stmt = $con->prepare($query);
$stmt->bind_param('sssi', $roomNo, $seater, $fees, $roomId);
$result = $stmt->execute();

if ($result) {
    // Respond with a success message
    echo json_encode(['message' => 'Room details updated successfully']);
} else {
    // Respond with an error message
    echo json_encode(['message' => 'Failed to update room details']);
}

$stmt->close();
mysqli_close($con);
?>
