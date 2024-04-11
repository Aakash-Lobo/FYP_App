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

// Select attempted exams from the database
$query = "SELECT et.ex_title, et.ex_description, ea.examat_id
          FROM exam_tbl et
          INNER JOIN exam_attempt ea ON et.ex_id = ea.exam_id
          INNER JOIN student_info si ON ea.exmne_id = si.roll_no
          WHERE si.email = '$roll_no'
          ORDER BY ea.examat_id";

$result = mysqli_query($con, $query);

if (!$result) {
    die("Query failed: " . mysqli_error($con));
}

$examsData = array();

while ($row = mysqli_fetch_assoc($result)) {
    $examData = array(
        'exam_title' => $row['ex_title'],
        'exam_description' => $row['ex_description'],
        'examat_id' => $row['examat_id']
    );
    $examsData[] = $examData;
}

// Set response header and send JSON encoded data
header('Content-Type: application/json; charset=utf-8');
echo json_encode($examsData, JSON_UNESCAPED_UNICODE);

// Close connection
mysqli_close($con);
?>
