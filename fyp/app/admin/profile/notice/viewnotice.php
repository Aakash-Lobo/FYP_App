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

$sql = "SELECT * FROM main_notice";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of each row
    $notices = array();
    while($row = $result->fetch_assoc()) {
        $notice = array(
            "id" => $row["nid"],
            "title" => $row["title"],
            "message" => $row["message"],
            // Add other fields as needed
        );
        array_push($notices, $notice);
    }
    // Encode notices array as JSON and output
    echo json_encode($notices);
} else {
    echo "0 results";
}

$conn->close();
?>