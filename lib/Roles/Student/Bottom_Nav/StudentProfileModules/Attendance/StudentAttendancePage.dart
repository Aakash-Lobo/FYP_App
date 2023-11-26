import 'package:flutter/material.dart';

class StudentAttendancePage extends StatelessWidget {
  final String username;

  StudentAttendancePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Page'),
      ),
      body: Center(
        child: Text('Welcome to the Attendance Page, $username!'),
      ),
    );
  }
}
