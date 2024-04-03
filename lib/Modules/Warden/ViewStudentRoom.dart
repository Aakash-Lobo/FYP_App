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
        title: Text(
          'Manage Students',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: studentsData.length,
              itemBuilder: (BuildContext context, int index) {
                var student = studentsData[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      student['regno'].toString(),
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${student['firstName']} ${student['middleName']} ${student['lastName']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Room No.: ${student['roomno']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Seater: ${student['seater']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Staying From: ${student['stayfrom']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Contact: ${student['contactno']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
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
                                  middleName: student['middleName'].toString(),
                                  lastName: student['lastName'].toString(),
                                  roomNo: student['roomno'].toString(),
                                  seater: student['seater'].toString(),
                                  stayingFrom: student['stayfrom'].toString(),
                                  contactNo: student['contactno'].toString(),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            // Show confirmation dialog
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
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Perform the delete
                                        deleteStudent(int.parse(
                                            student['id'].toString()));
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
