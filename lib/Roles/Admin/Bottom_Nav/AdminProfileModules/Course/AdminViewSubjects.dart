import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Course/AdminAddSubjects.dart';
import 'package:http/http.dart' as http;

class AdminViewSubjects extends StatefulWidget {
  final String username;

  AdminViewSubjects({required this.username});

  @override
  _AdminViewSubjectsState createState() => _AdminViewSubjectsState();
}

class _AdminViewSubjectsState extends State<AdminViewSubjects> {
  List<Subject> subjects = [];

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    final response = await http.get(
      Uri.parse(
          "http://localhost/fyp/app/admin/profile/course/viewsubject.php"),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        subjects = data.map((subject) => Subject.fromJson(subject)).toList();
      });
    } else {
      print('HTTP request failed with status: ${response.statusCode}');
    }
  }

  Future<void> deleteSubject(String subjectCode) async {
    final response = await http.post(
      Uri.parse(
          "http://localhost/fyp/app/admin/profile/course/deletesubject.php"),
      body: {'subject_code': subjectCode},
    );

    if (response.statusCode == 200) {
      // Refresh the subject list after successful deletion
      fetchSubjects();
    } else {
      print('Failed to delete subject with status: ${response.statusCode}');
      // Show error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Subjects',
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
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        'Subject Code: ${subject.subjectCode}',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subject Name: ${subject.subjectName}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Course Code: ${subject.courseCode}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Semester: ${subject.semester}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Credit Hours: ${subject.creditHours}',
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
                                  'Are you sure you want to delete this subject?',
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
                                      deleteSubject(subject.subjectCode);
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
              builder: (context) => AdminAddSubjects(username: widget.username),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Subject {
  final int srNo;
  final String subjectCode;
  final String subjectName;
  final String courseCode;
  final String semester;
  final String creditHours;

  Subject({
    required this.srNo,
    required this.subjectCode,
    required this.subjectName,
    required this.courseCode,
    required this.semester,
    required this.creditHours,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      srNo: json['srNo'],
      subjectCode: json['subject_code'],
      subjectName: json['subject_name'],
      courseCode: json['course_code'],
      semester: json['semester'],
      creditHours: json['credit_hours'],
    );
  }
}
