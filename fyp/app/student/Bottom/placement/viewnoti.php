<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "fyp";

// Establish connection
$con = mysqli_connect($host, $username, $password, $database);

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Select companies from the database
$sql = "SELECT * FROM `tbljob` j, `tblcompany` c WHERE j.`COMPANYID`=c.`COMPANYID` ORDER BY DATEPOSTED DESC LIMIT 10";
$mydb->setQuery($sql);
$cur = $mydb->loadResultList();

// Prepare array to hold job data
$jobs = array();
foreach ($cur as $result) {
    $job = array(
        'OCCUPATIONTITLE' => $result->OCCUPATIONTITLE,
        'JOBDESCRIPTION' => $result->JOBDESCRIPTION,
        'QUALIFICATION_WORKEXPERIENCE' => $result->QUALIFICATION_WORKEXPERIENCE,
        'DATEPOSTED' => $result->DATEPOSTED
    );
    // Push job data to the array
    array_push($jobs, $job);
}

// Return jobs as JSON
echo json_encode($jobs);
?>
