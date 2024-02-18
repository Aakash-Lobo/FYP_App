import 'package:flutter/material.dart';

class TeacherSalaryPage extends StatelessWidget {
  final String username;

  TeacherSalaryPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counselling Page'),
      ),
      body: Center(
        child: Text('Welcome to the Counselling Page, $username!'),
      ),
    );
  }
}
