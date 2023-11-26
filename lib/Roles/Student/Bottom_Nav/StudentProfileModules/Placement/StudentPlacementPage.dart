import 'package:flutter/material.dart';

class StudentPlacementPage extends StatelessWidget {
  final String username;

  StudentPlacementPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placement Page'),
      ),
      body: Center(
        child: Text('Welcome to the Placement Page, $username!'),
      ),
    );
  }
}
