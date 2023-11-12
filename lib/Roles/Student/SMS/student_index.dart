import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentDashboardPage extends StatefulWidget {
  final String username;

  StudentDashboardPage({required this.username});

  @override
  _StudentDashboardPageState createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  late String studentName = ''; // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = 'http://localhost/fyp/app/student/SMS/student_dashboard.php';

    try {
      final response = await http.post(Uri.parse(url), body: {
        'username': widget.username,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          studentName = data['studentName'];
        });
      } else {
        // Handle server or response errors
        print('Failed to fetch student data');
      }
    } catch (e) {
      // Handle network or unexpected errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
      ),
      body: ListView(
        children: <Widget>[
          // Display student name here
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome to $studentName Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
          // Add other widgets for subjects, fee details, etc.
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: StudentDashboardPage(username: 'student_email@example.com'),
    ),
  );
}
