import 'package:flutter/material.dart';

class AddRoomPage extends StatelessWidget {
  final String username;

  AddRoomPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Room'),
      ),
      body: Center(
        child: Text('Welcome to the Add Room, $username!'),
      ),
    );
  }
}
