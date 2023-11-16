import 'package:flutter/material.dart';

class LibrarianUsersPage extends StatelessWidget {
  final String username;

  LibrarianUsersPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Center(
        child: Text('Dummy'), // Replace with your content
      ),
    );
  }
}
