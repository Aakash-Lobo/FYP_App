<?php
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'fyp';

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$dateFrom = isset($_GET['dateFrom']) ? $_GET['dateFrom'] : null;
$dateTo = isset($_GET['dateTo']) ? $_GET['dateTo'] : null;

$query = "SELECT
            book.book_barcode,
            student_info.first_name,
            student_info.last_name,
            book.book_title,
            return_book.date_borrowed,
            return_book.due_date,
            return_book.date_returned,
            return_book.book_penalty
          FROM
            return_book
          LEFT JOIN
            student_info ON return_book.user_id = student_info.roll_no
          LEFT JOIN
            book ON return_book.book_id = book.book_id";

if ($dateFrom != null && $dateTo != null) {
    $query .= " WHERE DATE(return_book.date_returned) BETWEEN '$dateFrom' AND '$dateTo'";
}

$query .= " ORDER BY return_book.date_returned DESC";

$result = mysqli_query($con, $query);

if ($result) {
    $returnedBooks = array();

    while ($row = mysqli_fetch_assoc($result)) {
        $returnedBooks[] = $row;
    }

    header('Content-Type: application/json');
    echo json_encode($returnedBooks);
} else {
    http_response_code(500);
    echo json_encode(array('error' => 'Internal Server Error'));
}

mysqli_close($con);
?>
