import 'dart:convert';

import 'package:flutter/material.dart';
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'View Teachers Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            teachersData.isEmpty
                ? CircularProgressIndicator() // Show loading indicator
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Teacher ID')),
                          DataColumn(label: Text('Teacher Name')),
                          DataColumn(label: Text('Current Address')),
                          DataColumn(label: Text('Hire Date')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Operations')),
                        ],
                        rows: teachersData
                            .map(
                              (teacher) => DataRow(
                                cells: [
                                  DataCell(Text(teacher['teacher_id'])),
                                  DataCell(Text(
                                      '${teacher['first_name']} ${teacher['middle_name']} ${teacher['last_name']}')),
                                  DataCell(Text(teacher['current_address'])),
                                  DataCell(Text(teacher['hire_date'])),
                                  DataCell(Text(teacher['email'])),
                                  DataCell(
                                    ElevatedButton(
                                      onPressed: () {
                                        // Show a confirmation dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Delete Teacher'),
                                              content: Text(
                                                  'Are you sure you want to delete this teacher?'),
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
                                                    // Delete the teacher and dismiss the dialog
                                                    deleteTeacher(
                                                        teacher['teacher_id']);
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
