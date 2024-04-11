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

// Fetch roll number from the request
$roll_no = $_GET['roll_no']; // Assuming you pass roll number as a parameter

if ($roll_no === null) {
    // Handle the case where roll number parameter is not provided
    die("Error: Roll number parameter is required");
}

// Select all exams from the database
$query = "SELECT * FROM exam_tbl";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$examsData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $examData = array(
        'ex_title' => $row['ex_title'],
        'ex_description' => $row['ex_description'],
        'ex_id' => $row['ex_id']
    );
    $examsData[] = $examData;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json; charset=utf-8');
echo json_encode($examsData, JSON_UNESCAPED_UNICODE);

// Close connection
mysqli_close($con);
?>
