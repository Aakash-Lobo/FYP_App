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

// Select companies from the database
$sql = "SELECT * FROM `tblcompany` c, `tbljobregistration` r, `tbljob` j WHERE c.`COMPANYID`=r.`COMPANYID` AND r.`JOBID`=j.`JOBID`";
$result = $conn->query($sql);

// Fetch data and encode to JSON format
$data = array();
if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    $data[] = $row;
  }
  echo json_encode($data);
} else {
  echo "0 results";
}
$conn->close();
?>