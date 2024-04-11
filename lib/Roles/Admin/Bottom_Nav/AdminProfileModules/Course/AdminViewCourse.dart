import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Course/AdminAddCourse.dart';
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
        title: Text(
          'View Course',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        'Course Code: ${course.courseCode}',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Course Name: ${course.courseName}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Semester/Years: ${course.noOfYear}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Confirm Delete',
                                  style: TextStyle(fontFamily: 'Raleway'),
                                ),
                                content: Text(
                                  'Are you sure you want to delete this course?',
                                  style: TextStyle(fontFamily: 'Raleway'),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(fontFamily: 'Raleway'),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteCourse(course.courseCode);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(fontFamily: 'Raleway'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminAddCourse(username: widget.username),
            ),
          );
        },
        child: Icon(Icons.add),
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
