<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if (isset($_POST['btn_sub'])) {
    $teacher_id = $_POST["teacher_id"];
    $query = "select * from teacher_salary_allowances where teacher_id='$teacher_id'";
    $run = mysqli_query($con, $query);
    while ($row = mysqli_fetch_array($run)) {
        $total_amount = $row['basic_salary'] + ($row['basic_salary'] * $row['medical_allowance'] / 100) + ($row['basic_salary'] * $row['hr_allowance'] / 100);
        $query1 = "INSERT INTO teacher_salary_report(teacher_id, total_amount, status) VALUES ('$teacher_id','$total_amount','Paid')";
        $run1 = mysqli_query($con, $query1);
        if ($run1) {
            echo json_encode(array("success" => true, "message" => "Salary has been paid to ID: $teacher_id"));
        } else {
            echo json_encode(array("success" => false, "message" => "Salary has not been paid due to some errors"));
        }
    }
}
?>
