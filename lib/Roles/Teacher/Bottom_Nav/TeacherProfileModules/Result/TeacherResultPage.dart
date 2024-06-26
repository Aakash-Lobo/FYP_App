import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherResultPage extends StatefulWidget {
  final String username;

  TeacherResultPage({required this.username});

  @override
  _TeacherResultPageState createState() => _TeacherResultPageState();
}

class _TeacherResultPageState extends State<TeacherResultPage> {
  final TextEditingController courseCodeController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController subjectCodeController = TextEditingController();
  List<Map<String, dynamic>> studentsData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Result'),
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
                    controller: courseCodeController,
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
                    controller: subjectCodeController,
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
                itemCount: studentsData.length,
                itemBuilder: (context, index) {
                  final student = studentsData[index];
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
                          Text('Total Marks: 100'),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Obtain Marks'),
                            onChanged: (value) {
                              studentsData[index]['obtain_marks'] =
                                  int.tryParse(value) ?? 0;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _submitClassResult,
              child: Text('Submit Class Result'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchStudentData() async {
    String courseCode = courseCodeController.text;
    String semester = semesterController.text;
    String subjectCode = subjectCodeController.text;

    var response = await http.post(
      Uri.parse(
          'http://localhost/fyp/app/teacher/Bottom/course/viewcourse.php'),
      body: {
        'course_code': courseCode,
        'semester': semester,
        'subject_code': subjectCode,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        studentsData =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to fetch student data');
    }
  }

  Future<void> _submitClassResult() async {
    var response = await http.post(
      Uri.parse(
          'http://localhost/fyp/app/teacher/Bottom/course/submitresult.php'),
      body: json.encode(studentsData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Class result submitted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit class result')),
        );
      }
    } else {
      print('Failed to submit class result');
    }
  }
}
