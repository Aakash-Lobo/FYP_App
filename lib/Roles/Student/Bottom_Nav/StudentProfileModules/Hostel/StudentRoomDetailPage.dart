import 'package:flutter/material.dart';

class StudentRoomDetailPage extends StatelessWidget {
  final String username;

  StudentRoomDetailPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Detail Page'),
      ),
      body: Center(
        child: Text('Welcome to the Room Detail Page, $username!'),
      ),
    );
  }
}
