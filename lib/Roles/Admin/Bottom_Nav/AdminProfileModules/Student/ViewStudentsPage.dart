import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Student/AddStudentPage.dart';
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
        title: Text('View Students',
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            studentsData.isEmpty
                ? CircularProgressIndicator() // Show loading indicator
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: studentsData.length,
                        itemBuilder: (context, index) {
                          var student = studentsData[index];
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    'Roll No: ${student['roll_no']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Raleway'),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Student Name: ${student['first_name']} ${student['middle_name']} ${student['last_name']}',
                                          style:
                                              TextStyle(fontFamily: 'Raleway')),
                                      Text(
                                          'Current Address: ${student['current_address']}',
                                          style:
                                              TextStyle(fontFamily: 'Raleway')),
                                      Text(
                                          'Course ID: ${student['course_code']}',
                                          style:
                                              TextStyle(fontFamily: 'Raleway')),
                                      Text(
                                          'Admission: ${DateTime.parse(student['admission_date']).toLocal()}',
                                          style:
                                              TextStyle(fontFamily: 'Raleway')),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Show a confirmation dialog
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Delete Student',
                                                style: TextStyle(
                                                    fontFamily: 'Raleway')),
                                            content: Text(
                                              'Are you sure you want to delete this student?',
                                              style: TextStyle(
                                                  fontFamily: 'Raleway'),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  // Dismiss the dialog
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('No',
                                                    style: TextStyle(
                                                        fontFamily: 'Raleway')),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // Delete the student and dismiss the dialog
                                                  deleteStudent(
                                                      student['roll_no']);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Yes',
                                                    style: TextStyle(
                                                        fontFamily: 'Raleway')),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('Delete',
                                        style:
                                            TextStyle(fontFamily: 'Raleway')),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
              builder: (context) => AddStudentPage(username: widget.username),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
