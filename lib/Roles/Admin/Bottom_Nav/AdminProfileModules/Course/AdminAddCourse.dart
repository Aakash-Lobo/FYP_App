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
        title: Text(
          'Add Course',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway', // Apply Raleway font to app bar title
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                controller: courseCodeController,
                decoration: InputDecoration(
                  labelText: 'Course Code:',
                  hintText: 'Enter Course Code',
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
                style: TextStyle(
                  fontFamily: 'Raleway', // Apply Raleway font to input text
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Course Code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Add spacing between form fields
              TextFormField(
                controller: courseNameController,
                decoration: InputDecoration(
                  labelText: 'Course Name:',
                  hintText: 'Enter Course Name',
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
                style: TextStyle(
                  fontFamily: 'Raleway', // Apply Raleway font to input text
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Course Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Add spacing between form fields
              TextFormField(
                controller: semesterOrYearController,
                decoration: InputDecoration(
                  labelText: 'Semester or Years:',
                  hintText: 'Enter Semester or Years',
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
                style: TextStyle(
                  fontFamily: 'Raleway', // Apply Raleway font to input text
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Semester or Years';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Add spacing between form fields
              TextFormField(
                controller: noOfYearController,
                decoration: InputDecoration(
                  labelText: 'No of Years:',
                  hintText: 'Enter No of Years',
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
                style: TextStyle(
                  fontFamily: 'Raleway', // Apply Raleway font to input text
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter No of Years';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Add spacing between form fields
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  },
                  child: Text(
                    'Add Course',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily:
                          'Raleway', // Apply Raleway font to button text
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
              SizedBox(height: 20), // Add spacing between button and bottom
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
