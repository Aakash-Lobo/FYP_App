import 'package:flutter/material.dart';

class StudentCoursesPage extends StatelessWidget {
  final String username;

  StudentCoursesPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses Page'),
      ),
      body: Center(
        child: Text('Welcome to the Courses Page, $username!'),
      ),
    );
  }
}
