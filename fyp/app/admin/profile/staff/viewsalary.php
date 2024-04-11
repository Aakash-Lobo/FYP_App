<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT tsr.salary_id, tsr.staff_id, ti.first_name, ti.middle_name, ti.last_name, tsa.basic_salary, tsa.medical_allowance, tsa.hr_allowance, tsa.scale, DATE(tsr.paid_date) AS paid_date, tsr.total_amount FROM staff_salary_report tsr INNER JOIN staff_info ti ON tsr.staff_id = ti.staff_id INNER JOIN staff_salary_allowances tsa ON ti.staff_id = tsa.staff_id";
$run = mysqli_query($con, $query);

$salaryData = [];
while ($row = mysqli_fetch_assoc($run)) {
    $salaryData[] = $row;
}

header('Content-Type: application/json');
echo json_encode($salaryData);
?>
