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
        title: Text(
          'Leave Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway', // Apply Raleway font and bold style
          ),
        ),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway', // Apply Raleway font
                  ),
                ),
              ),
            if (msg.isNotEmpty)
              Container(
                color: Colors.green,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  msg,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway', // Apply Raleway font
                  ),
                ),
              ),
            SizedBox(
                height:
                    20), // Add spacing between error/message containers and form fields
            TextFormField(
              controller: fromdateController,
              decoration: InputDecoration(
                labelText: 'Starting Date',
                hintText: 'Enter Date', // Add hintText
                floatingLabelBehavior:
                    FloatingLabelBehavior.always, // Set floatingLabelBehavior
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between form fields
            TextFormField(
              controller: todateController,
              decoration: InputDecoration(
                labelText: 'End Date',
                hintText: 'Enter Date', // Add hintText
                floatingLabelBehavior:
                    FloatingLabelBehavior.always, // Set floatingLabelBehavior
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between form fields
            TextFormField(
              controller: leavetypeController,
              decoration: InputDecoration(
                labelText: 'Leave Type',
                hintText: 'Enter Type', // Add hintText
                floatingLabelBehavior:
                    FloatingLabelBehavior.always, // Set floatingLabelBehavior
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between form fields
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Add Description', // Add hintText
                floatingLabelBehavior:
                    FloatingLabelBehavior.always, // Set floatingLabelBehavior
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: submitForm,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    color: Colors.white, // Apply Raleway font and white color
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.blue, // Set button background color
                ),
              ),
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
