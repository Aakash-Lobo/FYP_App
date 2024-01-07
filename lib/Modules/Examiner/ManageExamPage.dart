import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageExamPage extends StatefulWidget {
  final Map<String, dynamic> examDetails;

  ManageExamPage({required this.examDetails});

  @override
  _ManageExamPageState createState() => _ManageExamPageState();
}

class _ManageExamPageState extends State<ManageExamPage> {
  late String courseName;
  late String examTitle;
  late String examDescription;
  late String examTimeLimit;
  late String displayLimit;
  late List<Map<String, dynamic>> examQuestions;
  late List<Map<String, dynamic>> exams = [];

  @override
  void initState() {
    super.initState();
    // Extract data from the passed examDetails map
    courseName = widget.examDetails['courseName'] ?? '';
    examTitle = widget.examDetails['examTitle'] ?? '';
    examDescription = widget.examDetails['examDescription'] ?? '';
    examTimeLimit = widget.examDetails['examTimeLimit'] ?? '';
    displayLimit = widget.examDetails['displayLimit'] ?? '';
    examQuestions = widget.examDetails['questions'] ?? '';
  }

  Future<void> fetchExamList() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/exam/get_exam_list.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Make sure the response body is a list of maps
        List<Map<String, dynamic>>? examList = json.decode(response.body);

        if (examList != null) {
          setState(() {
            exams = examList;
          });
        } else {
          throw Exception('Failed to load exam list');
        }
      } else {
        throw Exception('Failed to load exam list');
      }
    } catch (error) {
      print('Error fetching exam list: $error');
    }
  }

  Future<void> updateExamDetails() async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/exam/updateexam.php"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'examId': widget.examDetails['examId'],
          'courseName': courseName,
          'examTitle': examTitle,
          'examDescription': examDescription,
          'examTimeLimit': examTimeLimit,
          'displayLimit': displayLimit,
        }),
      );

      if (response.statusCode == 200) {
        // Handle the response if needed
        // For example, show a success message
        print('Exam details updated successfully');
      } else {
        // Handle the error
        print('Failed to update exam details');
      }
    } catch (error) {
      print('Error updating exam details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Exam'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Course Name: $courseName'),
              Text('Exam Title: $examTitle'),
              Text('Exam Description: $examDescription'),
              Text('Exam Time Limit: $examTimeLimit'),
              Text('Display Limit: $displayLimit'),

              ElevatedButton(
                onPressed: () {
                  // Show a dialog or navigate to a form to update details
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Update Exam Details'),
                        content: Column(
                          children: [
                            // Your update form fields go here
                            TextFormField(
                              onChanged: (value) {
                                // Update courseName when the value changes
                                setState(() {
                                  courseName = value;
                                });
                              },
                              decoration:
                                  InputDecoration(labelText: 'Course Name'),
                            ),
                            // Add more form fields as needed
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Call the function to update details
                              updateExamDetails();
                              Navigator.of(context).pop();
                            },
                            child: Text('Update'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Update Exam Details'),
              ),

              // Display exam questions
              Text(
                'Exam Questions:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (examQuestions.isNotEmpty)
                Column(
                  children: examQuestions.map((question) {
                    return ListTile(
                      title: Text(
                        question['question'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('A - ${question['choiceA']}'),
                          Text('B - ${question['choiceB']}'),
                          Text('C - ${question['choiceC']}'),
                          Text('D - ${question['choiceD']}'),
                        ],
                      ),
                      // Add more details or actions as needed
                    );
                  }).toList(),
                )
              else
                Text('No questions found'),
            ],
          ),
        ),
      ),
    );
  }
}
