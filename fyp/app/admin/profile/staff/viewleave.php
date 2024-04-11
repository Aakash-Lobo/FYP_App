<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// $leaveId = "2";

$query = "SELECT tblleaves.id as lid,staff_info.first_name,staff_info.last_name,staff_info.staff_id,staff_info.staff_id,staff_info.gender,staff_info.other_phone,staff_info.email,tblleaves.LeaveType,tblleaves.ToDate,tblleaves.FromDate,tblleaves.Description,tblleaves.PostingDate,tblleaves.Status,tblleaves.AdminRemark,tblleaves.AdminRemarkDate FROM tblleaves JOIN staff_info ON tblleaves.empid=staff_info.staff_id";
$run = mysqli_query($con, $query);

$leaveData = [];
while ($row = mysqli_fetch_assoc($run)) {
    // Convert 'Status' field to integer
    $row['Status'] = (int)$row['Status'];
    $leaveData[] = $row;
}

header('Content-Type: application/json');
echo json_encode($leaveData);
?>
