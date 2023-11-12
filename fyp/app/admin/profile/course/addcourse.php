<?php  
    $host = "localhost";
    $username = "root";
    $password = "";
    $database = "fyp";

    $con = mysqli_connect($host, $username, $password, $database);

    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $courseCode = $_POST['course_code'];
        $courseName = $_POST['course_name'];
        $semesterOrYear = $_POST['semester_or_year'];
        $noOfYear = $_POST['no_of_year'];

        $query = "INSERT INTO courses (course_code, course_name, semester_or_year, no_of_year) VALUES ('$courseCode', '$courseName', '$semesterOrYear', '$noOfYear')";
        $run = mysqli_query($con, $query);

        if ($run) {
            http_response_code(200);
            echo json_encode(['message' => 'successfull']);
        } else {
            http_response_code(500);
            echo json_encode(['error' => 'not']);
        }
    } else {
        http_response_code(405);
        echo json_encode(['error' => 'Invalid request method']);
    }

    mysqli_close($con);
?>
