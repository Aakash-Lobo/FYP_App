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

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Retrieve data from DELETE request
    $data = json_decode(file_get_contents("php://input"), true);

    $jobId = isset($data['job_id']) ? $data['job_id'] : null;

    if ($jobId != null) {
        // Delete the job from the database
        $query = "DELETE FROM tbljob WHERE JOBID = $jobId";

        if (mysqli_query($con, $query)) {
            $response = array('status' => 'success', 'message' => 'Job deleted successfully');
        } else {
            $response = array('status' => 'error', 'message' => 'Error deleting job: ' . mysqli_error($con));
        }
    } else {
        $response = array('status' => 'error', 'message' => 'Missing job_id parameter');
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
