<?php  
header("Content-Type: application/json");

// Database connection
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";
$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Retrieve POST data
$taskName = $_POST['task_name'];
$taskDescription = $_POST['task_description'];
$priority = $_POST['priority'];
$deadline = $_POST['deadline'];
$username = $_POST['username'];

// Fetch student_info.roll_no based on username
$fetchRollNoQuery = "SELECT roll_no FROM student_info WHERE email = '$username'";
$rollNoResult = mysqli_query($conn, $fetchRollNoQuery);

if ($rollNoResult && mysqli_num_rows($rollNoResult) > 0) {
    $row = mysqli_fetch_assoc($rollNoResult);
    $rollNo = $row['roll_no'];

    // Insert task into tbl_tasks
    $insertTaskQuery = "INSERT INTO tbl_tasks (u_id,task_name, task_description, priority, deadline) 
                        VALUES ('$rollNo','$taskName', '$taskDescription', '$priority', '$deadline')";
    if (mysqli_query($conn, $insertTaskQuery)) {
        echo json_encode(array('message' => 'Task added successfully'));
    } else {
        echo json_encode(array('error' => 'Failed to add task'));
    }
} else {
    echo json_encode(array('error' => 'Failed to retrieve user information'));
}

// Close the database connection
mysqli_close($conn);
?>
