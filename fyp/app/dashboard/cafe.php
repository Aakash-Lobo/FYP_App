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
    $sqlCategory = "SELECT COUNT(*) AS 'Total Categories' FROM cafe_categories";
    $resultCategory = mysqli_query($con, $sqlCategory);
    $categoryCount = mysqli_fetch_assoc($resultCategory);
    $categoryCount = intval($categoryCount['Total Categories']); // Convert to integer

    $sqlCompany = "SELECT COUNT(*) AS 'Total Orders' FROM cafe_orders";
    $resultCompany = mysqli_query($con, $sqlCompany);
    $companyCount = mysqli_fetch_assoc($resultCompany);
    $companyCount = intval($companyCount['Total Orders']); // Convert to integer

    // $sqlEmployees = "SELECT COUNT(*) AS employees_count FROM tblemployees";
    // $resultEmployees = mysqli_query($con, $sqlEmployees);
    // $employeesCount = mysqli_fetch_assoc($resultEmployees);
    // $employeesCount = intval($employeesCount['employees_count']); // Convert to integer

    $sqlJob = "SELECT COUNT(*) AS 'Total Products' FROM cafe_product";
    $resultJob = mysqli_query($con, $sqlJob);
    $jobCount = mysqli_fetch_assoc($resultJob);
    $jobCount = intval($jobCount['Total Products']); // Convert to integer

    // $sqlJobRegistration = "SELECT COUNT(*) AS job_registration_count FROM tbljobregistration";
    // $resultJobRegistration = mysqli_query($con, $sqlJobRegistration);
    // $jobRegistrationCount = mysqli_fetch_assoc($resultJobRegistration);
    // $jobRegistrationCount = intval($jobRegistrationCount['job_registration_count']); // Convert to integer

    // Prepare data
    $statistics = [
        'Total Categories' => $categoryCount,
        'Total Orders' => $companyCount,
        // 'employees_count' => $employeesCount,
        'Total Products' => $jobCount,
        // 'job_registration_count' => $jobRegistrationCount
    ];

    // Send response
    echo json_encode($statistics);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Internal Server Error: " . $e->getMessage()]);
}
?>
