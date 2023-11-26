import 'package:flutter/material.dart';

class StudentFeesPage extends StatelessWidget {
  final String username;

  StudentFeesPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees Page'),
      ),
      body: Center(
        child: Text('Welcome to the Fees Page, $username!'),
      ),
    );
  }
}
