import 'package:flutter/material.dart';

class StudentFeePage extends StatelessWidget {
  final String username;

  StudentFeePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Fee'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Student Fee Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add your student fee content here
          ],
        ),
      ),
    );
  }
}
