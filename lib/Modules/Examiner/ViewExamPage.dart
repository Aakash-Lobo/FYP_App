import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Examiner/ManageExamPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewExamPage extends StatefulWidget {
  final String username;

  ViewExamPage({required this.username});

  @override
  _ViewExamPageState createState() => _ViewExamPageState();
}

class _ViewExamPageState extends State<ViewExamPage> {
  List<Map<String, dynamic>> examsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/exam/viewexam.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          examsData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deleteExam(int examId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost/fyp/app/modules/exam/deleteexam.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'examId': examId.toString()}),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Exam with ID $examId deleted successfully');
      } else if (response.statusCode == 400) {
        // Bad Request
        print('Missing examId parameter');
      } else if (response.statusCode == 500) {
        // Internal Server Error
        print('Failed to delete exam. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else {
        // Handle other status codes as needed
        print('Unexpected status code: ${response.statusCode}');
      }

      // Refresh the data after deletion
      fetchData();
    } catch (error) {
      print('Error deleting exam: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Examination Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'View Exams',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Exam Title')),
                DataColumn(label: Text('Subject')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Time Limit')),
                DataColumn(label: Text('Display Limit')),
                DataColumn(label: Text('Action')),
              ],
              rows: examsData.map((exam) {
                return DataRow(
                  cells: [
                    DataCell(Text(exam['ex_title'].toString())),
                    DataCell(Text(exam['subject'].toString())),
                    DataCell(Text(exam['ex_description'].toString())),
                    DataCell(Text(exam['ex_time_limit'].toString())),
                    DataCell(Text(exam['ex_questlimit_display'].toString())),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Show manage page for the exam
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ManageExamPage(
                                    examDetails: {
                                      'examId':
                                          int.parse(exam['ex_id'].toString()),
                                      // Add other necessary details here
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Text('Manage'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              // Show confirmation dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Exam'),
                                    content: Text(
                                      'Are you sure you want to delete this exam?',
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
                                          deleteExam(int.parse(
                                              exam['ex_id'].toString()));
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
