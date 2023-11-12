import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  final String username;

  InboxPage({required this.username}); // Constructor to receive the username

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Inbox',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'User username: $username', // Display the user's username
              style: TextStyle(fontSize: 16),
            ),
            // Add your inbox content here
          ],
        ),
      ),
    );
  }
}
