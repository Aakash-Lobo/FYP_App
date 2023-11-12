import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'admin_course_index.dart';

class AdminAddCourse extends StatefulWidget {
  final String username;

  AdminAddCourse({required this.username});

  @override
  _AdminAddCourseState createState() => _AdminAddCourseState();
}

class _AdminAddCourseState extends State<AdminAddCourse> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController courseCodeController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController semesterOrYearController = TextEditingController();
  TextEditingController noOfYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Add Course Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Admin Add Course Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Username: ${widget.username}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: courseCodeController,
                decoration: InputDecoration(
                  labelText: 'Course Code:',
                  hintText: 'Enter Course Code',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Course Code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: courseNameController,
                decoration: InputDecoration(
                  labelText: 'Course Name:',
                  hintText: 'Enter Course Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Course Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: semesterOrYearController,
                decoration: InputDecoration(
                  labelText: 'Semester or Years:',
                  hintText: 'Enter Semester or Years',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Semester or Years';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: noOfYearController,
                decoration: InputDecoration(
                  labelText: 'No of Years:',
                  hintText: 'Enter No of Years',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter No of Years';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
                  }
                },
                child: Text('Add Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    final response = await http.post(
      Uri.parse("http://localhost/fyp/app/admin/profile/course/addcourse.php"),
      body: {
        'course_code': courseCodeController.text,
        'course_name': courseNameController.text,
        'semester_or_year': semesterOrYearController.text,
        'no_of_year': noOfYearController.text,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result['message'] == 'successfull') {
        print('Course added successfully');

        // Redirect to AdminCourse page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AdminCourse(username: widget.username),
          ),
        );
      } else {
        print('Failed to add course');
      }
    } else {
      print('HTTP request failed with status: ${response.statusCode}');
    }
  }
}
