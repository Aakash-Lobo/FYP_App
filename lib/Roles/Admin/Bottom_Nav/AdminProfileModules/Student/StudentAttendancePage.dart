import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentAttendancePage extends StatefulWidget {
  final String username;

  StudentAttendancePage({required this.username});

  @override
  _StudentAttendancePageState createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _subjectCodeController = TextEditingController();
  late List<String> _rollNumbers = [];
  late List<bool> _attendances = [];

  Future<void> _submitForm() async {
    final String courseCode = _courseCodeController.text;
    final String semester = _semesterController.text;
    final String subjectCode = _subjectCodeController.text;

    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost/fyp/app/admin/profile/student/addattend.php'),
        body: {
          'course_code': courseCode,
          'semester': semester,
          'subject_code': subjectCode,
          'roll_numbers': _rollNumbers.join(','),
          'attendances': _attendances
              .map((attendance) => attendance ? '1' : '0')
              .join(','),
        },
      );
      if (response.statusCode == 200) {
        // Handle success response
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle network error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Student Attendance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _courseCodeController,
              decoration: InputDecoration(labelText: 'Enter Course Code'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _semesterController,
              decoration: InputDecoration(labelText: 'Enter Semester'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _subjectCodeController,
              decoration: InputDecoration(labelText: 'Enter Subject Code'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
            SizedBox(height: 20.0),
            // Display student roll numbers and attendance options
            ListView.builder(
              shrinkWrap: true,
              itemCount: _rollNumbers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Roll Number: ${_rollNumbers[index]}'),
                  trailing: Checkbox(
                    value: _attendances[index],
                    onChanged: (value) {
                      setState(() {
                        _attendances[index] = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
