import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminViewCourse extends StatefulWidget {
  final String username;

  AdminViewCourse({required this.username});

  @override
  _AdminViewCourseState createState() => _AdminViewCourseState();
}

class _AdminViewCourseState extends State<AdminViewCourse> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse("http://localhost/fyp/app/admin/profile/course/viewcourse.php"),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        courses = data.map((course) => Course.fromJson(course)).toList();
      });
    } else {
      print('HTTP request failed with status: ${response.statusCode}');
    }
  }

  Future<void> deleteCourse(String courseCode) async {
    final response = await http.post(
      Uri.parse(
          "http://localhost/fyp/app/admin/profile/course/deletecourse.php"),
      body: {'course_code': courseCode},
    );

    if (response.statusCode == 200) {
      fetchData(); // Refresh the course list after deletion
    } else {
      print('Failed to delete course with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin View Course Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin View Course Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Username: ${widget.username}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            DataTable(
              columns: [
                DataColumn(label: Text('Sr. No')),
                DataColumn(label: Text('Course Code')),
                DataColumn(label: Text('Course Name')),
                DataColumn(label: Text('Semester/Years')),
                DataColumn(label: Text('Action')),
              ],
              rows: courses
                  .map(
                    (course) => DataRow(
                      cells: [
                        DataCell(Text(course.srNo.toString())),
                        DataCell(Text(course.courseCode)),
                        DataCell(Text(course.courseName)),
                        DataCell(Text(course.noOfYear)),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm Delete'),
                                    content: Text(
                                        'Are you sure you want to delete this course?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteCourse(course.courseCode);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Delete'),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Course {
  final int srNo;
  final String courseCode;
  final String courseName;
  final String noOfYear;

  Course({
    required this.srNo,
    required this.courseCode,
    required this.courseName,
    required this.noOfYear,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      srNo: json['index'] ?? 0, // Default to 0 if 'index' is not present
      courseCode: json['course_code'],
      courseName: json['course_name'],
      noOfYear: json['no_of_year'],
    );
  }
}
