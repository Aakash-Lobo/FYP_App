import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Roles/Student/student_home.dart';

import 'AttemptedExamPage.dart';
import 'StudentExamFeedbackPage.dart';

class StudentExaminationPage extends StatefulWidget {
  final String username;

  StudentExaminationPage({required this.username});

  @override
  _StudentExaminationPageState createState() => _StudentExaminationPageState();
}

class _StudentExaminationPageState extends State<StudentExaminationPage> {
  Future<List<Map<String, dynamic>>> fetchAllExams() async {
    final response = await http.get(
      Uri.parse(
          'http://localhost/fyp/app/student/Bottom/exam/get_all_exams.php?roll_no=${widget.username}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exam Page',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchAllExams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final exam = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      exam['ex_title'],
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    subtitle: Text(
                      exam['ex_description'],
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Implement action when the button is pressed
                      },
                      child: Text(
                        'Start Now',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      drawer: CustomSideNavigationBar(
        username: widget.username,
        onLogout: (bool isLoggingOut) {
          if (isLoggingOut) {
            // Log the user out and navigate to the login page
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    );
  }
}

class CustomSideNavigationBar extends StatelessWidget {
  final String username;
  final Function(bool) onLogout;

  CustomSideNavigationBar({
    required this.username,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
            accountEmail: Text(username),
            currentAccountPicture: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Attempted Exam'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttemptedExamPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Feedback Page'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StudentExamFeedbackPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              _showExitConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit Confirmation'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentHomePage(username: username),
                  ),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
