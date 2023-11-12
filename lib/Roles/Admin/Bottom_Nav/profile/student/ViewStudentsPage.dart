import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewStudentsPage extends StatefulWidget {
  final String username;

  ViewStudentsPage({required this.username});

  @override
  _ViewStudentsPageState createState() => _ViewStudentsPageState();
}

class _ViewStudentsPageState extends State<ViewStudentsPage> {
  List<Map<String, dynamic>> studentsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        "http://localhost/fyp/app/admin/profile/student/viewstudent.php"));

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the data
      List<dynamic> data = json.decode(response.body);
      setState(() {
        studentsData = List<Map<String, dynamic>>.from(data);
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteStudent(String rollNo) async {
    final response = await http.delete(
      Uri.parse(
        "http://localhost/fyp/app/admin/profile/student/deletestudent.php?roll_no=$rollNo",
      ),
    );

    if (response.statusCode == 200) {
      // Successful deletion
      print('Student with Roll No $rollNo deleted successfully');
    } else {
      // Error in deletion
      print('Failed to delete student with Roll No $rollNo');
    }

    // Refresh the data after deletion
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Students'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'View Students Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            studentsData.isEmpty
                ? CircularProgressIndicator() // Show loading indicator
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Roll No')),
                          DataColumn(label: Text('Student Name')),
                          DataColumn(label: Text('Current Address')),
                          DataColumn(label: Text('Course ID')),
                          DataColumn(label: Text('Admission')),
                          DataColumn(label: Text('Operations')),
                        ],
                        rows: studentsData
                            .map(
                              (student) => DataRow(
                                cells: [
                                  DataCell(Text(student['roll_no'])),
                                  DataCell(Text(
                                      '${student['first_name']} ${student['middle_name']} ${student['last_name']}')),
                                  DataCell(Text(student['current_address'])),
                                  DataCell(Text(student['course_code'])),
                                  DataCell(Text(
                                      '${DateTime.parse(student['admission_date']).toLocal()}')),
                                  DataCell(
                                    ElevatedButton(
                                      onPressed: () {
                                        // Show a confirmation dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Delete Student'),
                                              content: Text(
                                                  'Are you sure you want to delete this student?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    // Dismiss the dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Delete the student and dismiss the dialog
                                                    deleteStudent(
                                                        student['roll_no']);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Yes'),
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
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
