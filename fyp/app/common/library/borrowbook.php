<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

// Establish connection
$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Fetch username from the request
$bookTitle = $_POST['book_title'] ?? '';
$author = $_POST['author'] ?? '';

// Fetch user ID from the request (assuming it's passed from Dart)
$username = $_POST['username'] ?? '';

// Perform borrowing logic
if (!empty($bookTitle) && !empty($author) && !empty($username)) {
    // Fetch user ID from database based on username
    $userIdQuery = "SELECT roll_no FROM users WHERE username = '$username'";
    $userIdResult = mysqli_query($con, $userIdQuery);

    if ($userIdResult && mysqli_num_rows($userIdResult) > 0) {
        $row = mysqli_fetch_assoc($userIdResult);
        $userId = $row['roll_no'];

        // Perform SQL insert to borrow book
        $borrowDate = date('Y-m-d');
        $dueDate = date('Y-m-d', strtotime('+7 days')); // Example due date (7 days from borrow date)

        $insertQuery = "INSERT INTO borrow_book (user_id, book_title, author, date_borrowed, due_date, borrowed_status) VALUES ('$userId', '$bookTitle', '$author', '$borrowDate', '$dueDate', 'borrowed')";

        if (mysqli_query($con, $insertQuery)) {
            // Book borrowed successfully
            echo json_encode(array('message' => 'Book borrowed successfully'));
        } else {
            // Failed to borrow book
            echo json_encode(array('error' => 'Failed to borrow book'));
        }
    } else {
        // User not found
        echo json_encode(array('error' => 'User not found'));
    }
} else {
    // Invalid request
    echo json_encode(array('error' => 'Invalid request'));
}

mysqli_close($con);
?>
