import 'package:flutter/material.dart';

class StudentAttendancePage extends StatelessWidget {
  final String username;

  StudentAttendancePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Student Attendance Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add your student attendance content here
          ],
        ),
      ),
    );
  }
}
