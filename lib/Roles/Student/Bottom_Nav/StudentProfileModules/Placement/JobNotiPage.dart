import 'package:flutter/material.dart';

class JobNotiPage extends StatelessWidget {
  final String username;

  JobNotiPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noti Page'),
      ),
      body: Center(
        child: Text('Welcome to the Noti Page, $username!'),
      ),
    );
  }
}
