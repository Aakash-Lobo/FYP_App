import 'package:flutter/material.dart';

class StudentFeedbackPage extends StatelessWidget {
  final String username;

  StudentFeedbackPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Page'),
      ),
      body: Center(
        child: Text('Welcome to the Feedback Page, $username!'),
      ),
    );
  }
}
