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
$username = $_GET['username'];

// Query to select books borrowed by the user with the given username
$query = "SELECT * FROM book 
          INNER JOIN borrow_book ON book.book_id = borrow_book.book_id 
          INNER JOIN student_info ON borrow_book.user_id = student_info.roll_no 
          INNER JOIN login ON student_info.email = login.username 
          WHERE login.username = '$username' AND borrow_book.borrowed_status = 'borrowed'";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$booksData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $booksData[] = $row;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json');
echo json_encode($booksData);

// Close connection
mysqli_close($con);
?>
