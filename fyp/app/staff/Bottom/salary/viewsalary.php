<?php
header('Content-Type: application/json');

$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Replace with your actual database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// $username = $_GET['username']; // Retrieve username from query parameter
$teacher_email = $_POST['teacher_email'];
$query = "SELECT salary_id, basic_salary, medical_allowance, hr_allowance, scale, DATE(paid_date) AS paid_date, total_amount FROM staff_salary_allowances INNER JOIN staff_salary_report ON staff_salary_allowances.staff_id = staff_salary_report.staff_id INNER JOIN staff_info ON staff_salary_report.staff_id = staff_info.staff_id WHERE staff_info.email ='$teacher_email'";
$run = mysqli_query($con, $query);

$salaryDetails = [];
while ($row = mysqli_fetch_assoc($run)) {
    $salaryDetails[] = $row;
}

echo json_encode($salaryDetails);
?>
