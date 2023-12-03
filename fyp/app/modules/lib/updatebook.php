<?php
// Allow from any origin
if (isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Max-Age: 86400');    // cache for 1 day
}

// Access-Control headers are received during OPTIONS requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS");         

    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    exit(0);
}

$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Retrieve data from POST request
$data = json_decode(file_get_contents("php://input"), true);

$bookId = isset($data['book_id']) ? $data['book_id'] : null;
$updatedTitle = isset($data['book_title']) ? $data['book_title'] : null;
$updatedAuthor = isset($data['author']) ? $data['author'] : null;

if ($bookId != null && $updatedTitle != null && $updatedAuthor != null) {
    // Update the book in the database
    $query = "UPDATE book SET book_title = '$updatedTitle', author = '$updatedAuthor' WHERE book_id = $bookId";

    if (mysqli_query($con, $query)) {
        $response = array('status' => 'success', 'message' => 'Book updated successfully');
    } else {
        $response = array('status' => 'error', 'message' => 'Error updating book: ' . mysqli_error($con));
    }
} else {
    $response = array('status' => 'error', 'message' => 'Invalid data received');
}

// Send a clean JSON response
header('Content-Type: application/json');
echo json_encode($response);

mysqli_close($con);
?>
