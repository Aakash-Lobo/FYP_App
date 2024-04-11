import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherCoursePage extends StatefulWidget {
  final String username;

  TeacherCoursePage({required this.username});

  @override
  _TeacherCoursePageState createState() => _TeacherCoursePageState();
}

class _TeacherCoursePageState extends State<TeacherCoursePage> {
  List<Map<String, dynamic>> courses = [];

  @override
  void initState() {
    super.initState();
    fetchTeacherCourses();
  }

  Future<void> fetchTeacherCourses() async {
    String teacherEmail = widget.username; // Use the username variable
    var url = Uri.parse(
        'http://localhost/fyp/app/teacher/Bottom/course/viewcourse.php');
    var response = await http.post(url, body: {'teacher_email': teacherEmail});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      List<Map<String, dynamic>> decodedData =
          responseData.cast<Map<String, dynamic>>();
      setState(() {
        courses = decodedData;
      });
    } else {
      print('Failed to fetch teacher courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Courses',
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          var course = courses[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text('Course Code: ${course['course_code']}',
                  style: TextStyle(fontFamily: 'Raleway')),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Subject Code: ${course['subject_code']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Room No: ${course['room_no']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Semester: ${course['semester']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Time: ${course['timing_to']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Total Classes: ${course['total_classes']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
