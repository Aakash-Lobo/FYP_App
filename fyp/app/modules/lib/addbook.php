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
    $bookTitle = mysqli_real_escape_string($con, $_POST['bookTitle']);
    $author = mysqli_real_escape_string($con, $_POST['author']);
    $author2 = mysqli_real_escape_string($con, $_POST['author2']);
    $publication = mysqli_real_escape_string($con, $_POST['publication']);
    $publisherName = mysqli_real_escape_string($con, $_POST['publisherName']);
    $isbn = mysqli_real_escape_string($con, $_POST['isbn']);
    $copyrightYear = mysqli_real_escape_string($con, $_POST['copyrightYear']);
    $bookCopies = mysqli_real_escape_string($con, $_POST['bookCopies']);
    $category = mysqli_real_escape_string($con, $_POST['category']);

    // Perform the insert operation with prepared statement
    $query = "INSERT INTO `barcode` (`pre_barcode`, `mid_barcode`, `suf_barcode`) VALUES ('VNHS', '1', 'LMS')";
    mysqli_query($con, $query); // Assuming you're updating barcode information

    $newBarcodeQuery = "SELECT `mid_barcode` FROM `barcode` ORDER BY `mid_barcode` DESC LIMIT 1";
    $result = mysqli_query($con, $newBarcodeQuery);
    $row = mysqli_fetch_assoc($result);
    $newBarcode = $row['mid_barcode'] + 1;

    $bookBarcode = 'VNHS' . $newBarcode . 'LMS';

    $bookInsertQuery = "INSERT INTO `book` (`book_title`, `author`, `author_2`, `book_pub`, `publisher_name`, `isbn`, `copyright_year`, `book_copies`, `category_id`, `book_barcode`, `date_added`)
        VALUES ('$bookTitle', '$author', '$author2', '$publication', '$publisherName', '$isbn', '$copyrightYear', '$bookCopies', '$category', '$bookBarcode', NOW())";

    $result = mysqli_query($con, $bookInsertQuery);

    if ($result) {
        // Successful insertion
        echo json_encode(['message' => 'Book added successfully']);
    } else {
        // Error in insertion
        echo json_encode(['message' => 'Failed to add book']);
    }
} else {
    // Invalid request method
    echo json_encode(['message' => 'Invalid request method']);
}

mysqli_close($con);
?>
