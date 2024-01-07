import 'package:flutter/material.dart';

class ViewMenuPage extends StatelessWidget {
  final String username;

  ViewMenuPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Menu'),
      ),
      body: Center(
        child: Text('Welcome to the Order Page, $username!'),
      ),
    );
  }
}
