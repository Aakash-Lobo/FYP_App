import 'package:flutter/material.dart';

class CompanyPage extends StatelessWidget {
  final String username;

  CompanyPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Page'),
      ),
      body: Center(
        child: Text('Welcome to the Noti Page, $username!'),
      ),
    );
  }
}
