<?php  
header("Content-Type: application/json");
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// if (isset($_GET['username'])) {
    $username = $_GET['username'];

    $sql = "SELECT tbl_tasks.* FROM tbl_tasks
        INNER JOIN student_info ON tbl_tasks.u_id = student_info.roll_no
        WHERE student_info.email = '$username'";

    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        $tasks = array();

        while ($row = mysqli_fetch_assoc($result)) {
            $tasks[] = $row;
        }

        echo json_encode($tasks);
    } else {
        echo json_encode(array('message' => 'No tasks found for the specified user.'));
    }
// } else {
//     echo json_encode(array('message' => 'Username parameter is required.'));
// }

mysqli_close($conn);
?>
