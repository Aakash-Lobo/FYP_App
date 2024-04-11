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
        title: Text(
          'Student Attendance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway', // Apply Raleway font to app bar title
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            TextField(
              controller: _courseCodeController,
              decoration: InputDecoration(
                labelText: 'Enter Course Code',
                hintText: 'Add Course',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _semesterController,
              decoration: InputDecoration(
                labelText: 'Enter Semester',
                hintText: 'Add Semester',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _subjectCodeController,
              decoration: InputDecoration(
                labelText: 'Enter Subject Code',
                hintText: 'Add Subject',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Raleway', // Apply Raleway font to button text
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.blue, // Set button background color
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Display student roll numbers and attendance options
            ListView.builder(
              shrinkWrap: true,
              itemCount: _rollNumbers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Roll Number: ${_rollNumbers[index]}',
                    style:
                        TextStyle(fontFamily: 'Raleway'), // Apply Raleway font
                  ),
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
