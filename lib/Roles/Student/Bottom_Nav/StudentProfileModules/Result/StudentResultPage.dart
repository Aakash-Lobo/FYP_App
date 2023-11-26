import 'package:flutter/material.dart';

class StudentResultPage extends StatelessWidget {
  final String username;

  StudentResultPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
      ),
      body: Center(
        child: Text('Welcome to the Result Page, $username!'),
      ),
    );
  }
}
