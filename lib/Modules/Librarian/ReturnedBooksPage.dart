import 'package:flutter/material.dart';

class ReturnedBooksPage extends StatelessWidget {
  final String username;

  ReturnedBooksPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Returned Books'),
      ),
      body: Center(
        child: Text('Dummy'), // Replace with your content
      ),
    );
  }
}
