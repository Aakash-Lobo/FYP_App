<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if (isset($_POST['roll_no'], $_POST['amount'], $_POST['status'])) {
    $rollNo = $_POST['roll_no'];
    $amount = $_POST['amount'];
    $status = $_POST['status'];

    $que = "INSERT INTO student_fee (roll_no, amount, status) VALUES (?, ?, ?)";
    $stmt = mysqli_prepare($con, $que);

    if ($stmt) {
        mysqli_stmt_bind_param($stmt, 'sss', $rollNo, $amount, $status);

        mysqli_stmt_execute($stmt);

        if (mysqli_stmt_affected_rows($stmt) > 0) {
            echo "Insert Successfully";
        } else {
            echo "Insert Not Successfully";
        }

        mysqli_stmt_close($stmt);
    } else {
        echo "Error in preparing statement: " . mysqli_error($con);
    }
}
?>
