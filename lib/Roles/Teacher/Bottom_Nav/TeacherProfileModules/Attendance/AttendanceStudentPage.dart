import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendanceStudentPage extends StatefulWidget {
  final String username;

  AttendanceStudentPage({required this.username});

  @override
  _AttendanceStudentPageState createState() => _AttendanceStudentPageState();
}

class _AttendanceStudentPageState extends State<AttendanceStudentPage> {
  final TextEditingController courseController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  List<Map<String, dynamic>> studentData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: courseController,
                    decoration: InputDecoration(labelText: 'Enter Class Id'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: semesterController,
                    decoration: InputDecoration(labelText: 'Enter Semester'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: subjectController,
                    decoration: InputDecoration(labelText: 'Enter Subject'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchStudentData,
              child: Text('Fetch Student Data'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: studentData.length,
                itemBuilder: (context, index) {
                  final student = studentData[index];
                  return Card(
                    child: ListTile(
                      title: Text('Roll No: ${student['roll_no']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Course Code: ${student['course_code']}'),
                          Text('Subject Code: ${student['subject_code']}'),
                          Text('Semester: ${student['semester']}'),
                          Text(
                              'Student Name: ${student['first_name']} ${student['middle_name']} ${student['last_name']}'),
                          Row(
                            children: [
                              Text('Present'),
                              Checkbox(
                                value: student['attendance'] == 1,
                                onChanged: (value) {
                                  setState(() {
                                    student['attendance'] =
                                        value != null && value ? 1 : 0;
                                  });
                                },
                              ),
                              Text('Absent'),
                              Checkbox(
                                value: student['attendance'] == 0,
                                onChanged: (value) {
                                  setState(() {
                                    student['attendance'] =
                                        value != null && value ? 1 : 0;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _submitAttendance,
              child: Text('Submit Attendance'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchStudentData() async {
    final response = await http.post(
      Uri.parse(
          'http://localhost/fyp/app/teacher/Bottom/attendance/viewattend.php'),
      body: {
        'course_code': courseController.text,
        'semester': semesterController.text,
        'subject_code': subjectController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        studentData =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to fetch student data');
    }
  }

  Future<void> _submitAttendance() async {
    final List<Map<String, dynamic>> attendanceList =
        studentData.map((student) {
      return {
        'roll_no': student['roll_no'],
        'attendance': student['attendance'],
      };
    }).toList();

    final response = await http.post(
      Uri.parse(
          'http://localhost/fyp/app/teacher/Bottom/attendance/submitattend.php'),
      body: json.encode(attendanceList),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Attendance submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit attendance')),
        );
      }
    } else {
      print('Failed to submit attendance');
    }
  }
}
