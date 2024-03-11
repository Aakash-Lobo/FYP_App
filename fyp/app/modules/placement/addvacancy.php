<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp"; // Replace with your actual database name

$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the POST parameters (sanitize inputs)
    $companyID = mysqli_real_escape_string($con, $_POST['COMPANYID']);
    $category = mysqli_real_escape_string($con, $_POST['CATEGORY']);
    $occupationTitle = mysqli_real_escape_string($con, $_POST['OCCUPATIONTITLE']);
    $reqNoEmployees = mysqli_real_escape_string($con, $_POST['REQ_NO_EMPLOYEES']);
    $salaries = mysqli_real_escape_string($con, $_POST['SALARIES']);
    $durationEmployment = mysqli_real_escape_string($con, $_POST['DURATION_EMPLOYEMENT']);
    $qualificationWorkExperience = mysqli_real_escape_string($con, $_POST['QUALIFICATION_WORKEXPERIENCE']);
    $jobDescription = mysqli_real_escape_string($con, $_POST['JOBDESCRIPTION']);
    $preferredSex = mysqli_real_escape_string($con, $_POST['PREFEREDSEX']);
    $sectorVacancy = mysqli_real_escape_string($con, $_POST['SECTOR_VACANCY']);

    $query = "INSERT INTO `tbljob` (`COMPANYID`, `CATEGORY`, `OCCUPATIONTITLE`, `REQ_NO_EMPLOYEES`, `SALARIES`, `DURATION_EMPLOYEMENT`, `QUALIFICATION_WORKEXPERIENCE`, `JOBDESCRIPTION`, `PREFEREDSEX`, `SECTOR_VACANCY`, `DATEPOSTED`)
        VALUES ('$companyID', '$category', '$occupationTitle', '$reqNoEmployees', '$salaries', '$durationEmployment', '$qualificationWorkExperience', '$jobDescription', '$preferredSex', '$sectorVacancy', NOW())";

    $result = mysqli_query($con, $query);

    if ($result) {
        // Successful insertion
        echo json_encode(['message' => 'Vacancy added successfully']);
    } else {
        // Error in insertion
        echo json_encode(['message' => 'Failed to add vacancy']);
    }
} else {
    // Invalid request method
    echo json_encode(['message' => 'Invalid request method']);
}

mysqli_close($con);
?>
