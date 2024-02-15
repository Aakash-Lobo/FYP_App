import 'package:flutter/material.dart';

class StudentExamFeedbackPage extends StatelessWidget {
  final String username;

  StudentExamFeedbackPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Detail Page'),
      ),
      body: Center(
        child: Text('Welcome to the Room Detail Page, $username!'),
      ),
    );
  }
}
