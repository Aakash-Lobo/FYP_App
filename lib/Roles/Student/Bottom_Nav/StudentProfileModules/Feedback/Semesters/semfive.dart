import 'package:flutter/material.dart';

class SemesterFiveFeedBack extends StatelessWidget {
  final String username;

  SemesterFiveFeedBack({required this.username});

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
