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

// Fetch data from the form
$roomNo = $_POST['room'];
$startDate = $_POST['stayf'];
$seater = $_POST['seater'];
$duration = $_POST['duration'];
$foodStatus = $_POST['foodstatus'];
$totalFeesPerMonth = $_POST['fpm'];
$totalAmount = $_POST['ta'];
$regNo = $_POST['regno'];
$firstName = $_POST['fname'];
$middleName = $_POST['mname'];
$lastName = $_POST['lname'];
$email = $_POST['email'];
$gender = $_POST['gender'];
$contactNo = $_POST['contact'];
$emergencyContactNo = $_POST['econtact'];
$preferredCourse = $_POST['course'];
$guardianName = $_POST['gname'];
$guardianRelation = $_POST['grelation'];
$guardianContactNo = $_POST['gcontact'];
$currentAddress = $_POST['address'];
$currentCity = $_POST['city'];
$currentPincode = $_POST['pincode'];

// Insert data into the database
$sql="INSERT into  registration(roomno,seater,feespm,foodstatus,stayfrom,duration,course,regno,firstName,middleName,lastName,gender,contactno,emailid,egycontactno,guardianName,guardianRelation,guardianContactno,corresAddress,corresCIty,corresPincode,pmntAddress,pmntCity,pmntPincode) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        
if (mysqli_query($con, $sql)) {
    echo "New record inserted successfully";
} else {
    echo "Error: " . $sql . "<br>" . mysqli_error($con);
}

// Close connection
mysqli_close($con);
?>
