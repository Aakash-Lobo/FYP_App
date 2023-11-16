import 'package:flutter/material.dart';

class LibrarianSettingsPage extends StatelessWidget {
  final String username;

  LibrarianSettingsPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Dummy'), // Replace with your content
      ),
    );
  }
}
