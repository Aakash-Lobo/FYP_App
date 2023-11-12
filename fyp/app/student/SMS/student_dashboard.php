<?php
$servername = 'localhost';
$dbUsername = 'root';
$dbPassword = '';
$dbName = 'fyp';

// Get the username from the Flutter app
if (isset($_POST['username'])) {
    $username = $_POST['username'];

    // Query the database to fetch the student name
    $studentName = ''; // Initialize with an empty string

    // Establish a database connection (you should replace these with your database credentials)
    $servername = 'localhost';
    $dbUsername = 'root';
    $dbPassword = '';
    $dbName = 'fyp';

    $connection = new mysqli($servername, $dbUsername, $dbPassword, $dbName);

    if ($connection->connect_error) {
        die('Connection failed: ' . $connection->connect_error);
    }

    // Fetch the student name based on the provided username
    $studentDataQuery = "SELECT first_name, middle_name, last_name FROM student_info WHERE email = '$username'";
    $studentDataResult = $connection->query($studentDataQuery);

    if ($studentDataResult->num_rows > 0) {
        $row = $studentDataResult->fetch_assoc();
        $studentName = $row['first_name'] . ' ' . $row['middle_name'] . ' ' . $row['last_name'];
    }

    // Close the database connection
    $connection->close();

    if (!empty($studentName)) {
        $response = [
            'studentName' => $studentName,
        ];

        // Return the JSON response
        header('Content-Type: application/json');
        echo json_encode($response);
    } else {
        // Handle cases where the username doesn't exist or data retrieval fails
        header('Content-Type: application/json');
        echo json_encode(['error' => 'Failed to fetch student data']);
    }
} else {
    // Handle missing username
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Username not provided']);
}
?>
