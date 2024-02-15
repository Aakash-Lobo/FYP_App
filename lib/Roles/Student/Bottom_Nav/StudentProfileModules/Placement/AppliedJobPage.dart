import 'package:flutter/material.dart';

class AppliedJobPage extends StatelessWidget {
  final String username;

  AppliedJobPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applied Page'),
      ),
      body: Center(
        child: Text('Welcome to the Applied Page, $username!'),
      ),
    );
  }
}
