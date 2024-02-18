import 'package:flutter/material.dart';

class AssignSubjectsPage extends StatelessWidget {
  final String username;

  AssignSubjectsPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Subjects'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Assign Subjects Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add your assign subjects content here
          ],
        ),
      ),
    );
  }
}
