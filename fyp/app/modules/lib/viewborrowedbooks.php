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
            borrow_book.date_borrowed,
            borrow_book.due_date,
            borrow_book.date_returned,
            borrow_book.borrowed_status
          FROM
            borrow_book
          LEFT JOIN
            book ON borrow_book.book_id = book.book_id
          LEFT JOIN
            student_info ON borrow_book.user_id = student_info.roll_no
          WHERE
            borrow_book.borrowed_status = 'borrowed'";

if ($dateFrom != null && $dateTo != null) {
    $query .= " AND DATE(borrow_book.date_borrowed) BETWEEN '$dateFrom' AND '$dateTo'";
}

$query .= " ORDER BY borrow_book.date_borrowed DESC";

$result = mysqli_query($con, $query);

if ($result) {
    $borrowedBooks = array();

    while ($row = mysqli_fetch_assoc($result)) {
        $borrowedBooks[] = $row;
    }

    header('Content-Type: application/json');
    echo json_encode($borrowedBooks);
} else {
    http_response_code(500);
    echo json_encode(array('error' => 'Internal Server Error'));
}

mysqli_close($con);
?>
