<?php
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$allowedBooksId = $_POST['allowed_book_id'];
$qnttyBooks = $_POST['qntty_books'];

$query = "UPDATE allowed_book SET qntty_books = $qnttyBooks";

if (mysqli_query($con, $query)) {
    echo "Updated successfully";
} else {
    echo "Error updating record: " . mysqli_error($con);
}

mysqli_close($con);
?>
