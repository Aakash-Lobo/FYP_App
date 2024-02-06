import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'EditStudentPage.dart';

class ViewStudentRoom extends StatefulWidget {
  final String username;

  ViewStudentRoom({required this.username});
  @override
  _ViewStudentRoomState createState() => _ViewStudentRoomState();
}

class _ViewStudentRoomState extends State<ViewStudentRoom> {
  List<Map<String, dynamic>> studentsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/hostel/viewstudent.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          studentsData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deleteStudent(int studentId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost/fyp/app/modules/hostel/deletestudent.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'studentId': studentId.toString()}),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Student with ID $studentId deleted successfully');
      } else if (response.statusCode == 400) {
        // Bad Request
        print('Missing studentId parameter');
      } else if (response.statusCode == 500) {
        // Internal Server Error
        print('Failed to delete student. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else {
        // Handle other status codes as needed
        print('Unexpected status code: ${response.statusCode}');
      }

      // Refresh the data after deletion
      fetchData();
    } catch (error) {
      print('Error deleting student: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Students'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Manage Students',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Reg. No.')),
                DataColumn(label: Text('Student\'s Name')),
                DataColumn(label: Text('Room No.')),
                DataColumn(label: Text('Seater')),
                DataColumn(label: Text('Staying From')),
                DataColumn(label: Text('Contact')),
                DataColumn(label: Text('Actions')),
              ],
              rows: studentsData.map((student) {
                return DataRow(
                  cells: [
                    DataCell(Text(student['regno'].toString())),
                    DataCell(Text(
                      '${student['firstName']} ${student['middleName']} ${student['lastName']}',
                    )),
                    DataCell(Text(student['roomno'].toString())),
                    DataCell(Text(student['seater'].toString())),
                    DataCell(Text(student['stayfrom'].toString())),
                    DataCell(Text(student['contactno'].toString())),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Show edit page for the student
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditStudentPage(
                                    studentId:
                                        int.parse(student['id'].toString()),
                                    regNo: student['regno'].toString(),
                                    firstName: student['firstName'].toString(),
                                    middleName:
                                        student['middleName'].toString(),
                                    lastName: student['lastName'].toString(),
                                    roomNo: student['roomno'].toString(),
                                    seater: student['seater'].toString(),
                                    stayingFrom: student['stayfrom'].toString(),
                                    contactNo: student['contactno'].toString(),
                                  ),
                                ),
                              );
                            },
                            child: Text('Edit'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Show confirmation dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Student'),
                                    content: Text(
                                      'Are you sure you want to delete this student?',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Perform the delete
                                          deleteStudent(int.parse(
                                              student['id'].toString()));
                                          Navigator.of(context)
                                              .pop(); // Close the confirmation dialog
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
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
