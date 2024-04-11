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

// $username = "rhea@gmail.com;

$username = $_GET['username'];
$query = "SELECT * FROM class_result cr INNER JOIN course_subjects cs ON cr.subject_code = cs.subject_code WHERE cr.roll_no = (SELECT roll_no FROM student_info WHERE email = '$username') AND cr.semester = 1";
$run = mysqli_query($con, $query);

$resultDetails = [];
$gpa = 0;
$count = 0;
$cgpa = 0;

while ($row = mysqli_fetch_assoc($run)) {
    $grade = '';
    $credits = 0.0;
    if ($row['obtain_marks'] > 85) {
        $grade = 'A+';
        $credits = 4.0;
    } else if ($row['obtain_marks'] > 80) {
        $grade = 'A';
        $credits = 4.0;
    } else if ($row['obtain_marks'] > 75) {
        $grade = 'B+';
        $credits = 3.7;
    } else if ($row['obtain_marks'] > 70) {
        $grade = 'B';
        $credits = 3.3;
    } else if ($row['obtain_marks'] > 65) {
        $grade = 'C+';
        $credits = 3.0;
    } else if ($row['obtain_marks'] > 60) {
        $grade = 'C';
        $credits = 2.7;
    } else if ($row['obtain_marks'] > 55) {
        $grade = 'D+';
        $credits = 2.5;
    } else if ($row['obtain_marks'] > 50) {
        $grade = 'D';
        $credits = 2.0;
    } else {
        $grade = 'F';
        $credits = 0.0;
    }

    $resultDetails[] = [
        'term' => $row['course_code'] . "-" . $row['semester'],
        'course' => $row['course_code'],
        'subject' => $row['subject_code'],
        'credit_hours' => $row['credit_hours'],
        'total_marks' => $row['total_marks'],
        'obtain_marks' => $row['obtain_marks'],
        'grade' => $grade,
        'cgpa' => $credits,
    ];

    $count++;
    $gpa += $credits * $row['credit_hours'];
    $cgpa += $row['credit_hours'];
}

// Calculate final result
$finalGrade = '';
$finalCGPA = 0.0;

if ($cgpa > 0) {
    $finalGrade = 'A+';
    $finalCGPA = round($gpa / $cgpa, 2);
}

// Add final result to the result details
$resultDetails[] = [
    'term' => 'FINAL RESULT',
    'course' => '',
    'subject' => null,
    'credit_hours' => null,
    'total_marks' => $cgpa,
    'obtain_marks' => $gpa,
    'grade' => $finalGrade,
    'cgpa' => $finalCGPA,
];

echo json_encode($resultDetails);
?>
