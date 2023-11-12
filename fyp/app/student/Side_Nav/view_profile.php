<?php
$servername = 'localhost';
$dbUsername = 'root';
$dbPassword = '';
$dbName = 'fyp';

// Create a database connection
$connection = mysqli_connect($servername, $dbUsername, $dbPassword, $dbName);

if (!$connection) {
    // Handle database connection error
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Database connection error']);
} else {
    if (isset($_POST['username'])) {
        $username = $_POST['username'];

        // Query the database to fetch user profile data
        $query = "SELECT * FROM student_info WHERE email = '$username'";
        $result = mysqli_query($connection, $query);

        if ($result) {
            $userData = mysqli_fetch_assoc($result);

            // Return the user profile data as JSON
            header('Content-Type: application/json');
            echo json_encode($userData);
        } else {
            // Handle database query error
            header('Content-Type: application/json');
            echo json_encode(['error' => 'Failed to fetch user profile data']);
        }
    } else {
        // Handle missing username
        header('Content-Type: application/json');
        echo json_encode(['error' => 'Username not provided']);
    }

    // Close the database connection
    mysqli_close($connection);
}
?>
