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

$query = "SELECT tblleaves.id as lid,teacher_info.first_name,teacher_info.last_name,teacher_info.teacher_id,teacher_info.teacher_id,teacher_info.gender,teacher_info.other_phone,teacher_info.email,tblleaves.LeaveType,tblleaves.ToDate,tblleaves.FromDate,tblleaves.Description,tblleaves.PostingDate,tblleaves.Status,tblleaves.AdminRemark,tblleaves.AdminRemarkDate FROM tblleaves JOIN teacher_info ON tblleaves.empid=teacher_info.teacher_id";
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
