import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/AddTeacherPage.dart';
import 'package:http/http.dart' as http;

class ViewTeachersPage extends StatefulWidget {
  final String username;

  ViewTeachersPage({required this.username});

  @override
  _ViewTeachersPageState createState() => _ViewTeachersPageState();
}

class _ViewTeachersPageState extends State<ViewTeachersPage> {
  List<Map<String, dynamic>> teachersData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        "http://localhost/fyp/app/admin/profile/teacher/viewteacher.php"));

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the data
      List<dynamic> data = json.decode(response.body);
      setState(() {
        teachersData = List<Map<String, dynamic>>.from(data);
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteTeacher(String teacherId) async {
    final response = await http.delete(
      Uri.parse(
          "http://localhost/fyp/app/admin/profile/teacher/deleteteacher.php"),
      body: {'teacher_id': teacherId},
    );

    if (response.statusCode == 200) {
      // Successful deletion
      print('Teacher with ID $teacherId deleted successfully');
    } else {
      // Error in deletion
      print('Failed to delete teacher with ID $teacherId');
    }

    // Refresh the data after deletion
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Teachers'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            teachersData.isEmpty
                ? CircularProgressIndicator() // Show loading indicator
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: teachersData.length,
                        itemBuilder: (context, index) {
                          var teacher = teachersData[index];
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    'Teacher ID: ${teacher['teacher_id']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Raleway'),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Teacher Name: ${teacher['first_name']} ${teacher['middle_name']} ${teacher['last_name']}',
                                          style:
                                              TextStyle(fontFamily: 'Raleway')),
                                      Text(
                                          'Current Address: ${teacher['current_address']}',
                                          style:
                                              TextStyle(fontFamily: 'Raleway')),
                                      Text('Hire Date: ${teacher['hire_date']}',
                                          style:
                                              TextStyle(fontFamily: 'Raleway')),
                                      Text('Email: ${teacher['email']}',
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
                                            title: Text('Delete Teacher',
                                                style: TextStyle(
                                                    fontFamily: 'Raleway')),
                                            content: Text(
                                              'Are you sure you want to delete this teacher?',
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
                                                  // Delete the teacher and dismiss the dialog
                                                  deleteTeacher(
                                                      teacher['teacher_id']);
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
              builder: (context) => AddTeacherPage(username: widget.username),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
