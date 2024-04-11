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

$response = array();

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Query to fetch company messages
    $sql = "SELECT c.COMPANYNAME, j.REMARKS, j.DATETIMEAPPROVED 
            FROM tblcompany c 
            INNER JOIN tbljobregistration j ON c.COMPANYID = j.COMPANYID 
            INNER JOIN tblfeedback f ON j.REGISTRATIONID = f.REGISTRATIONID 
            WHERE j.PENDINGAPPLICATION = 0 AND j.APPLICANTID = ?";

    // Prepare the statement
    $stmt = $conn->prepare($sql);

    // Bind parameters
    $applicantId = $_SESSION['APPLICANTID'];
    $stmt->bind_param('i', $applicantId);

    // Execute the statement
    if ($stmt->execute()) {
        // Bind result variables
        $stmt->bind_result($companyName, $remarks, $dateTimeApproved);

        // Fetch company messages
        $companyMessages = array();
        while ($stmt->fetch()) {
            $message = array(
                'COMPANYNAME' => $companyName,
                'REMARKS' => $remarks,
                'DATETIMEAPPROVED' => $dateTimeApproved
            );
            array_push($companyMessages, $message);
        }

        // Close statement
        $stmt->close();

        // Set response data
        $response['error'] = false;
        $response['message'] = 'Company messages retrieved successfully';
        $response['companyMessages'] = $companyMessages;
    } else {
        // Error fetching company messages
        $response['error'] = true;
        $response['message'] = 'Error fetching company messages';
    }
} else {
    // Invalid request method
    $response['error'] = true;
    $response['message'] = 'Invalid request method';
}

// Return response as JSON
echo json_encode($response);
?>