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
    $sqlCategory = "SELECT COUNT(*) AS 'Total Prescriptions' FROM counsel_prestb";
    $resultCategory = mysqli_query($con, $sqlCategory);
    $categoryCount = mysqli_fetch_assoc($resultCategory);
    $categoryCount = intval($categoryCount['Total Prescriptions']); // Convert to integer

    $sqlCompany = "SELECT COUNT(*) AS 'Total Appointments' FROM counsel_appointmenttb";
    $resultCompany = mysqli_query($con, $sqlCompany);
    $companyCount = mysqli_fetch_assoc($resultCompany);
    $companyCount = intval($companyCount['Total Appointments']); // Convert to integer


    
    $statistics = [
        'Total Prescriptions' => $categoryCount,
        'Total Appointments' => $companyCount,
        // 'employees_count' => $employeesCount,
        // 'job_count' => $jobCount,
        // 'job_registration_count' => $jobRegistrationCount
    ];

    // Send response
    echo json_encode($statistics);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Internal Server Error: " . $e->getMessage()]);
}
?>
