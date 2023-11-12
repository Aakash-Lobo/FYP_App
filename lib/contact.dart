import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  final String username;

  ContactPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Contact Page Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Username: $username', // Display the user's username
              style: TextStyle(fontSize: 16),
            ),
            // Add contact page content here
          ],
        ),
      ),
    );
  }
}
