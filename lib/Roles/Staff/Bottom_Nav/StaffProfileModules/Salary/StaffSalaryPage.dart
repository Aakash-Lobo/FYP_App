import 'package:flutter/material.dart';

class StaffSalaryPage extends StatelessWidget {
  final String username;

  StaffSalaryPage({required this.username});

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
