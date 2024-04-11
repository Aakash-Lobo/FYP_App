<?php  
header("Content-Type: application/json");
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

try {
    // Fetch count from each table
    $sqlCategory = "SELECT COUNT(*) AS 'Total Exams' FROM exam_tbl";
    $resultCategory = mysqli_query($con, $sqlCategory);
    $categoryCount = mysqli_fetch_assoc($resultCategory);
    $categoryCount = intval($categoryCount['Total Exams']); // Convert to integer

    $sqlCompany = "SELECT COUNT(*) AS 'Total Examinees' FROM student_info";
    $resultCompany = mysqli_query($con, $sqlCompany);
    $companyCount = mysqli_fetch_assoc($resultCompany);
    $companyCount = intval($companyCount['Total Examinees']); // Convert to integer

    $sqlEmployees = "SELECT COUNT(*) AS 'Total Courses' FROM courses";
    $resultEmployees = mysqli_query($con, $sqlEmployees);
    $employeesCount = mysqli_fetch_assoc($resultEmployees);
    $employeesCount = intval($employeesCount['Total Courses']); // Convert to integer

    $sqlJob = "SELECT COUNT(*) AS 'Total Subjects' FROM course_subjects";
    $resultJob = mysqli_query($con, $sqlJob);
    $jobCount = mysqli_fetch_assoc($resultJob);
    $jobCount = intval($jobCount['Total Subjects']); // Convert to integer

    // $sqlJobRegistration = "SELECT COUNT(*) AS job_registration_count FROM tbljobregistration";
    // $resultJobRegistration = mysqli_query($con, $sqlJobRegistration);
    // $jobRegistrationCount = mysqli_fetch_assoc($resultJobRegistration);
    // $jobRegistrationCount = intval($jobRegistrationCount['job_registration_count']); // Convert to integer

    // Prepare data
    $statistics = [
        'Total Exams' => $categoryCount,
        'Total Examinees' => $companyCount,
        'Total Courses' => $employeesCount,
        'Total Subjects' => $jobCount,
        // 'job_registration_count' => $jobRegistrationCount
    ];

    // Send response
    echo json_encode($statistics);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Internal Server Error: " . $e->getMessage()]);
}
?>
