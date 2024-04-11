<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Replace with your actual database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the POST parameters (sanitize inputs)
    $seater = mysqli_real_escape_string($con, $_POST['seater']);
    $roomno = mysqli_real_escape_string($con, $_POST['rmno']);
    $fees = mysqli_real_escape_string($con, $_POST['fee']);

    // Check if room already exists
    $checkRoomQuery = "SELECT room_no FROM rooms WHERE room_no = '$roomno'";
    $checkResult = mysqli_query($con, $checkRoomQuery);

    if (mysqli_num_rows($checkResult) > 0) {
        // Room already exists
        echo json_encode(['status' => 'error', 'message' => 'Room already exists']);
    } else {
        // Insert new room
        $insertRoomQuery = "INSERT INTO rooms (seater, room_no, fees) VALUES ('$seater', '$roomno', '$fees')";
        $insertResult = mysqli_query($con, $insertRoomQuery);

        if ($insertResult) {
            // Successful insertion
            echo json_encode(['status' => 'success', 'message' => 'Room added successfully']);
        } else {
            // Error in insertion
            echo json_encode(['status' => 'error', 'message' => 'Failed to add room']);
        }
    }
} else {
    // Invalid request method
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}

mysqli_close($con);
?>
