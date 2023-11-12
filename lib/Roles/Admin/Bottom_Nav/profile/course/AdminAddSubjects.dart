import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'admin_course_index.dart';

class AdminAddSubjects extends StatefulWidget {
  final String username;

  AdminAddSubjects({required this.username});

  @override
  _AdminAddSubjectsState createState() => _AdminAddSubjectsState();
}

class _AdminAddSubjectsState extends State<AdminAddSubjects> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _subjectCodeController = TextEditingController();
  TextEditingController _subjectNameController = TextEditingController();
  TextEditingController _semesterController = TextEditingController();
  String? _selectedCourse;
  TextEditingController _creditHoursController = TextEditingController();

  List<String> courses = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    final response = await http.get(
      Uri.parse("http://localhost/fyp/app/admin/profile/course/getcourse.php"),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        courses =
            data.map((course) => course['course_code'] as String).toList();
      });
    } else {
      print('HTTP request failed with status: ${response.statusCode}');
    }
  }

  Future<void> addSubject() async {
    // Validate form
    if (_formKey.currentState!.validate()) {
      // Perform form submission here
      final response = await http.post(
        Uri.parse(
            "http://localhost/fyp/app/admin/profile/course/addsubject.php"),
        body: {
          'subject_code': _subjectCodeController.text,
          'subject_name': _subjectNameController.text,
          'semester': _semesterController.text,
          'course_code': _selectedCourse,
          'credit_hours': _creditHoursController.text,
        },
      );

      if (response.statusCode == 200) {
        // Navigate to the AdminCourse page after successful subject addition
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminCourse(username: widget.username),
          ),
        );
      } else {
        print('Failed to add subject with status: ${response.statusCode}');
        // Show error message to the user
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Add Subjects Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _subjectCodeController,
                decoration: InputDecoration(labelText: 'Subject Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the subject code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _subjectNameController,
                decoration: InputDecoration(labelText: 'Subject Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the subject name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _semesterController,
                decoration: InputDecoration(labelText: 'Semester'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the semester';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _selectedCourse,
                items: [
                  for (String course in courses)
                    DropdownMenuItem(
                      child: Text(course),
                      value: course,
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCourse = value as String?;
                  });
                },
                decoration: InputDecoration(labelText: 'Select Course'),
                validator: (dynamic value) {
                  if (value == null) {
                    return 'Please select a course';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _creditHoursController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Credit Hours'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the credit hours';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: addSubject,
                  child: Text('Add Subject'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
