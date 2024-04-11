<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT tsr.salary_id, tsr.teacher_id, ti.first_name, ti.middle_name, ti.last_name, tsa.basic_salary, tsa.medical_allowance, tsa.hr_allowance, tsa.scale, DATE(tsr.paid_date) AS paid_date, tsr.total_amount FROM teacher_salary_report tsr INNER JOIN teacher_info ti ON tsr.teacher_id = ti.teacher_id INNER JOIN teacher_salary_allowances tsa ON ti.teacher_id = tsa.teacher_id";
$run = mysqli_query($con, $query);

$salaryData = [];
while ($row = mysqli_fetch_assoc($run)) {
    $salaryData[] = $row;
}

header('Content-Type: application/json');
echo json_encode($salaryData);
?>
