import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/admin_teacher_index.dart';
import 'package:http/http.dart' as http;

class AssignTeacherSubjectsPage extends StatefulWidget {
  final String username;

  AssignTeacherSubjectsPage({required this.username});

  @override
  _AssignTeacherSubjectsPageState createState() =>
      _AssignTeacherSubjectsPageState();
}

class _AssignTeacherSubjectsPageState extends State<AssignTeacherSubjectsPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController teacherIdController = TextEditingController();
  TextEditingController courseCodeController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController subjectCodeController = TextEditingController();
  TextEditingController totalClassesController = TextEditingController();

  String? selectedCourse;
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Subjects'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'Assign Subjects Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: teacherIdController,
                decoration: InputDecoration(labelText: 'Enter Teacher Id:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the teacher id';
                  }
                  return null;
                },
              ),
              buildDropdownFormField(
                labelText: 'Select Course:',
                options: [
                  'Course1',
                  'Course2',
                  'Course3'
                ], // Replace with your options
                value: selectedCourse,
                onChanged: (value) {
                  setState(() {
                    selectedCourse = value;
                  });
                },
              ),
              TextFormField(
                controller: semesterController,
                decoration: InputDecoration(labelText: 'Enter Semester:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the semester';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: subjectCodeController,
                decoration:
                    InputDecoration(labelText: 'Please Select Subject:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a subject';
                  }
                  return null;
                },
              ),
              buildDropdownFormField(
                labelText: 'Enter Total Classes:',
                options: [
                  'Class1',
                  'Class2',
                  'Class3'
                ], // Replace with your options
                value: selectedSubject,
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, send data to server
                    _submitForm();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownFormField({
    required String labelText,
    required List<String> options,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a value for $labelText';
        }
        return null;
      },
    );
  }

  void _submitForm() async {
    // Send form data to the server
    final response = await http.post(
      Uri.parse(
          "http://localhost/fyp/app/admin/profile/teacher/assignteachersubject.php"),
      body: {
        'teacher_id': teacherIdController.text,
        'course_code': selectedCourse ?? '',
        'semester': semesterController.text,
        'subject_code': subjectCodeController.text,
        'total_classes': selectedSubject ?? '',
      },
    );

    if (response.statusCode == 200) {
      // Parse the response to check if the assignment was successful
      Map<String, dynamic> result = json.decode(response.body);

      if (result['message'] == 'Assignment successful') {
        // Successful submission
        print('Assignment successful');

        // Redirect to the AdminTeacher page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => AdminTeacher(username: widget.username)),
        );
      } else {
        // Error in submission
        print('Failed to assign subjects');
      }
    } else {
      // HTTP request failed
      print('HTTP request failed with status: ${response.statusCode}');
    }
  }
}
