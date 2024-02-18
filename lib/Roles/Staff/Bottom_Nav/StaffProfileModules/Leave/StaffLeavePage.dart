import 'package:flutter/material.dart';

class StaffLeavePage extends StatelessWidget {
  final String username;

  StaffLeavePage({required this.username});

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
