import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Teacher/Bottom_Nav/TeacherProfileModules/Leave/TeacherLeaveHistory.dart';
import 'package:flutter_application_1/Roles/Teacher/teacher_home.dart';
import 'package:http/http.dart' as http;

class TeacherLeavePage extends StatefulWidget {
  final String username;

  TeacherLeavePage({required this.username});

  @override
  _TeacherLeavePageState createState() => _TeacherLeavePageState();
}

class _TeacherLeavePageState extends State<TeacherLeavePage> {
  TextEditingController fromdateController = TextEditingController();
  TextEditingController todateController = TextEditingController();
  TextEditingController leavetypeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String error = '';
  String msg = '';

  void submitForm() async {
    final response = await http.post(
      Uri.parse('http://localhost/fyp/app/teacher/Bottom/leave/applyleave.php'),
      body: {
        'fromdate': fromdateController.text,
        'todate': todateController.text,
        'leavetype': leavetypeController.text,
        'description': descriptionController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        msg = response.body;
      });
    } else {
      setState(() {
        error = 'Failed to submit form. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (error.isNotEmpty)
              Container(
                color: Colors.red,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  error,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (msg.isNotEmpty)
              Container(
                color: Colors.green,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  msg,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            TextFormField(
              controller: fromdateController,
              decoration: InputDecoration(labelText: 'Starting Date'),
            ),
            TextFormField(
              controller: todateController,
              decoration: InputDecoration(labelText: 'End Date'),
            ),
            TextFormField(
              controller: leavetypeController,
              decoration: InputDecoration(labelText: 'Leave Type'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
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
            accountName: Text('Your Name'),
            accountEmail: Text(username),
            currentAccountPicture: CircleAvatar(
                // Add your profile picture here
                ),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Leave History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeacherLeaveHistory(username: username),
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
                    builder: (context) => TeacherHomePage(username: username),
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
