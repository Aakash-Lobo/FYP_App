import 'package:flutter/material.dart';

class ViewNoticePage extends StatelessWidget {
  final String username;

  ViewNoticePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Menu'),
      ),
      body: Center(
        child: Text('Welcome to the Order Page, $username!'),
      ),
    );
  }
}