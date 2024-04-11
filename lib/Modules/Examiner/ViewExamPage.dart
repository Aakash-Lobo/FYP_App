import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Examiner/AddExamPage.dart';
import 'package:flutter_application_1/Modules/Examiner/AddExamineePage.dart';
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
        title: Text(
          'Examination Page',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: examsData.length,
          itemBuilder: (BuildContext context, int index) {
            var exam = examsData[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 4.0,
              child: ListTile(
                title: Text(
                  exam['ex_title'].toString(),
                  style: TextStyle(fontFamily: 'Raleway'),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subject: ${exam['subject']}',
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    Text(
                      'Description: ${exam['ex_description']}',
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    Text(
                      'Time Limit: ${exam['ex_time_limit']}',
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    Text(
                      'Display Limit: ${exam['ex_questlimit_display']}',
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Show manage page for the exam
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManageExamPage(
                              examDetails: {
                                'examId': int.parse(exam['ex_id'].toString()),
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
                                  'Are you sure you want to delete this exam?'),
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
                                    deleteExam(
                                        int.parse(exam['ex_id'].toString()));
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExamPage(username: widget.username),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
