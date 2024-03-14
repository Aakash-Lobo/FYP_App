import 'package:flutter/material.dart';

class TeacherNotesPage extends StatelessWidget {
  final String username;

  TeacherNotesPage({required this.username});

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
