import 'package:flutter/material.dart';

class CompanyMessage extends StatelessWidget {
  final String username;

  CompanyMessage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Page'),
      ),
      body: Center(
        child: Text('Welcome to the Noti Page, $username!'),
      ),
    );
  }
}
