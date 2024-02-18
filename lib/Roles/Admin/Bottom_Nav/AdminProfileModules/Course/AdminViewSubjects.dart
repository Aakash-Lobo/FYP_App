import 'dart:convert';
import 'package:flutter/material.dart';
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
        title: Text('Admin View Subjects Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin View Subjects Information',
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
                DataColumn(label: Text('Subject Code')),
                DataColumn(label: Text('Subject Name')),
                DataColumn(label: Text('Course Code')),
                DataColumn(label: Text('Semester')),
                DataColumn(label: Text('Credit Hours')),
                DataColumn(label: Text('Action')),
              ],
              rows: subjects
                  .map(
                    (subject) => DataRow(
                      cells: [
                        DataCell(Text(subject.srNo.toString())),
                        DataCell(Text(subject.subjectCode)),
                        DataCell(Text(subject.subjectName)),
                        DataCell(Text(subject.courseCode)),
                        DataCell(Text(subject.semester)),
                        DataCell(Text(subject.creditHours)),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm Delete'),
                                    content: Text(
                                        'Are you sure you want to delete this subject?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteSubject(subject.subjectCode);
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
