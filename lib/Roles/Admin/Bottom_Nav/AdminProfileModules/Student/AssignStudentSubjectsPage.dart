import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AssignSubjectsPage extends StatefulWidget {
  final String username;

  AssignSubjectsPage({required this.username});

  @override
  _AssignSubjectsPageState createState() => _AssignSubjectsPageState();
}

class _AssignSubjectsPageState extends State<AssignSubjectsPage> {
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _subjectCodeController =
      TextEditingController(); // Add controller for subject code
  final TextEditingController _subjectNameController =
      TextEditingController(); // Add controller for subject name
  final TextEditingController _semesterController =
      TextEditingController(); // Add controller for semester
  late String _selectedCourseCode = '';
  late String _rollNo = '';
  late String _subjectCode = '';
  late String _subjectName = '';
  late String _semester = '';
  late List<Map<String, dynamic>> _subjectDetails = [];

  Future<void> _submitForm() async {
    final String courseCode = _selectedCourseCode;
    final String rollNo = _rollNoController.text;
    final String subjectCode =
        _subjectCodeController.text; // Get subject code from controller
    final String subjectName =
        _subjectNameController.text; // Get subject name from controller
    final String semester =
        _semesterController.text; // Get semester from controller

    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost/fyp/app/admin/profile/student/assignsubject.php'),
        body: {
          'course_code': courseCode,
          'roll_no': rollNo,
          'subject_code': subjectCode,
          'subject_name': subjectName,
          'semester': semester,
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
          'Assign Subjects',
          style: TextStyle(
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
                labelText: 'Select Course Code',
                hintText: 'Select Course',
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
              onChanged: (value) {
                setState(() {
                  _selectedCourseCode = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _rollNoController,
              decoration: InputDecoration(
                labelText: 'Enter Roll No',
                hintText: 'Add Number',
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
              onChanged: (value) {
                setState(() {
                  _rollNo = value;
                });
              },
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
              onChanged: (value) {
                setState(() {
                  _subjectCode = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _subjectNameController,
              decoration: InputDecoration(
                labelText: 'Enter Subject Name',
                hintText: 'Add Name',
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
              onChanged: (value) {
                setState(() {
                  _subjectName = value;
                });
              },
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
              onChanged: (value) {
                setState(() {
                  _semester = value;
                });
              },
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
            // Display subject details here using _subjectDetails list
          ],
        ),
      ),
    );
  }
}
