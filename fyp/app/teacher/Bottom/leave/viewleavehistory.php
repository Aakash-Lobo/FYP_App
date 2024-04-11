<?php
header('Content-Type: application/json');

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Replace with your actual database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    // $username = "staff@gmail.com";
    
    // Fetch leave history for the specified username
    $sql = "SELECT LeaveType, ToDate, FromDate, Description, PostingDate, AdminRemarkDate, AdminRemark, Status FROM tblleaves WHERE empid = (SELECT teacher_id FROM teacher_info WHERE email = ?)";
    $stmt = mysqli_prepare($con, $sql);
    mysqli_stmt_bind_param($stmt, "s", $username);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    $leaveHistory = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $leaveHistory[] = $row;
    }

    // Send the leave history data as JSON response
    echo json_encode($leaveHistory);
// } 
// else {
//     // Invalid request method
//     echo json_encode(['error' => 'Invalid request method']);
// }

mysqli_close($con);
?>
